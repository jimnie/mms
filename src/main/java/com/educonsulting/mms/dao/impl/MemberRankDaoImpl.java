package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.MemberRankDao;
import com.educonsulting.mms.entity.MemberRank;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;
import java.math.BigDecimal;

@Repository("memberRankDaoImpl")
public class MemberRankDaoImpl extends BaseDaoImpl<MemberRank, Long> implements MemberRankDao {

    public boolean nameExists(String name) {
        if (name == null) {
            return false;
        }
        String jpql = "select count(memberRank.name) from MemberRank memberRank where lower" +
                "(memberRank.name) = " +
                "lower(:name)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("name", name).getSingleResult();
        return count > 0;
    }

    public boolean amountExists(BigDecimal amount) {
        if (amount == null) {
            return false;
        }
        String jpql = "select count(memberRank.amount) from MemberRank memberRank where " +
                "memberRank.amount = " +
                ":amount";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("amount", amount).getSingleResult();
        return count > 0;
    }

    public MemberRank findDefault() {
        try {
            String jpql = "select memberRank from MemberRank memberRank where memberRank" +
                    ".isDefault = true";
            return entityManager.createQuery(jpql, MemberRank.class).setFlushMode(FlushModeType
                    .COMMIT).getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public MemberRank findByAmount(BigDecimal amount) {
        if (amount == null) {
            return null;
        }
        String jpql = "select memberRank from MemberRank memberRank where memberRank.isSpecial = " +
                "false and memberRank.amount <= :amount order by memberRank.amount desc";
        return entityManager.createQuery(jpql, MemberRank.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("amount", amount).setMaxResults(1).getSingleResult();
    }

    @Override
    public void persist(MemberRank memberRank) {
        Assert.notNull(memberRank);
        if (memberRank.getIsDefault()) {
            String jpql = "update MemberRank memberRank set memberRank.isDefault = false where " +
                    "memberRank.isDefault = true";
            entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
        }
        super.persist(memberRank);
    }

    @Override
    public MemberRank merge(MemberRank memberRank) {
        Assert.notNull(memberRank);
        if (memberRank.getIsDefault()) {
            String jpql = "update MemberRank rank set rank.isDefault = false where " +
                    "rank.isDefault = true and rank != :memberRank";
            entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).setParameter
                    ("rank", memberRank).executeUpdate();
        }
        return super.merge(memberRank);
    }

    @Override
    public void remove(MemberRank memberRank) {
        super.remove(memberRank);
    }

}