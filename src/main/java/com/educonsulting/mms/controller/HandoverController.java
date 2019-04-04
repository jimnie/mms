package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Handover;
import com.educonsulting.mms.entity.Shelf;
import com.educonsulting.mms.service.HandoverService;
import com.educonsulting.mms.service.ShelfService;
import com.educonsulting.mms.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/handover")
public class HandoverController extends BaseController {

    @Resource(name = "handoverServiceImpl")
    private HandoverService handoverService;

    @Resource(name = "shelfServiceImpl")
    private ShelfService shelfService;

    @Resource(name = "userServiceImpl")
    private UserService userService;


    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/handover/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/handover/query";
    }

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view() {
        return "/handover/view";
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
        Page<Handover> handoverPage = handoverService.findPage(pageable);
        return getPageResultMap(handoverPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Message save(Handover handover) {
        DateTime dateTime = new DateTime();
        Shelf persShelf = shelfService.findShelfByCode(handover.getPosition());// 获取货架编号
        Shelf shelf = new Shelf();
        BeanUtils.copyProperties(persShelf, shelf);
        shelf.setStatus(1);

        handover.setRcpDate(dateTime.toDateTime().toDate()); // 设置交接日期
        handover.setRcpAgent(userService.getCurrent().getName()); // 设置交接人
        handover.setStatus(0);
        handoverService.save(handover);
        shelfService.update(shelf);
        return SUCCESS_MESSAGE;
    }
}
