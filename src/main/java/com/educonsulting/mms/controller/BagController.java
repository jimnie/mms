package com.educonsulting.mms.controller;

import com.alibaba.fastjson.JSONObject;
import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Bag;
import com.educonsulting.mms.service.BagService;
import com.educonsulting.mms.service.UserService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/bag")
public class BagController extends BaseController {

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @Resource(name = "bagServiceImpl")
    private BagService bagService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/bag/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/bag/query";
    }

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view() {
        return "/bag/view";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "serviceNo", required = false) String serviceNo,
                       @RequestParam(value = "utName", required = false) String utName) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(serviceNo)) {
            filters.add(Filter.eq("serviceNo", serviceNo));
        }
        if (StringUtils.isNotEmpty(utName)) {
            filters.add(Filter.like("utName", utName));
        }
        pageable.setFilters(filters);
        Page<Bag> drawBagPage = bagService.findPage(pageable);
        return getPageResultMap(drawBagPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Bag bag) {
        String webRoot = System.getProperty("webapp.root");
        // 发袋操作员
        bag.setCreatedBy(userService.getCurrent().getName());
        bag.setStatus(0);
        bagService.save(bag);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/findBag", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findBagByDpCertNo(@RequestParam(value = "certNo", required = true) String dpCertNo) {
        List<Bag> bagList = bagService.findBagByDpCertNo(dpCertNo);
        JSONObject jsonObject = new JSONObject();
        if (CollectionUtils.isNotEmpty(bagList)) {
            jsonObject.put("result", bagList.get(0));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/findBagWithStatus", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findBagByDpCertNoWithStatus(@RequestParam(value = "certNo", required = true) String dpCertNo,
                                              @RequestParam(value = "findBagWithServiceNo", required = true) Integer status) {
        List<Bag> bagList = bagService.findBagByDpCertNoAndStatus(dpCertNo, status);
        JSONObject jsonObject = new JSONObject();
        if (CollectionUtils.isNotEmpty(bagList)) {
            jsonObject.put("result", bagList.get(0));
        }
        return jsonObject;
    }

    @RequestMapping(value = "/findBagWithServiceNo", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findBagWithServiceNo(@RequestParam(value = "serviceNo", required = true) String serviceNo) {
        List<Bag> bagList = bagService.findBagByServiceNo(serviceNo);
        JSONObject jsonObject = new JSONObject();
        if (CollectionUtils.isNotEmpty(bagList)) {
            jsonObject.put("result", bagList.get(0));
        }
        return jsonObject;
    }
}
