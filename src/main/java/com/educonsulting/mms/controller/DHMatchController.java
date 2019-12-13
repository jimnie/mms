package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.DHMatch;
import com.educonsulting.mms.service.DHMatchService;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller("dhMatchController")
@RequestMapping("/dhmatch")
public class DHMatchController extends BaseController {

    private static final Logger logger = LogManager.getLogger(DHMatchController.class);

    @Resource(name = "dhMatchServiceImpl")
    private DHMatchService dhMatchService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/dhmatch/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String queryPage() {
        return "/dhmatch/query";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "serviceNo2", required = false) String serviceNo,
                       @RequestParam(value = "dpName", required = false) String dpName) {
//        List<DHMatch> list = dhMatchService.findDHMatch(serviceNo, dpName);
//        return list;
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(serviceNo)) {
            filters.add(Filter.eq("serviceNo", serviceNo));
        }
        if (StringUtils.isNotEmpty(dpName)) {
            filters.add(Filter.like("dpName", dpName));
        }
        pageable.setFilters(filters);
        Page<DHMatch> dhMatchPage = dhMatchService.findPage(pageable);
        return getPageResultMap(dhMatchPage);
    }

    @RequestMapping(value = "/isMatched", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object isMatched(@RequestParam(value = "sno", required = true) String sno,
                            @RequestParam(value = "rfid", required = true) String rfid) {
        logger.info("开始核对逝者信息");
        boolean exist = dhMatchService.exists(Filter.eq("serviceNo", sno), Filter.eq("rfid", rfid));
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", exist);
        return jsonObject;
    }
}
