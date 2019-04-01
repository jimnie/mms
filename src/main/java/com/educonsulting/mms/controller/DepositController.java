package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Deposit;
import com.educonsulting.mms.service.DepositService;
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
@RequestMapping("/deposit")
public class DepositController extends BaseController {

    @Resource(name = "depositServiceImpl")
    private DepositService depositService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/deposit/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/deposit/query";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "serviceNo", required = false) String serviceNo,
                       @RequestParam(value = "dpName", required = false) String dpName,
                       @RequestParam(value = "status", required = false) String status) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(serviceNo)) {
            filters.add(Filter.eq("serviceNo", serviceNo));
        }
        if (StringUtils.isNotEmpty(dpName)) {
            filters.add(Filter.like("dpName", dpName));
        }
        if (StringUtils.isNotEmpty(status)) {
            filters.add(Filter.eq("status", status));
        }
        pageable.setFilters(filters);
        Page<Deposit> depositPage = depositService.findPage(pageable);
        return getPageResultMap(depositPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Deposit deposit) {
        if (depositService.isServiceNoExist(deposit.getServiceNo())) {
            return Message.error("服务编号已存在");
        }
        deposit.setStatus(0); // 收存状态为已收存
        // TODO: 收存操作员
        // TODO: 领取操作员
        depositService.save(deposit);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Deposit deposit) {
        depositService.update(deposit, "cartNo", "amount", "balance", "point", "registerDate");
        return SUCCESS_MESSAGE;
    }
}
