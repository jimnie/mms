package com.rcbank.mms.controller;

import com.rcbank.mms.Filter;
import com.rcbank.mms.Message;
import com.rcbank.mms.Page;
import com.rcbank.mms.Pageable;
import com.rcbank.mms.entity.Act;
import com.rcbank.mms.service.ActService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/16.
 */
@Controller
@RequestMapping("/act")
public class ActController extends BaseController {

    @Resource(name = "actServiceImpl")
    private ActService actService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
//        Subject subject = SecurityUtils.getSubject();
//        if (subject.isPermitted("act:view")) {
//            return "/act/index";
//        } else {
//            throw new UnauthorizedException();
//        }
        return "/act/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/act/query";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       Act act) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(act.getName())) {
            filters.add(Filter.eq("name", act.getName()));
        }
        if (StringUtils.isNotEmpty(act.getEnName())) {
            filters.add(Filter.eq("enName", act.getEnName()));
        }
        if (StringUtils.isNotEmpty(act.getStatus())) {
            filters.add(Filter.eq("status", act.getStatus()));
        }
        pageable.setFilters(filters);
        Page<Act> actPage = actService.findPage(pageable);
        return getPageResultMap(actPage);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "actid") String id) {
        actService.delete(Long.valueOf(id));
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Act act) {
        if (actService.isAliasExists(act.getEnName())) {
            return Message.error("操作标识符已经存在！");
        }
        actService.save(act);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Act act) {
        actService.update(act);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/getAllActs")
    @ResponseBody
    public String getActs() {
        List<Act> acts = actService.findAll();
        JSONArray jsonArray = new JSONArray();
        jsonArray.add(getActsHeader());
        for (Act act : acts) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("dataAlign", "center");
            jsonObject.put("headerAlign", "center");
            jsonObject.put("width", 100);
            jsonObject.put("checkbox", true);
            jsonObject.put("dataField", act.getEnName());
            jsonObject.put("headerText", act.getName());
            jsonObject.put("handler", "checkbox");
            jsonArray.add(jsonObject);
        }
        return jsonArray.toString();
    }

    private JSONObject getActsHeader() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("dataAlign", "center");
        jsonObject.put("headerAlign", "center");
        jsonObject.put("width", 100);
        jsonObject.put("checkbox", true);
        jsonObject.put("dataField", "text");
        jsonObject.put("headerText", "资源名称");
        jsonObject.put("handler", "customResName");
        return jsonObject;
    }

    @RequestMapping(value = "/loadActs", method = RequestMethod.GET)
    @ResponseBody
    private Object findAll() {
        return actService.findAll();
    }

}
