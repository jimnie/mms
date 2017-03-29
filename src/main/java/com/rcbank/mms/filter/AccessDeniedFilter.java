package com.rcbank.mms.filter;

import org.apache.commons.codec.binary.Base64;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AccessDeniedFilter implements Filter {

    private static final String ERROR_MESSAGE = "Access denied!";

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void destroy() {
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.addHeader(new String(Base64.decodeBase64("UG93ZXJlZEJ5"), "utf-8"), new String
                (Base64.decodeBase64("Y2FzaHdheXRlY2guY29t"), "utf-8"));
        // PoweredBy
        // cashwaytech.com
        response.sendError(HttpServletResponse.SC_FORBIDDEN, ERROR_MESSAGE);
    }

}