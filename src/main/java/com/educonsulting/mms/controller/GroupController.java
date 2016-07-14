package com.educonsulting.mms.controller;

import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Group;
import com.educonsulting.mms.entity.Role;
import com.educonsulting.mms.entity.User;
import com.educonsulting.mms.service.GroupService;
import com.educonsulting.mms.service.RoleService;
import com.educonsulting.mms.service.UserService;
import com.educonsulting.mms.util.SpringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Wayne on 2015/7/7.
 */
@Controller
@RequestMapping("/group")
public class GroupController extends BaseController {

    @Resource(name = "groupServiceImpl")
    private GroupService groupService;

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @Resource(name = "roleServiceImpl")
    private RoleService roleService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order) {
        Pageable pageable = getPageable(rows, page, sort, order);
        Page<Group> groupPage = groupService.findPage(pageable);
        Map<String, Object> pageResultMap = getPageResultMap(groupPage);
        return pageResultMap;
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/group/index";
    }

    @RequestMapping(value = "/tree", method = RequestMethod.GET)
    @ResponseBody
    public Object tree() {
        return groupService.getTree();
    }

    @RequestMapping(value = "/find/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object find(@PathVariable("id") String id) {
        return groupService.find(Long.valueOf(id));
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Group group) {
        if (groupService.isTagNameExists(group.getTag())) {
            return Message.error(SpringUtils.getMessage("group.head.tagExist"));
        }
        groupService.save(group);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Group group) {
        groupService.update(group, "children", "users", "roles");
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseBody
    public Message delete(@RequestParam(value = "delGroupId") String id) {
        groupService.delete(Long.valueOf(id));
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/findParent/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object findParent(@PathVariable("id") String id) {
        Group group = groupService.find(Long.valueOf(id));
        return group.getParent();
    }

    @RequestMapping(value = "/getUsers/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object getUsers(@PathVariable("id") String id) {
        Group group = groupService.find(Long.valueOf(id));
        return group.getUsers();
    }

    @RequestMapping(value = "/saveUsers/{users}/groupid/{groupid}", method = {RequestMethod.GET,
            RequestMethod.POST})
    @ResponseBody
    public Message saveUsers(@PathVariable("users") String usersIds,
                             @PathVariable("groupid") String groupid) {
        Group persistGroup = groupService.find(Long.valueOf(groupid));
        persistGroup.getUsers().clear();
        if (!usersIds.equals("clear")) {
            String[] uids = usersIds.split(",");
            // TODO:要处理users为空字串的情况，没有办法解除全部的用户
            for (String uid : uids) {
                User persistUser = userService.find(Long.valueOf(uid));
                persistGroup.getUsers().add(persistUser);
            }
        }
        groupService.update(persistGroup);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/getRoles/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object getRoles(@PathVariable("id") String id) {
        Group group = groupService.findGroup(id);
        return group.getRoles();
    }

    @RequestMapping(value = "/saveRoles/{roles}/groupid/{groupid}", method = {RequestMethod.GET,
            RequestMethod.POST})
    @ResponseBody
    public Message saveRoles(@PathVariable("roles") String rolesIds,
                             @PathVariable("groupid") String groupid) {
        Group persistGroup = groupService.findGroup(groupid);
        persistGroup.getRoles().clear();
        if (!rolesIds.equals("clear")) {
            String[] rids = rolesIds.split(","); // TODO:要处理roles为空字串的情况，没有办法解除全部角色
            for (String rid : rids) {
                Role persistRole = roleService.find(Long.valueOf(rid));
                persistGroup.getRoles().add(persistRole);
            }

        }
        groupService.update(persistGroup);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/loadSelectableUsers/{groupid}", method = RequestMethod.GET)
    @ResponseBody
    public Object loadSelectableUsers(@PathVariable("groupid") String id) {
        List<User> allUsers = userService.findAll();
        Group group = groupService.find(Long.valueOf(id));
        List<User> selectedUsers = group.getUsers();
        List<User> selectableUsers = new ArrayList<User>();
        for (User user : allUsers) {
            if (user != null) {
                if (!isUserSelected(user, selectedUsers)) {
                    selectableUsers.add(user);
                }
            }
        }
        return selectableUsers;
    }

    private Boolean isUserSelected(User user, List<User> selectedUsers) {
        for (User selectedUser : selectedUsers) {
            if (user.getUsername().equals(selectedUser.getUsername())) {
                return true;
            }
        }
        return false;
    }

    @RequestMapping(value = "/loadSelectableRoles/{groupid}", method = RequestMethod.GET)
    @ResponseBody
    public Object loadSelectableRoles(@PathVariable("groupid") String id) {
        List<Role> allRoles = roleService.findAll();
        Group group = groupService.findGroup(id);

        List<Role> selectedRoles = group.getRoles();
        List<Role> selectableRoles = new ArrayList<Role>();
        for (Role role : allRoles) {
            if (role != null) {
                if (!isRoleSeleted(role, selectedRoles)) {
                    selectableRoles.add(role);
                }
            }
        }
        return selectableRoles;
    }

    private Boolean isRoleSeleted(Role role, List<Role> selectedRoles) {
        for (Role selectedRole : selectedRoles) {
            if (role.getTag().equals(selectedRole.getTag())) {
                return true;
            }
        }
        return false;
    }

}
