package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.MemberRank;

import java.math.BigDecimal;

public interface MemberRankService extends BaseService<MemberRank, String> {

    boolean nameExists(String name);

    boolean nameUnique(String previousName, String currentName);

    boolean amountExists(BigDecimal amount);

    boolean amountUnique(BigDecimal previousAmount, BigDecimal currentAmount);

    MemberRank findDefault();

}