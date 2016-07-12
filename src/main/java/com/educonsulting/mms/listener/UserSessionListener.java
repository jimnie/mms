package com.educonsulting.mms.listener;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by Wayne on 2016/7/11.
 */
public class UserSessionListener implements SessionListener {

    private static Logger logger = LoggerFactory.getLogger(UserSessionListener.class);

    @Override
    public void onStart(Session session) {
        //会话创建时触发
        logger.debug("会话创建：" + session.getId());
    }

    @Override
    public void onExpiration(Session session) {
        //会话过期时触发
        logger.debug("会话过期：" + session.getId());
    }

    @Override
    public void onStop(Session session) {
        //退出/会话过期时触发
        logger.debug("会话停止：" + session.getId());
    }
}
