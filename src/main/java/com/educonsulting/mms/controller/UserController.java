package com.educonsulting.mms.controller;

import com.educonsulting.mms.*;
import com.educonsulting.mms.entity.User;
import com.educonsulting.mms.service.RoleService;
import com.educonsulting.mms.service.UserService;
import com.educonsulting.mms.util.JsonUtils;
import com.educonsulting.mms.util.SettingUtils;
import com.educonsulting.mms.util.SpringUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller("userController")
@RequestMapping("/user")
public class UserController extends BaseController {

    private static Logger logger = LoggerFactory.getLogger(UserController.class);

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @Resource(name = "roleServiceImpl")
    private RoleService roleService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/user/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "username", required = false) String username) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(username)) {
            filters.add(Filter.eq("username", username));
        }
        pageable.setFilters(filters);
        Page<User> userPage = userService.findPage(pageable);
        return getPageResultMap(userPage);
    }

    @RequestMapping(value = "/check_username", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkUsername(String username) {
        if (StringUtils.isEmpty(username)) {
            return false;
        }
        if (userService.usernameExists(username)) {
            return false;
        } else {
            return true;
        }
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/user/query";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(ModelMap model) {
        model.addAttribute("roles", roleService.findAll());
        return "/user/add";
    }

    @RequestMapping(value = "/find/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String find(@PathVariable("id") String id) {
        User user = userService.find(Long.valueOf(id));
        return JsonUtils.toJson(user);
    }

    @RequestMapping(value = "/loadAllUsers", method = RequestMethod.GET)
    @ResponseBody
    public Object loadAllUsers() {
        List<User> users = userService.findAll();
        return users;
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(User user) {
        if (userService.usernameExists(user.getUsername())) {
            return Message.error(SpringUtils.getMessage("user.head.isExist"));
        }
        if (StringUtils.isNotEmpty(user.getPassword())) {
            user.setPassword(DigestUtils.md5Hex(user.getPassword()));
        } else {
            Setting setting = SettingUtils.get();
            user.setPassword(DigestUtils.md5Hex(setting.getDefaultNewPassword()));
        }
        user.setIsSystem(false);
        user.setIsLocked(false);
        user.setLoginFailureCount(0);
        user.setLockedDate(null);
        user.setLoginDate(null);
        user.setLoginIp(null);
        userService.save(user);

        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/unlock", method = RequestMethod.POST)
    @ResponseBody
    public Message unlock(@RequestParam(value = "userId") String id) {
        User user = userService.find(Long.valueOf(id));
        user.setIsLocked(false);
        user.setLockedDate(null);
        user.setLoginFailureCount(0);
        userService.update(user);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/lock", method = RequestMethod.POST)
    @ResponseBody
    public Message lock(@RequestParam(value = "userId") String id) {
        User user = userService.find(Long.valueOf(id));
        user.setIsLocked(true);
        user.setLockedDate(new Date());
        userService.update(user);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String edit(String id, ModelMap model) {
        model.addAttribute("roles", roleService.findAll());
        model.addAttribute("user", userService.find(Long.valueOf(id)));
        return "/user/edit";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(User user) {
        User pUser = userService.find(user.getId());

        if (pUser == null) {
            return Message.error(SpringUtils.getMessage("user.head.isNotExist"));
        }
        if (user.getIsEnabled() == null) {
            user.setIsEnabled(false);
        }
        if (StringUtils.isNotEmpty(user.getPassword())) {
            user.setPassword(DigestUtils.md5Hex(user.getPassword()));
        } else {
            user.setPassword(pUser.getPassword());
        }
        String[] ignoreProps = {"password", "modifyDate", "isEnabled"};
        BeanUtils.copyProperties(pUser, user, ignoreProps);
        userService.update(user);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "userId") String[] ids) {
        if (ids.length >= userService.count()) {
            return Message.error("sys.common.deleteAllNotAllowed");
        }
        Long[] longs = new Long[ids.length];
        for (int i = 0; i < longs.length; i++) {
            longs[i] = Long.valueOf(ids[i]);
        }
        userService.delete(longs);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/reset", method = RequestMethod.POST)
    @ResponseBody
    public Message reset(@RequestParam(value = "userId") String id) {
        User user = userService.find(Long.valueOf(id));
        Setting setting = SettingUtils.get();
        user.setPassword(DigestUtils.md5Hex(setting.getDefaultNewPassword()));
        userService.update(user);
        return SUCCESS_MESSAGE;
    }

    //    @RequestMapping(value = "/list", method = RequestMethod.GET)
//    public String list(Pageable pageable, ModelMap model) {
//        model.addAttribute("pageNum", userService.findPage(pageable));
//        return "/user/user/list";
//    }

    //	@RequestMapping(value = "/save", method = RequestMethod.POST)
//	public String save(User user, Long[] roleIds, RedirectAttributes redirectAttributes) {
//		user.setRoles(new HashSet<Role>(roleService.findList(roleIds)));
//		if (!isValid(user, Save.class)) {
//			return ERROR_VIEW;
//		}
//		if (userService.usernameExists(user.getUsername())) {
//			return ERROR_VIEW;
//		}
//		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
//		user.setIsLocked(false);
//		user.setLoginFailureCount(0);
//		user.setLockedDate(null);
//		user.setLoginDate(null);
//		user.setLoginIp(null);
////		user.setOrders(null);
//		userService.save(user);
//		return "redirect:list.jhtml";
//	}
}