package com.educonsulting.mms.controller;

import com.educonsulting.mms.CommonAttributes;
import com.educonsulting.mms.JsonDateValueProcessor;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.entity.Resources;
import com.educonsulting.mms.service.ResourceService;
import com.educonsulting.mms.util.DatePattern;
import com.educonsulting.mms.util.DateUtils;
import com.educonsulting.mms.util.SpringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Wayne on 2015/7/12.
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController {

    @Resource(name = "resourceServiceImpl")
    private ResourceService resourceService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/resource/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list() {
        Resources resource = resourceService.find(CommonAttributes.RESOURCE_ROOT_ID);
        List<Resources> list = resource.getChildren();
        String[] excludes = {"children", "parent"};
        JSONArray jsonArray = getJsonArrayWithIgnoreFields(list, excludes);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(TOTAL_KEY, list.size());
        map.put(ROWS_KEY, jsonArray);
        return map;
    }

    @RequestMapping(value = "/query/{id}", method = RequestMethod.GET)
    @ResponseBody
    private Object query(@PathVariable String id) {
        Resources resource = resourceService.find(id);
        String[] excludes = new String[]{"children", "parent", "authorities"};
        List<Resources> list = resource.getChildren();
        for (Resources res : list) {
            if (res.getIsLeaf().equals("isleaf_01")) {
                excludes = new String[]{"children", "parent", "authorities", "state"};
                break;
            }
        }
        JSONArray jsonArray = getJsonArrayWithIgnoreFields(list, excludes);
        return jsonArray;
    }

    private JSONArray getJsonArrayWithIgnoreFields(List<Resources> resources, String...
            excludes) {
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(DateUtils
                .getDateStringByPattern(Calendar.getInstance().getTime(),
                        DatePattern.TIME_WITH_MINUS)));
        config.setIgnoreDefaultExcludes(false);
        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        config.setExcludes(excludes);
        JSONArray jsonArray = new JSONArray();
        for (Resources resource : resources) {
            JSONObject jsonObject = JSONObject.fromObject(resource, config);
            jsonObject.put("parentid", resource.getParent() != null ? resource.getParent()
                    .getId() : "");
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    @RequestMapping(value = "/tree", method = RequestMethod.GET)
    @ResponseBody
    public Object tree() {
        return resourceService.getTree();
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Resources resource) {
        if (resourceService.isAliasNameExists(resource.getAliasName())) {
            return Message.error(SpringUtils.getMessage("resource.head.isExist"));
        }
        resourceService.save(resource);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Resources resource) {
        resource.setState(CommonAttributes.MENU_CLOSED);
        resourceService.update(resource);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "resid") String id) {
        resourceService.delete(id);
        return SUCCESS_MESSAGE;
    }
}
