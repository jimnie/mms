package com.educonsulting.mms.controller;

import com.educonsulting.mms.*;
import com.educonsulting.mms.entity.Log;
import com.educonsulting.mms.util.SettingUtils;
import com.educonsulting.mms.util.SpringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import javax.annotation.Resource;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class BaseController {

    protected static final String ERROR_VIEW = "/common/error";

    protected static final Message ERROR_MESSAGE = Message.error("sys.message.error");

    protected static final Message SUCCESS_MESSAGE = Message.success("sys.message.success");

    private static final String CONSTRAINT_VIOLATIONS_ATTRIBUTE_NAME = "constraintViolations";

    public static final String TOTAL_KEY = "total";

    public static final String ROWS_KEY = "rows";

    @Resource(name = "validator")
    private Validator validator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
        binder.registerCustomEditor(Date.class, new DateEditor(true));
    }

    protected boolean isValid(Object target, Class<?>... groups) {
        Set<ConstraintViolation<Object>> constraintViolations = validator.validate(target, groups);
        if (constraintViolations.isEmpty()) {
            return true;
        } else {
            RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
            requestAttributes.setAttribute(CONSTRAINT_VIOLATIONS_ATTRIBUTE_NAME,
                    constraintViolations, RequestAttributes.SCOPE_REQUEST);
            return false;
        }
    }

    protected boolean isValid(Class<?> type, String property, Object value, Class<?>... groups) {
        Set<?> constraintViolations = validator.validateValue(type, property, value, groups);
        if (constraintViolations.isEmpty()) {
            return true;
        } else {
            RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
            requestAttributes.setAttribute(CONSTRAINT_VIOLATIONS_ATTRIBUTE_NAME,
                    constraintViolations, RequestAttributes.SCOPE_REQUEST);
            return false;
        }
    }

    protected String currency(BigDecimal amount, boolean showSign, boolean showUnit) {
        Setting setting = SettingUtils.get();
        String price = setting.setScale(amount).toString();
        if (showSign) {
            price = setting.getCurrencySign() + price;
        }
        if (showUnit) {
            price += setting.getCurrencyUnit();
        }
        return price;
    }

    protected String message(String code, Object... args) {
        return SpringUtils.getMessage(code, args);
    }

    protected void addLog(String content) {
        if (content != null) {
            RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
            requestAttributes.setAttribute(Log.LOG_CONTENT_ATTRIBUTE_NAME, content,
                    RequestAttributes.SCOPE_REQUEST);
        }
    }

    protected Pageable getPageable(String rows, String page, String sort, String order) {
        Pageable pageable = new Pageable(Integer.parseInt(page), Integer.parseInt(rows));
        if (StringUtils.isNotEmpty(sort)) {
            pageable.setOrderProperty(sort);
        }
        if (StringUtils.isNotEmpty(order)) {
            pageable.setOrderDirection(Order.Direction.fromString(order));
        }
        return pageable;
    }

    protected Map<String, Object> getPageResultMap(Page page) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(TOTAL_KEY, page.getTotal());
        map.put(ROWS_KEY, page.getContent());
        return map;
    }

}