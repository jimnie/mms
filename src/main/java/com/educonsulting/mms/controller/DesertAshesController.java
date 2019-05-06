package com.educonsulting.mms.controller;

import com.alibaba.fastjson.JSONObject;
import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.DesertAshes;
import com.educonsulting.mms.service.DesertAshesService;
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
@RequestMapping("/desert")
public class DesertAshesController extends BaseController {

    @Resource(name = "desertAshesServiceImpl")
    private DesertAshesService desertAshesService;

    @Resource(name = "userServiceImpl")
    private UserService userService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/desert/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/desert/query";
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
        Page<DesertAshes> desertAshesPage = desertAshesService.findPage(pageable);
        return getPageResultMap(desertAshesPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Message save(DesertAshes desertAshes) {
        if (desertAshesService.isServiceNoExist(desertAshes.getServiceNo())) {
            return Message.error("服务编号已存在");
        }
        String webRoot = System.getProperty("webapp.root");
        // 收存操作员
        desertAshes.setCreatedBy(userService.getCurrent().getName());

        String fileName = UUID.randomUUID().toString() + Constants.PIC_TYPE_JPG;
        String jpgPath = webRoot + Constants.GENERATE_PIC_PATH + fileName;
        boolean succ = ImageGenerator.generateImage(desertAshes.getSignPic(), jpgPath);
        desertAshes.setSignPic(fileName);
        // TODO: 领取操作员
        desertAshesService.save(desertAshes);
        // 按服务编号创建目录名称
        String pdfPath = webRoot + Constants.GENERATE_PDF_PATH + desertAshes.getServiceNo();
        File file = new File(pdfPath);
        if (!file.exists()) {
            file.mkdir();
        }
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/viewPDF/{serviceNo}", method = RequestMethod.GET, produces = "application/pdf")
    public void viewPdf(HttpServletRequest request,
                        HttpServletResponse response,
                        @PathVariable String serviceNo) {
        String pdfPath = desertAshesService.buildPdf(serviceNo);
        String webRoot = System.getProperty("webapp.root");
        Path file = Paths.get(webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\", Constants.GIVEUP_CONFIRM_PDF);
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
        boolean isExist = desertAshesService.isServiceNoExist(sno);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", isExist);
        return jsonObject;
    }
}
