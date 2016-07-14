package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.AuthorityDao;
import com.educonsulting.mms.entity.Authority;
import org.springframework.stereotype.Repository;

/**
 * Created by Wayne on 2015/7/20.
 */
@Repository("authorityDaoImpl")
public class AuthorityDaoImpl extends BaseDaoImpl<Authority, Long> implements AuthorityDao {
}
