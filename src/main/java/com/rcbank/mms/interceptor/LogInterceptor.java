package com.rcbank.mms.interceptor;

import com.rcbank.mms.LogConfig;
import com.rcbank.mms.entity.Log;
import com.rcbank.mms.service.LogConfigService;
import com.rcbank.mms.service.LogService;
import com.rcbank.mms.service.UserService;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class LogInterceptor extends HandlerInterceptorAdapter {

    private static final String[] DEFAULT_IGNORE_PARAMETERS = new String[]{"password",
            "rePassword", "currentPassword"};

    private static AntPathMatcher antPathMatcher = new AntPathMatcher();

    private String[] ignoreParameters = DEFAULT_IGNORE_PARAMETERS;

    @Resource(name = "logConfigServiceImpl")
    private LogConfigService logConfigService;
    @Resource(name = "logServiceImpl")
    private LogService logService;
    @Resource(name = "userServiceImpl")
    private UserService userService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object
            handler, ModelAndView modelAndView) throws Exception {
        List<LogConfig> logConfigs = logConfigService.getAll();
        if (logConfigs != null) {
            String path = request.getServletPath();
            for (LogConfig logConfig : logConfigs) {
                if (antPathMatcher.match(logConfig.getUrlPattern(), path)) {
                    String username = userService.getCurrentUsername();
                    String operation = logConfig.getOperation();
                    String operator = username;
                    String content = (String) request.getAttribute(Log
                            .LOG_CONTENT_ATTRIBUTE_NAME);
                    String ip = request.getRemoteAddr();
                    request.removeAttribute(Log.LOG_CONTENT_ATTRIBUTE_NAME);
                    StringBuffer parameter = new StringBuffer();
                    Map<String, String[]> parameterMap = request.getParameterMap();
                    if (parameterMap != null) {
                        for (Entry<String, String[]> entry : parameterMap.entrySet()) {
                            String parameterName = entry.getKey();
                            if (!ArrayUtils.contains(ignoreParameters, parameterName)) {
                                String[] parameterValues = entry.getValue();
                                if (parameterValues != null) {
                                    for (String parameterValue : parameterValues) {
                                        parameter.append(parameterName + " = " + parameterValue +
                                                "\n");
                                    }
                                }
                            }
                        }
                    }
                    Log log = new Log();
                    log.setOperation(operation);
                    log.setOperator(operator);
                    log.setContent(content);
                    log.setParameter(parameter.toString());
                    log.setIp(ip);
                    logService.save(log);
                    break;
                }
            }
        }
    }

    public String[] getIgnoreParameters() {
        return ignoreParameters;
    }

    public void setIgnoreParameters(String[] ignoreParameters) {
        this.ignoreParameters = ignoreParameters;
    }

}