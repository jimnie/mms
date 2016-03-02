package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Dictionary;
import com.educonsulting.mms.service.DictionaryService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
@Controller
@RequestMapping("/dict")
public class DictionaryController extends BaseController {

    @Resource(name = "dictionaryServiceImpl")
    private DictionaryService dictionaryService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/dictionary/index";
    }

    @RequestMapping(value = "/queryPage", method = RequestMethod.GET)
    public String queryPage() {
        return "/dictionary/query";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Dictionary dict) {
        dictionaryService.save(dict);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Dictionary dict) {
        dictionaryService.update(dict);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "name", required = false) String name,
                       @RequestParam(value = "creator", required = false) String creator) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(name)) {
            filters.add(Filter.eq("nickname", name));
        }
        if (StringUtils.isNotEmpty(creator)) {
            filters.add(Filter.eq("creator", creator));
        }
        pageable.setFilters(filters);
        Page<Dictionary> dictionaryPage = dictionaryService.findPage(pageable);
        return getPageResultMap(dictionaryPage);
    }

    @RequestMapping(value = "/findDict/{fieldName}", method = {RequestMethod.GET, RequestMethod
            .POST})
    @ResponseBody
    public Object findDict(@PathVariable String fieldName) {
        List<Dictionary> dictionaries = dictionaryService.findDict(fieldName);
        return dictionaries;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "dictId") String[] ids) {
        if (ids.length >= dictionaryService.count()) {
            return Message.error("sys.common.deleteAllNotAllowed");
        }
        dictionaryService.delete(ids);
        return SUCCESS_MESSAGE;
    }


}
