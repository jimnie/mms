package com.educonsulting.mms.controller;

import com.educonsulting.mms.entity.Shelf;
import com.educonsulting.mms.service.ShelfService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/shelf")
public class ShelfController extends BaseController {

    @Resource(name = "shelfServiceImpl")
    private ShelfService shelfService;

    @RequestMapping(value = "/idel", method = RequestMethod.GET)
    @ResponseBody
    public Object findIdelShelf() {
        List<Shelf> shelfList = shelfService.findIdelShelf(0);
        return shelfList;
    }

    @RequestMapping(value = "/usableShelf", method = RequestMethod.GET)
    @ResponseBody
    public Object findUsableShelf(@RequestParam(value = "code", required = false) String code) {
        Shelf shelf = shelfService.findShelfByCode(code);
        return shelf;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list() {
        List<Shelf> shelfList = shelfService.findIdelShelf(0);
        return shelfList;
    }
}
