package com.educonsulting.mms.controller;

import com.educonsulting.mms.*;
import com.educonsulting.mms.entity.Authority;
import com.educonsulting.mms.entity.Resources;
import com.educonsulting.mms.entity.Role;
import com.educonsulting.mms.service.AuthorityService;
import com.educonsulting.mms.service.ResourceService;
import com.educonsulting.mms.service.RoleService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Wayne on 2015/7/14.
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Resource(name = "roleServiceImpl")
    private RoleService roleService;

    @Resource(name = "resourceServiceImpl")
    private ResourceService resourceService;

    @Resource(name = "authorityServiceImpl")
    private AuthorityService authorityService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/role/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/role/query";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Role role) {
        if (roleService.isTagNameExists(role.getTag())) {
            return Message.error("role.form.nameIsExist");
        }
        roleService.save(role);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        pageable.setFilters(filters);
        Page<Role> rolePage = roleService.findPage(pageable);
        return getPageResultMap(rolePage);
    }

    @RequestMapping(value = "/loadAllRoles", method = RequestMethod.GET)
    @ResponseBody
    public Object loadAllUsers() {
        List<Role> roles = roleService.findAll();
        return roles;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Role role) {
        roleService.update(role);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "roleId") String id) {
        roleService.delete(Long.valueOf(id));
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/saveRoleResources", method = RequestMethod.POST)
    @ResponseBody
    public Message saveRoleResources(@RequestParam(value = "r_roleid") String roleId,
                                     @RequestParam("r_resources") String resourceIds) {
        Role persistRole = roleService.find(Long.valueOf(roleId));
        persistRole.getResources().clear();
        if (StringUtils.isNotEmpty(resourceIds)) {
            for (String resourceId : resourceIds.split(",")) {
                Resources res = resourceService.find(Long.valueOf(resourceId));
                persistRole.getResources().add(res);
            }
        }
        roleService.update(persistRole);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/getResourceTree/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object getResourceTree(@PathVariable("id") String id) {
        List<TreeNode> tree = (List<TreeNode>) resourceService.getTree();
        List<TreeNode> cloneTree = new ArrayList<TreeNode>(tree);
        Collections.copy(cloneTree, tree);
        Role persistRole = roleService.find(Long.valueOf(id));
        if (CollectionUtils.isNotEmpty(persistRole.getResources())) {
            for (Resources resource : persistRole.getResources()) {
                setTreeNodeChecked(String.valueOf(resource.getId()), (List<TreeNode>) cloneTree);
            }
        }
        return cloneTree;
    }

    private void setTreeNodeChecked(String id, List<TreeNode> tree) {
        for (TreeNode treeNode : tree) {
            treeNode.setState("open");
            if (treeNode.getId().equals(String.valueOf(id))) {
                treeNode.setChecked(Boolean.TRUE);
            }
            if (treeNode instanceof BranchNode
                    && CollectionUtils.isNotEmpty(((BranchNode) treeNode).getChildren())) {
                setTreeNodeChecked(id, ((BranchNode) treeNode).getChildren());
            }
        }
    }

    @RequestMapping(value = "/findResources/{roleId}/type/{typeStr}", method = RequestMethod.GET)
    @ResponseBody
    public Object findResources(@PathVariable(value = "roleId") String id,
                                @PathVariable(value = "typeStr") String type) {
        Role role = roleService.find(Long.valueOf(id));
        Set<Resources> ownedResources = new HashSet<Resources>();
        for (Resources resource : role.getResources()) {
            if (resource.getResourceType().equals(type)) {
                ownedResources.add(resource);
            }
        }
        return ownedResources;
    }

    @RequestMapping(value = "/findResources/{roleId}/type/{typeStr}/parent/{pid}", method =
            RequestMethod.GET)
    @ResponseBody
    public Object findResources(@PathVariable(value = "roleId") String id,
                                @PathVariable(value = "typeStr") String type,
                                @PathVariable(value = "pid") String pid) {
        Role role = roleService.find(Long.valueOf(id));
        Set<Resources> ownedResources = new HashSet<Resources>();
        for (Resources resource : role.getResources()) {
            if (pid != null) {
                if (resource.getResourceType().equals(type)
                        && resource.getParent().getId().equals(pid)) {
                    ownedResources.add(resource);
                }
            }
        }
        return ownedResources;
    }

    @RequestMapping(value = "/saveResourceAuth", method = RequestMethod.POST)
    @ResponseBody
    public Message saveResourceAuth(@RequestParam(value = "inserted", required = false) String
                                            inserted,
                                    @RequestParam(value = "deleted", required = false) String
                                            deleted) {
        JSONArray insertedArrays = JSONArray.fromObject(inserted);
        JSONArray deletedArrays = JSONArray.fromObject(deleted);

        if (deletedArrays.size() > 0) {
            for (Object delJson : deletedArrays) {
                Authority delAuth = (Authority) JSONObject.toBean((JSONObject) delJson, Authority
                        .class);
                Authority persistAuth = authorityService.find(delAuth.getId());
                persistAuth.setRole(null);
                persistAuth.setResource(null);
                authorityService.delete(persistAuth);
            }
        }

        if (insertedArrays.size() > 0) {
            for (Object insJson : insertedArrays) {
                Authority insAuth = (Authority) JSONObject.toBean((JSONObject) insJson, Authority
                        .class);
                Role role = new Role();
                role.setId(insAuth.getRoleId());
                Resources resource = new Resources();
                resource.setId(insAuth.getResourceId());
                insAuth.setRole(role);
                insAuth.setResource(resource);
                authorityService.save(insAuth);
            }
        }
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/findResourceAuth/{menuId}/roleId/{roleId}", method = RequestMethod
            .GET)
    @ResponseBody
    public Object findResourceAuth(@PathVariable(value = "menuId") String menuId,
                                   @PathVariable(value = "roleId") String roleId) {
        Pageable pageable = new Pageable();
        List<Filter> filters = new ArrayList<Filter>();
        filters.add(Filter.eq("roleId", roleId));
        filters.add(Filter.eq("resourceId", menuId));
        pageable.setFilters(filters);
        Page<Authority> authPage = authorityService.findPage(pageable);
        return getPageResultMap(authPage);
    }
}
