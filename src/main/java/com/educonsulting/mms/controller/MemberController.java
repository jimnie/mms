package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Member;
import com.educonsulting.mms.service.MemberService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2016/3/7.
 */
@Controller
@RequestMapping("/member")
public class MemberController extends BaseController {

    @Resource(name = "memberServiceImpl")
    private MemberService memberService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/member/index";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "cardNo", required = false) String cardNo,
                       @RequestParam(value = "kidName", required = false) String kidName) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(cardNo)) {
            filters.add(Filter.eq("cardNo", cardNo));
        }
        if (StringUtils.isNotEmpty(kidName)) {
            filters.add(Filter.eq("firstKidCnName", kidName));
        }
        pageable.setFilters(filters);
        Page<Member> memberPage = memberService.findPage(pageable);
        return getPageResultMap(memberPage);
    }
}
