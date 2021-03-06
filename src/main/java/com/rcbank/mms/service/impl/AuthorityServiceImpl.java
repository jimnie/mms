package com.rcbank.mms.service.impl;

import com.rcbank.mms.dao.AuthorityDao;
import com.rcbank.mms.entity.Authority;
import com.rcbank.mms.service.AuthorityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Wayne on 2015/7/20.
 */
@Service("authorityServiceImpl")
public class AuthorityServiceImpl extends BaseServiceImpl<Authority, Long> implements
        AuthorityService {

    @Resource(name = "authorityDaoImpl")
    private AuthorityDao authorityDao;

    @Resource(name = "authorityDaoImpl")
    private void setBaseDao(AuthorityDao authorityDao) {
        super.setBaseDao(authorityDao);
    }
}
