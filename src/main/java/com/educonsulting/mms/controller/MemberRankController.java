package com.educonsulting.mms.controller;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.MemberRank;
import com.educonsulting.mms.service.MemberRankService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller("memberRankController")
@RequestMapping("/rank")
public class MemberRankController extends BaseController {

    @Resource(name = "memberRankServiceImpl")
    private MemberRankService memberRankService;

    @RequestMapping(value = "/check_name", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkName(String previousName, String name) {
        if (StringUtils.isEmpty(name)) {
            return false;
        }
        if (memberRankService.nameUnique(previousName, name)) {
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping(value = "/check_amount", method = RequestMethod.GET)
    @ResponseBody
    public boolean checkAmount(BigDecimal previousAmount, BigDecimal amount) {
        if (amount == null) {
            return false;
        }
        if (memberRankService.amountUnique(previousAmount, amount)) {
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/rank/index";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(MemberRank memberRank) {
        if (memberRank.getIsDefault() == null) {
            memberRank.setIsDefault(false);
        }
        if (memberRank.getIsSpecial() == null) {
            memberRank.setIsSpecial(false);
        }
        if (!isValid(memberRank)) {
            return Message.error("rank.form.infoIncompletion");
        }
        if (memberRankService.nameExists(memberRank.getName())) {
            return Message.error("rank.form.nameExist");
        }
        if (memberRank.getIsSpecial()) {
            memberRank.setAmount(null);
        } else if (memberRank.getAmount() == null || memberRankService.amountExists(memberRank
                .getAmount())) {
            return Message.error("rank.form.amountExist");
        }
        memberRank.setMembers(null);
        memberRankService.save(memberRank);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Message update(MemberRank memberRank) {
        if (memberRank.getIsDefault() == null) {
            memberRank.setIsDefault(false);
        }
        if (memberRank.getIsSpecial() == null) {
            memberRank.setIsSpecial(false);
        }
        if (!isValid(memberRank)) {
            return Message.error("rank.form.infoIncompletion");
        }
        MemberRank pMemberRank = memberRankService.find(memberRank.getId());
        if (pMemberRank == null) {
            return Message.error("rank.form.rankNoExist");
        }
        if (!memberRankService.nameUnique(pMemberRank.getName(), memberRank.getName())) {
            return Message.error("rank.form.nameExist");
        }
        if (memberRank.getIsSpecial()) {
            memberRank.setAmount(null);
        } else if (memberRank.getAmount() == null || !memberRankService.amountUnique(pMemberRank
                .getAmount(), memberRank.getAmount())) {
            return Message.error("rank.form.amountExist");
        }
        memberRank.setCreateDate(pMemberRank.getCreateDate());
        memberRankService.update(memberRank, "members");
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
        Page<MemberRank> memberRankPage = memberRankService.findPage(pageable);
        return getPageResultMap(memberRankPage);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Message delete(@RequestParam(value = "rankId") String id) {
        if (StringUtils.isNotEmpty(id)) {
            Long aLong = Long.valueOf(id);
            MemberRank memberRank = memberRankService.find(aLong);
            if (memberRank != null && memberRank.getIsDefault()) {
                return Message.error("rank.form.deleteDefaultNotAllowed");
            }
            if (memberRank != null && memberRank.getMembers() != null && !memberRank
                    .getMembers().isEmpty()) {
                return Message.error("rank.form.deleteExistNotAllowed", memberRank
                        .getName());
            }
            memberRankService.delete(aLong);
        }
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/all", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object findAll() {
        List<MemberRank> memberRanks = memberRankService.findAll();
        Collections.reverse(memberRanks);
        return memberRanks;
    }

    @RequestMapping(value = "/default", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Object findDefault() {
        return memberRankService.findDefault();
    }
}