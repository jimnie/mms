package com.educonsulting.mms.controller;

import com.alibaba.fastjson.JSONObject;
import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Deposit;
import com.educonsulting.mms.service.DepositService;
import com.educonsulting.mms.service.UserService;
import com.educonsulting.mms.util.Constants;
import com.educonsulting.mms.util.ImageGenerator;
import org.apache.commons.lang.StringUtils;
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
@RequestMapping("/deposit")
public class DepositController extends BaseController {

    @Resource(name = "depositServiceImpl")
    private DepositService depositService;

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/deposit/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/deposit/query";
    }

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view() {
        return "/deposit/view";
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
    @Transactional
    public Message save(Deposit deposit) {
        if (depositService.isServiceNoExist(deposit.getServiceNo())) {
            return Message.error("服务编号已存在");
        }
        String webRoot = System.getProperty("webapp.root");
        deposit.setStatus(0); // 收存状态为已收存
        // 收存操作员
        deposit.setCreatedBy(userService.getCurrent().getName());

        String fileName = UUID.randomUUID().toString() + Constants.PIC_TYPE_JPG;
        String jpgPath = webRoot + Constants.GENERATE_PIC_PATH + fileName;
        boolean succ = ImageGenerator.generateImage(deposit.getSignPic(), jpgPath);
        deposit.setSignPic(fileName);
        // TODO: 领取操作员
        depositService.save(deposit);
        // 按服务编号创建目录名称
        String pdfPath = webRoot + Constants.GENERATE_PDF_PATH + deposit.getServiceNo();
        File file = new File(pdfPath);
        if (!file.exists()) {
            file.mkdir();
        }
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Deposit deposit) {
        depositService.update(deposit, "cartNo", "amount", "balance", "point", "registerDate");
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/findDepositByServiceNo/{serviceNo}", method = RequestMethod.GET)
    @ResponseBody
    public Object findDepositByServiceNo(@PathVariable String serviceNo) {
        List<Deposit> list = depositService.findDepositByServiceNo(serviceNo);
        return list;
    }

    @RequestMapping(value = "/viewPDF/{serviceNo}", method = RequestMethod.GET, produces = "application/pdf")
    public void viewPdf(HttpServletRequest request,
                        HttpServletResponse response,
                        @PathVariable String serviceNo) {
        String pdfPath = depositService.buildPdf(serviceNo);
        String webRoot = System.getProperty("webapp.root");
        Path file = Paths.get(webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\", Constants.DEPOSIT_INVOICE_PDF);
        try {
            if (Files.exists(file)) {
                response.setContentType("application/pdf");
                // 浏览器内打开
                response.addHeader("Content-Disposition", "inline; filename=" + URLEncoder.encode(serviceNo + "." + Constants.DEPOSIT_INVOICE_PDF, "utf-8").replaceAll("\\+", "%20"));
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
        boolean isExist = depositService.isServiceNoExist(sno);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", isExist);
        return jsonObject;
    }

}
