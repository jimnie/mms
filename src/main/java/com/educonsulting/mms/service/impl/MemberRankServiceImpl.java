package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.MemberRankDao;
import com.educonsulting.mms.entity.MemberRank;
import com.educonsulting.mms.service.MemberRankService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;

@Service("memberRankServiceImpl")
public class MemberRankServiceImpl extends BaseServiceImpl<MemberRank, String> implements
        MemberRankService {

    @Resource(name = "memberRankDaoImpl")
    private MemberRankDao memberRankDao;

    @Resource(name = "memberRankDaoImpl")
    public void setBaseDao(MemberRankDao memberRankDao) {
        super.setBaseDao(memberRankDao);
    }

    @Transactional(readOnly = true)
    public boolean nameExists(String name) {
        return memberRankDao.nameExists(name);
    }

    @Transactional(readOnly = true)
    public boolean nameUnique(String previousName, String currentName) {
        if (StringUtils.equalsIgnoreCase(previousName, currentName)) {
            return true;
        } else {
            if (memberRankDao.nameExists(currentName)) {
                return false;
            } else {
                return true;
            }
        }
    }

    @Transactional(readOnly = true)
    public boolean amountExists(BigDecimal amount) {
        return memberRankDao.amountExists(amount);
    }

    @Transactional(readOnly = true)
    public boolean amountUnique(BigDecimal previousAmount, BigDecimal currentAmount) {
        if (previousAmount != null && previousAmount.compareTo(currentAmount) == 0) {
            return true;
        } else {
            if (memberRankDao.amountExists(currentAmount)) {
                return false;
            } else {
                return true;
            }
        }
    }

    @Transactional(readOnly = true)
    public MemberRank findDefault() {
        return memberRankDao.findDefault();
    }

    @Transactional(readOnly = true)
    public MemberRank findByAmount(BigDecimal amount) {
        return memberRankDao.findByAmount(amount);
    }

}