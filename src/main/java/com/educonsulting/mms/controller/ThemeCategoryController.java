package com.educonsulting.mms.controller;

import com.educonsulting.mms.*;
import com.educonsulting.mms.entity.ThemeCategory;
import com.educonsulting.mms.service.ThemeCategoryService;
import com.educonsulting.mms.util.DatePattern;
import com.educonsulting.mms.util.DateTimeUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

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
        themeCategoryService.delete(Long.getLong(id));
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

    @RequestMapping(value = "/findAll", method = RequestMethod.POST)
    @ResponseBody
    public Object findAll() {
        List<ThemeCategory> categories = themeCategoryService.findAll();
        Collections.reverse(categories);
        return getJSONArrayFromAllCategories(categories);
    }

    private JSONArray getJSONArrayFromAllCategories(List<ThemeCategory> categories) {
        String[] excludes = new String[]{"createDate", "modifyDate", "memo", "members", "themes",
                "sortNo"};
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(DateTimeUtils
                .getDateStringByPattern(Calendar.getInstance().getTime(),
                        DatePattern.TIME_WITH_MINUS)));
        config.setIgnoreDefaultExcludes(false);
        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        config.setExcludes(excludes);
        JSONArray jsonArray = new JSONArray();
        for (ThemeCategory category : categories) {
            JSONObject jsonObject = JSONObject.fromObject(category, config);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }


}
