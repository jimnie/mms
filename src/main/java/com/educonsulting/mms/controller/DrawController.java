package com.educonsulting.mms.controller;

import com.educonsulting.mms.service.DrawService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;

@Controller
@RequestMapping("/draw")
public class DrawController extends BaseController {

    @Resource(name = "drawServiceImpl")
    private DrawService drawService;

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
}
