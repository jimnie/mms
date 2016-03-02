package com.educonsulting.mms;

import org.apache.shiro.authc.UsernamePasswordToken;

public class UserLoginToken extends UsernamePasswordToken {

    private static final long serialVersionUID = 5898441540965086534L;

    public UserLoginToken(String username, String password, boolean rememberMe, String host) {
        super(username, password, rememberMe, host);
    }
}