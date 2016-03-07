package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.MemberRank;

import java.math.BigDecimal;

public interface MemberRankDao extends BaseDao<MemberRank, String> {

    boolean nameExists(String name);

    boolean amountExists(BigDecimal amount);

    MemberRank findDefault();

    MemberRank findByAmount(BigDecimal amount);

}