package com.educonsulting.mms.interceptor;

import com.educonsulting.mms.Principal;
import com.educonsulting.mms.entity.User;
import com.educonsulting.mms.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

public class UserInterceptor extends HandlerInterceptorAdapter {

    private static final String REDIRECT_VIEW_NAME_PREFIX = "redirect:";

    private static final String REDIRECT_URL_PARAMETER_NAME = "redirectUrl";

    private static final String USER_ATTRIBUTE_NAME = "user";

    private static final String DEFAULT_LOGIN_URL = "/login.jsp";

    private String loginUrl = DEFAULT_LOGIN_URL;

    @Value("${url_escaping_charset}")
    private String urlEscapingCharset;

    @Resource(name = "userServiceImpl")
    private UserService userService;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object
            handler) throws Exception {
        HttpSession session = request.getSession();
        Principal principal = (Principal) session.getAttribute(User.PRINCIPAL_ATTRIBUTE_NAME);
        if (principal != null) {
            return true;
        } else {
            String requestType = request.getHeader("X-Requested-With");
            if (requestType != null && requestType.equalsIgnoreCase("XMLHttpRequest")) {
                response.addHeader("loginStatus", "accessDenied");
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return false;
            } else {
                if (request.getMethod().equalsIgnoreCase("GET")) {
                    String redirectUrl = request.getQueryString() != null ? request.getRequestURI
                            () + "?" + request.getQueryString() : request.getRequestURI();
                    response.sendRedirect(request.getContextPath() + loginUrl + "?" +
                            REDIRECT_URL_PARAMETER_NAME + "=" + URLEncoder.encode(redirectUrl,
                            urlEscapingCharset));
                } else {
                    response.sendRedirect(request.getContextPath() + loginUrl);
                }
                return false;
            }
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object
            handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            String viewName = modelAndView.getViewName();
            if (!StringUtils.startsWith(viewName, REDIRECT_VIEW_NAME_PREFIX)) {
                modelAndView.addObject(USER_ATTRIBUTE_NAME, userService.getCurrent());
            }
        }
    }

    public String getLoginUrl() {
        return loginUrl;
    }

    public void setLoginUrl(String loginUrl) {
        this.loginUrl = loginUrl;
    }

}