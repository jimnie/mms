package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.ThemeCategory;
import com.educonsulting.mms.service.ThemeCategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2016/3/10.
 */
@Controller
@RequestMapping("/category")
public class ThemeCategoryController extends BaseController {

    @Resource(name = "themeCategoryServiceImpl")
    private ThemeCategoryService themeCategoryService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/category/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/category/query";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(ThemeCategory themeCategory) {
        if (themeCategoryService.isCategoryNameExists(themeCategory.getName())) {
            return Message.error("category.form.nameIsExist");
        }
        themeCategoryService.save(themeCategory);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(ThemeCategory themeCategory) {
        if (themeCategoryService.isCategoryNameExists(themeCategory.getName(),
                themeCategory.getId())) {
            return Message.error("category.form.nameIsExist");
        }
        themeCategoryService.update(themeCategory);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "categoryId") String id) {
        themeCategoryService.delete(id);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        pageable.setFilters(filters);
        Page<ThemeCategory> categoryPage = themeCategoryService.findPage(pageable);
        return getPageResultMap(categoryPage);
    }

}
