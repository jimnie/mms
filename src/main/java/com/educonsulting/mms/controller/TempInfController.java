package com.educonsulting.mms.controller;

import com.educonsulting.mms.entity.TempInf;
import com.educonsulting.mms.service.TempInfService;
import net.sf.json.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/tmp")
public class TempInfController extends BaseController {

    private static final Logger logger = LogManager.getLogger(TempInfController.class);

    @Resource(name = "tempInfServiceImpl")
    private TempInfService tempInfService;

    @RequestMapping(value = "/queryInf", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findTempInfByServiceNo(@RequestParam(value = "sno", required = true) String serviceNo) {
        logger.info("查询业务登记信息:" + serviceNo);
        JSONObject jsonObject = null;
        boolean sNoExist = tempInfService.isServiceNoExist(serviceNo);
        if (sNoExist) {
            TempInf tempInf = tempInfService.findByServiceNo(serviceNo);
            jsonObject = JSONObject.fromObject(tempInf);
            logger.info("业务登记信息:" + jsonObject.toString());
        } else {
            jsonObject = new JSONObject();
            logger.info("业务登记信息不存在:" + serviceNo);
        }

        jsonObject.put("result", sNoExist);
        return jsonObject;
    }

    @RequestMapping(value = "/queryRfid", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findTempInfByRfid(@RequestParam(value = "rfid", required = true) String rfid) {
        logger.info("查询业务登记信息 -> RFID:" + rfid);
        JSONObject jsonObject = null;
        boolean sNoExist = tempInfService.isRfidNoExist(rfid);
        if (sNoExist) {
            TempInf tempInf = tempInfService.findByRfidNo(rfid);
            jsonObject = JSONObject.fromObject(tempInf);
            logger.info("业务登记信息 -> RFID:" + jsonObject.toString());
        } else {
            jsonObject = new JSONObject();
            logger.info("业务登记信息不存在 -> RFID:" + rfid);
        }

        jsonObject.put("result", sNoExist);
        return jsonObject;
    }
}
