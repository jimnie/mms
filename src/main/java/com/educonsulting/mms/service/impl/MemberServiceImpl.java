package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.MemberDao;
import com.educonsulting.mms.entity.Member;
import com.educonsulting.mms.service.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wayne on 2016/3/8.
 */
@Service("memberServiceImpl")
public class MemberServiceImpl extends BaseServiceImpl<Member, String> implements MemberService {

    @Resource(name = "memberDaoImpl")
    private MemberDao memberDao;

    @Resource(name = "memberDaoImpl")
    public void setBaseDao(MemberDao memberDao) {
        super.setBaseDao(memberDao);
    }

    @Transactional(readOnly = true)
    public boolean cartNoExists(String cardNo) {
        return memberDao.isCardNoAssigned(cardNo);
    }

    @Override
    public Member find(String id) {
        return super.find(id);
    }

    @Override
    public List<Member> findAll() {
        return super.findAll();
    }

    @Override
    public List<Member> findList(String... ids) {
        return super.findList(ids);
    }

    @Override
    public List<Member> findList(Integer count, List<Filter> filters, List<Order> orders) {
        return super.findList(count, filters, orders);
    }

    @Override
    public List<Member> findList(Integer first, Integer count, List<Filter> filters, List<Order>
            orders) {
        return super.findList(first, count, filters, orders);
    }

    @Override
    public Page<Member> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public long count() {
        return super.count();
    }

    @Override
    public long count(Filter... filters) {
        return super.count(filters);
    }

    @Override
    public boolean exists(String id) {
        return super.exists(id);
    }

    @Override
    public boolean exists(Filter... filters) {
        return super.exists(filters);
    }

    @Transactional
    public void save(Member entity) {
        super.save(entity);
    }

    @Transactional
    public Member update(Member entity) {
        return super.update(entity);
    }

    @Transactional
    public Member update(Member entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Transactional
    public void delete(String id) {
        super.delete(id);
    }

    @Transactional
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Transactional
    public void delete(Member entity) {
        super.delete(entity);
    }

    @Override
    public boolean isCartNoAssigned(String cardNo) {
        return memberDao.isCardNoAssigned(cardNo);
    }

    @Override
    public boolean isMobileExisted(String mobile) {
        return memberDao.isMobileExisted(mobile);
    }
}
