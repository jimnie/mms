package com.rcbank.mms.dao.impl;

import com.rcbank.mms.dao.AuthorityDao;
import com.rcbank.mms.entity.Authority;
import org.springframework.stereotype.Repository;

/**
 * Created by Wayne on 2015/7/20.
 */
@Repository("authorityDaoImpl")
public class AuthorityDaoImpl extends BaseDaoImpl<Authority, Long> implements AuthorityDao {
}
