package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.RechargeLog;
import com.educonsulting.mms.service.RechargeLogService;
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
 * Created by Wayne on 2016/5/27.
 */
@Controller
@RequestMapping("/rechargelog")
public class RechargeLogController extends BaseController {

    @Resource(name = "rechargeLogServiceImpl")
    private RechargeLogService rechargeLogService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/rechargelog/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/rechargelog/query";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "cardNo", required = false) String cardNo,
                       @RequestParam(value = "name", required = false) String name,
                       @RequestParam(value = "mobile", required = false) String mobile,
                       @RequestParam(value = "beginDate", required = false) String beginDate,
                       @RequestParam(value = "endDate", required = false) String endDate,
                       @RequestParam(value = "type", required = false) String type) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(cardNo)) {
            filters.add(Filter.eq("cardNo", cardNo));
        }
        if (StringUtils.isNotEmpty(name)) {
            filters.add(Filter.eq("name", name));
        }
        if (StringUtils.isNotEmpty(mobile)) {
            filters.add(Filter.eq("mobile", mobile));
        }
        if (StringUtils.isNotEmpty(type)) {
            filters.add(Filter.eq("type", RechargeLog.Type.valueOf(type)));
        }
        pageable.setFilters(filters);
        Page<RechargeLog> memberPage = rechargeLogService.findPage(pageable);
        return getPageResultMap(memberPage);
    }

}
