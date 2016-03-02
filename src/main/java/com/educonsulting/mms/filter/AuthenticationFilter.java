package com.educonsulting.mms.filter;

import com.educonsulting.mms.UserLoginToken;
import com.educonsulting.mms.service.RSAService;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class AuthenticationFilter extends FormAuthenticationFilter {

    private static final String DEFAULT_EN_PASSWORD_PARAM = "enPassword";

    private String enPasswordParam = DEFAULT_EN_PASSWORD_PARAM;

    @Resource(name = "rsaServiceImpl")
    private RSAService rsaService;

    @Override
    protected AuthenticationToken createToken(ServletRequest servletRequest, ServletResponse
            servletResponse) {
        String username = getUsername(servletRequest);
        String password = getPassword(servletRequest);
        boolean rememberMe = isRememberMe(servletRequest);
        String host = getHost(servletRequest);
        return new UserLoginToken(username, password, rememberMe, host);
    }

    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse
            servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String requestType = request.getHeader("X-Requested-With");
        if (requestType != null && requestType.equalsIgnoreCase("XMLHttpRequest")) {
            response.addHeader("loginStatus", "accessDenied");
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return false;
        }
        return super.onAccessDenied(request, response);
    }

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest
            servletRequest, ServletResponse servletResponse) throws Exception {
        Session session = subject.getSession();
        Map<Object, Object> attributes = new HashMap<Object, Object>();
        Collection<Object> keys = session.getAttributeKeys();
        for (Object key : keys) {
            attributes.put(key, session.getAttribute(key));
        }
        session.stop();
        session = subject.getSession();
        for (Entry<Object, Object> entry : attributes.entrySet()) {
            session.setAttribute(entry.getKey(), entry.getValue());
        }
        return super.onLoginSuccess(token, subject, servletRequest, servletResponse);
    }

    @Override
    protected String getPassword(ServletRequest servletRequest) {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String password = rsaService.decryptParameter(enPasswordParam, request);
        rsaService.removePrivateKey(request);
        return password;
    }

    public String getEnPasswordParam() {
        return enPasswordParam;
    }

    public void setEnPasswordParam(String enPasswordParam) {
        this.enPasswordParam = enPasswordParam;
    }

}