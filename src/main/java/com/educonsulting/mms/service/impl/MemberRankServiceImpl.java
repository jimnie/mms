package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.MemberRankDao;
import com.educonsulting.mms.entity.MemberRank;
import com.educonsulting.mms.service.MemberRankService;
import org.apache.commons.lang.StringUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;

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

    @Override
    public MemberRank find(String id) {
        return super.find(id);
    }

    @Override
    @Cacheable(value = "memberRank")
    public List<MemberRank> findAll() {
        return super.findAll();
    }

    @Override
    @Cacheable(value = "memberRank")
    public Page<MemberRank> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public void save(MemberRank entity) {
        super.save(entity);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public MemberRank update(MemberRank entity) {
        return super.update(entity);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public MemberRank update(MemberRank entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public void delete(String id) {
        super.delete(id);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Override
    @CacheEvict(value = "memberRank", allEntries = true)
    public void delete(MemberRank entity) {
        super.delete(entity);
    }
}