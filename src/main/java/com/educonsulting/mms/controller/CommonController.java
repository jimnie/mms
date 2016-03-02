package com.educonsulting.mms.controller;

import com.educonsulting.mms.service.MessageService;
import com.educonsulting.mms.service.RSAService;
import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.interfaces.RSAPublicKey;
import java.util.HashMap;
import java.util.Map;

@Controller("commonController")
@RequestMapping("/common")
public class CommonController implements ServletContextAware {

    @Resource(name = "messageServiceImpl")
    private MessageService messageService;
    @Resource(name = "rsaServiceImpl")
    private RSAService rsaService;

    private ServletContext servletContext;

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        return "/common/main";
    }

    @RequestMapping(value = "/public_key", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, String> publicKey(HttpServletRequest request) {
        RSAPublicKey publicKey = rsaService.generateKey(request);
        Map<String, String> data = new HashMap<String, String>();
        data.put("modulus", Base64.encodeBase64String(publicKey.getModulus().toByteArray()));
        data.put("exponent", Base64.encodeBase64String(publicKey.getPublicExponent().toByteArray
                ()));
        return data;
    }

    @RequestMapping("/error")
    public String error() {
        return "/common/error";
    }

    @RequestMapping("/unauthorized")
    public String unauthorized(HttpServletRequest request, HttpServletResponse response) {
        String requestType = request.getHeader("X-Requested-With");
        if (requestType != null && requestType.equalsIgnoreCase("XMLHttpRequest")) {
            response.addHeader("loginStatus", "unauthorized");
            try {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
        return "/common/unauthorized";
    }

}