package com.educonsulting.mms.controller;

import com.educonsulting.mms.JsonDateValueProcessor;
import com.educonsulting.mms.entity.Area;
import com.educonsulting.mms.service.AreaService;
import com.educonsulting.mms.service.UserService;
import com.educonsulting.mms.util.DatePattern;
import com.educonsulting.mms.util.DateTimeUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Wayne on 2016/3/9.
 */
@Controller("areaController")
@RequestMapping("/area")
public class AreaController extends BaseController {

    @Resource(name = "areaServiceImpl")
    private AreaService areaService;
    @Resource(name = "userServiceImpl")
    private UserService userService;

    @RequestMapping(value = "/findArea/{id}", method = {RequestMethod.GET, RequestMethod
            .POST})
    @ResponseBody
    public Object findArea(@PathVariable String id) {
        List<Area> areas = areaService.getAresByParent(Long.valueOf(id));
        JSONArray jsonArray = getJsonArrayWithIgnoreFields(areas);
        return jsonArray;
    }

    @RequestMapping(value = "/findRoots", method = {RequestMethod.GET, RequestMethod
            .POST})
    @ResponseBody
    public Object findRoots() {
        List<Area> areas = areaService.findRoots(null);
        JSONArray jsonArray = getJsonArrayWithIgnoreFields(areas);
        return jsonArray;
    }

    private JSONArray getJsonArrayWithIgnoreFields(List<Area> areas) {
        String[] excludes = new String[]{"children", "parent", "fullName", "treePath", "fullName"};
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor(DateTimeUtils
                .getDateStringByPattern(Calendar.getInstance().getTime(),
                        DatePattern.TIME_WITH_MINUS)));
        config.setIgnoreDefaultExcludes(false);
        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        config.setExcludes(excludes);
        JSONArray jsonArray = new JSONArray();
        for (Area area : areas) {
            JSONObject jsonObject = JSONObject.fromObject(area, config);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    @RequestMapping(value = "/areaManage", method = RequestMethod.GET)
    public String areaManage(HttpServletRequest request, HttpServletResponse response) throws
            Exception {
        if (userService.isPermitted("area:view")) {
            return "/area/areaManage";
        } else {
            throw new UnauthorizedException();
        }
    }
}
