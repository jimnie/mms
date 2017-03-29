package com.rcbank.mms.annotation;

import java.lang.annotation.*;

/**
 * Created by Wayne on 2016/6/23.
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SystemServiceLog {
    String description() default "";
}
