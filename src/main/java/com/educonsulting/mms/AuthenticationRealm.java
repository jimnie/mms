package com.educonsulting.mms;

import com.educonsulting.mms.Setting.AccountLockType;
import com.educonsulting.mms.entity.Group;
import com.educonsulting.mms.entity.Resources;
import com.educonsulting.mms.entity.Role;
import com.educonsulting.mms.entity.User;
import com.educonsulting.mms.service.UserService;
import com.educonsulting.mms.util.SettingUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class AuthenticationRealm extends AuthorizingRealm {

    @Resource(name = "userServiceImpl")
    private UserService userService;

    List<Resources> navs = new ArrayList<Resources>();
    List<Resources> modules = new ArrayList<Resources>();
    List<Resources> menus = new ArrayList<Resources>();

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
            throws AuthenticationException {
        UserLoginToken loginToken = (UserLoginToken) authenticationToken;
        String username = loginToken.getUsername();
        String password = new String(loginToken.getPassword());
        String ip = loginToken.getHost();
        if (username != null && password != null) {
            User user = userService.findByUsername(username);
            if (user == null) {
                throw new UnknownAccountException();
            }
            if (!user.getIsEnabled()) {
                throw new DisabledAccountException();
            }
            Setting setting = SettingUtils.get();
            if (user.getIsLocked()) {
                if (ArrayUtils.contains(setting.getAccountLockTypes(), AccountLockType.user)) {
                    int loginFailureLockTime = setting.getAccountLockTime();
                    if (loginFailureLockTime == 0) {
                        throw new LockedAccountException();
                    }
                    Date lockedDate = user.getLockedDate();
                    Date unlockDate = DateUtils.addMinutes(lockedDate, loginFailureLockTime);
                    if (new Date().after(unlockDate)) {
                        user.setLoginFailureCount(0);
                        user.setIsLocked(false);
                        user.setLockedDate(null);
                        userService.update(user);
                    } else {
                        throw new LockedAccountException();
                    }
                } else {
                    user.setLoginFailureCount(0);
                    user.setIsLocked(false);
                    user.setLockedDate(null);
                    userService.update(user);
                }
            }
            if (!DigestUtils.md5Hex(password).equals(user.getPassword())) {
                int loginFailureCount = user.getLoginFailureCount() + 1;
                if (loginFailureCount >= setting.getAccountLockCount()) {
                    user.setIsLocked(true);
                    user.setLockedDate(new Date());
                }
                user.setLoginFailureCount(loginFailureCount);
                userService.update(user);
                throw new IncorrectCredentialsException();
            }

            navs.clear();
            modules.clear();
            menus.clear();
            for (Group group : user.getGroups()) {
                for (Role role : group.getRoles()) {
                    for (Resources resource : role.getResources()) {
                        if (resource.getResourceType().equals(CommonAttributes.RESOURCE_TYPE_NAV)) {
                            if (!navs.contains(resource)) {
                                navs.add(resource);
                            }
                        } else if (resource.getResourceType().equals(CommonAttributes
                                .RESOURCE_TYPE_MOD)) {
                            if (!modules.contains(resource)) {
                                modules.add(resource);
                            }
                        } else if (resource.getResourceType().equals(CommonAttributes
                                .RESOURCE_TYPE_MENU)) {
                            if (!menus.contains(resource)) {
                                menus.add(resource);
                            }
                        }
                    }
                }
            }
            JSONObject navsJsonObject = getNavsJson(navs);
            JSONObject mappingJsonObject = new JSONObject();
            for (Resources navRes : navs) {
                mappingJsonObject.put(navRes.getAliasName(), getSerializedJson(navRes.getChildren
                        ()));
            }

            Session session = SecurityUtils.getSubject().getSession();
            session.setAttribute(CommonAttributes.MAIN_PAGE_NAVS_KEY, navsJsonObject.toString());
            session.setAttribute(CommonAttributes.NAVS_MODULES_MAPPING_KEY, mappingJsonObject
                    .toString());

            user.setLoginIp(ip);
            user.setLoginDate(new Date());
            user.setLoginFailureCount(0);
            userService.update(user);
            return new SimpleAuthenticationInfo(new Principal(user.getId(), username), password,
                    getName());
        }
        throw new UnknownAccountException();
    }

    private JSONArray getSerializedJson(List<Resources> resources) {
        JSONArray items = new JSONArray();
        Collections.sort(resources);
        for (Resources resource : resources) {
            if (modules.contains(resource) || menus.contains(resource)) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put(CommonAttributes.NAV_JSON_ATTR_MENUID, resource.getId());
                jsonObject.put(CommonAttributes.NAV_JSON_ATTR_MENUNAME, resource.getText());
                jsonObject.put(CommonAttributes.NAV_JSON_ATTR_ICON, resource.getIcon());
                if (resource.getResourceType().equals(CommonAttributes.RESOURCE_TYPE_MENU)) {
                    jsonObject.put(CommonAttributes.NAV_JSON_ATTR_URL, resource.getUrl());
                } else if (resource.getResourceType().equals(CommonAttributes.RESOURCE_TYPE_MOD)) {
                    jsonObject.put(CommonAttributes.NAV_JSON_ATTR_MENUS, getSerializedJson
                            (resource.getChildren()));
                }
                items.add(jsonObject);
            }
        }
        return items;
    }

    private JSONObject getNavsJson(List<Resources> navs) {
        JSONObject allNav = new JSONObject();
        JSONArray navArr = new JSONArray();
        for (int i = CommonAttributes.ARRAYS_INDEX_FIRST; i < navs.size(); i++) {
            Resources resource = navs.get(i);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(CommonAttributes.MAIN_PAGE_NAV_NAME, resource.getAliasName());
            jsonObject.put(CommonAttributes.MAIN_PAGE_NAV_TITLE, resource.getText());
            if (i == CommonAttributes.ARRAYS_INDEX_FIRST) {
                jsonObject.put(CommonAttributes.MAIN_PAGE_NAV_CLASS_ATTR, CommonAttributes
                        .MAIN_PAGE_NAV_ACTIVE);
            }
            navArr.add(jsonObject);
        }
        allNav.put(CommonAttributes.MAIN_PAGE_NAVS_KEY, navArr);
        return allNav;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Principal principal = (Principal) principals.fromRealm(getName()).iterator().next();
        if (principal != null) {
            List<String> authorities = userService.findAuthorities(principal.getId());
            if (authorities != null) {
                SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
                authorizationInfo.addStringPermissions(authorities);
                return authorizationInfo;
            }
        }
        return null;
    }

}