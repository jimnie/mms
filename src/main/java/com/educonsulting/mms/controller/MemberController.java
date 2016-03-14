package com.educonsulting.mms.controller;

import com.educonsulting.mms.*;
import com.educonsulting.mms.entity.Member;
import com.educonsulting.mms.entity.ThemeCategory;
import com.educonsulting.mms.service.MemberRankService;
import com.educonsulting.mms.service.MemberService;
import com.educonsulting.mms.service.ThemeCategoryService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.math.BigDecimal;
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

    @Resource(name = "memberRankServiceImpl")
    private MemberRankService memberRankService;

    @Resource(name = "themeCategoryServiceImpl")
    private ThemeCategoryService themeCategoryService;

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
                       @RequestParam(value = "kidName", required = false) String kidName,
                       @RequestParam(value = "mobile", required = false) String mobile,
                       @RequestParam(value = "memberRankId", required = false) String
                               memberRankId) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(cardNo)) {
            filters.add(Filter.eq("cardNo", cardNo));
        }
        if (StringUtils.isNotEmpty(kidName)) {
            filters.add(Filter.eq("firstKidCnName", kidName));
        }
        if (StringUtils.isNotEmpty(mobile)) {
            filters.add(Filter.eq("mobile", mobile));
        }
        if (StringUtils.isNotEmpty(memberRankId)) {
            filters.add(Filter.eq("memberRank", memberRankService.find(memberRankId)));
        }
        pageable.setFilters(filters);
        Page<Member> memberPage = memberService.findPage(pageable);
        return getPageResultMap(memberPage);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Member member, @RequestParam(value = "activities") String str) {
        if (memberService.isCartNoAssigned(member.getCardNo())) {
            return Message.error("member.form.cardNoIsExist");
        }
        if (memberService.isMobileExisted(member.getMobile())) {
            return Message.error("member.form.mobileExist");
        }
        String[] ids = str.split(",");
        for (String id : ids) {
            ThemeCategory themeCategory = themeCategoryService.find(id);
            member.getCategories().add(themeCategory);
        }
        member.setPoint(CommonAttributes.DEFAULT_MEMBER_POINT);
        member.setBalance(BigDecimal.ZERO);
        member.setAmount(BigDecimal.ZERO);
        memberService.save(member);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(Member member, @RequestParam(value = "activities") String str) {
        if (memberService.isCartNoAssigned(member.getCardNo())) {
            return Message.error("member.form.cardNoIsExist");
        }
        if (memberService.isMobileExisted(member.getMobile())) {
            return Message.error("member.form.mobileExist");
        }
        String[] ids = str.split(",");
        for (String id : ids) {
            ThemeCategory themeCategory = themeCategoryService.find(id);
            member.getCategories().add(themeCategory);
        }
        memberService.update(member, "cartNo", "amount", "balance", "point", "registerDate");
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/member/query";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "memberId") String id) {
        memberService.delete(id);
        return SUCCESS_MESSAGE;
    }
}
