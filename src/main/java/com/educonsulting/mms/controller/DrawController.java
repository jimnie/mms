package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Deposit;
import com.educonsulting.mms.entity.Draw;
import com.educonsulting.mms.entity.Handover;
import com.educonsulting.mms.entity.Shelf;
import com.educonsulting.mms.service.*;
import com.educonsulting.mms.util.Constants;
import com.educonsulting.mms.util.ImageGenerator;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/draw")
public class DrawController extends BaseController {

    private static final Logger logger = LogManager.getLogger(DrawController.class);

    @Resource(name = "drawServiceImpl")
    private DrawService drawService;

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @Resource(name = "handoverServiceImpl")
    private HandoverService handoverService;

    @Resource(name = "depositServiceImpl")
    private DepositService depositService;

    @Resource(name = "shelfServiceImpl")
    private ShelfService shelfService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
//        Subject subject = SecurityUtils.getSubject();
//        if (subject.isPermitted("act:view")) {
//            return "/act/index";
//        } else {
//            throw new UnauthorizedException();
//        }
        return "/draw/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/draw/query";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "serviceNo", required = false) String serviceNo,
                       @RequestParam(value = "dpName", required = false) String dpName) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(serviceNo)) {
            filters.add(Filter.eq("serviceNo", serviceNo));
        }
        if (StringUtils.isNotEmpty(dpName)) {
            filters.add(Filter.like("dpName", dpName));
        }
        pageable.setFilters(filters);
        Page<Draw> drawPage = drawService.findPage(pageable);
        return getPageResultMap(drawPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Message save(Draw draw) {
        if (drawService.isServiceNoExist(draw.getServiceNo())) {
            return Message.error("服务编号已存在");
        }
        DateTime dateTime = new DateTime();
        String name = userService.getCurrent().getName();

        Deposit dPers = depositService.find(draw.getdId());
        Deposit deposit = new Deposit();
        BeanUtils.copyProperties(dPers, deposit);
        deposit.setDrawDate(dateTime.toDate());
        deposit.setUpdatedBy(name);
        deposit.setStatus(1);

        Handover hPers = handoverService.find(draw.gethId());
        Handover handover = new Handover();
        BeanUtils.copyProperties(hPers, handover);
        handover.setDrawDate(dateTime.toDate());
        handover.setDrawAgent(name);
        handover.setStatus(1);

        Shelf sPers = shelfService.findShelfByCode(handover.getPosition());
        Shelf shelf = new Shelf();
        BeanUtils.copyProperties(sPers, shelf);
        shelf.setStatus(0);

        String webRoot = System.getProperty("webapp.root");
        // 收存操作员
        draw.setCreatedBy(name);

        String fileName = UUID.randomUUID().toString() + Constants.PIC_TYPE_JPG;
        String jpgPath = webRoot + Constants.GENERATE_PIC_PATH + fileName;
        boolean succ = ImageGenerator.generateImage(draw.getSignPic(), jpgPath);
        draw.setSignPic(fileName);

        // 按服务编号创建目录名称
        String pdfPath = webRoot + Constants.GENERATE_PDF_PATH + draw.getServiceNo();
        File file = new File(pdfPath);
        if (!file.exists()) {
            file.mkdir();
        }

        shelfService.update(shelf);
        depositService.update(deposit);
        handoverService.update(handover);
        drawService.save(draw);

        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/viewPdf/{serviceNo}/type/{type}", method = RequestMethod.GET, produces = "application/pdf")
    public void viewCertPdf(HttpServletRequest request,
                            HttpServletResponse response,
                            @PathVariable String serviceNo,
                            @PathVariable String type) {
        String fileName = null;
        if (type.equals("cert")) {
            fileName = Constants.DRAW_CERT_PDF;
        } else if (type.equals("conf")) {
            fileName = Constants.PLACE_SERVICE_PDF;
        }
        String pdfPath = drawService.buildPdf(serviceNo, fileName, type);
        String webRoot = System.getProperty("webapp.root");
        Path file = Paths.get(webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\", fileName);
        try {
            if (Files.exists(file)) {
                response.setContentType("application/pdf");
                // 浏览器内打开
                response.addHeader("Content-Disposition", "inline; filename=" + URLEncoder.encode(serviceNo + "." + fileName, "utf-8").replaceAll("\\+", "%20"));
                // 浏览器内下载
//                response.addHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(serviceNo + "." + Constants.DEPOSIT_INVOICE_PDF, "utf-8").replaceAll("\\+", "%20"));

                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    @RequestMapping(value = "/exist", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object isServiceNoExist(@RequestParam(value = "sno", required = true) String sno) {
        boolean isExist = drawService.isServiceNoExist(sno);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", isExist);
        return jsonObject;
    }

    @RequestMapping(value = "/find", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object findDrawByServiceNo(@RequestParam(value = "sno", required = true) String sno) {
        List<Draw> drawList = drawService.findDepositByServiceNo(sno);
        JSONObject jsonObject = new JSONObject();
        if (drawList.size() == 1) {
            jsonObject = JSONObject.fromObject(drawList.get(0));
            jsonObject.put("result", true);
        } else {
            jsonObject.put("result", false);
        }
        return jsonObject;
    }

    @RequestMapping(value = "/isMatched", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object isMatched(@RequestParam(value = "sno", required = true) String sno,
                            @RequestParam(value = "rfid", required = true) String rfid) {
        logger.info("开始核对逝者信息");
        boolean exist = drawService.exists(Filter.eq("serviceNo", sno), Filter.eq("rfid", rfid));
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", exist);
        return jsonObject;
    }
}
