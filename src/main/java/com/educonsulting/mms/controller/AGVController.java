package com.educonsulting.mms.controller;

import com.educonsulting.mms.agv.AGVStatus;
import com.educonsulting.mms.service.AGVService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/agv")
public class AGVController extends BaseController {

    @Resource(name = "agvServiceImpl")
    private AGVService agvService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/agv/index";
    }

    @RequestMapping(value = "/toStation1", method = RequestMethod.GET)
    @ResponseBody
    public Object toStation1() {
        agvService.callAgvToStation1();
        return queryStatus();
    }

    @RequestMapping(value = "/toStation2", method = RequestMethod.GET)
    @ResponseBody
    public Object toStation2() {
        agvService.callAgvToStation2();
        return queryStatus();
    }

    @RequestMapping(value = "/queryStatus", method = RequestMethod.GET)
    @ResponseBody
    public Object queryStatus() {
        AGVStatus statusInf = agvService.queryAgvStatusInf();
        JSONObject jsonObject = new JSONObject();
        if (null != statusInf) {
            jsonObject.put("statusInf", statusInf);
        }
        return jsonObject;
    }

}
