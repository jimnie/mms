package com.educonsulting.mms.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Wayne on 2016/5/26.
 */
public class DateUtils {

    private DateUtils() {
    }

    private static final String[] DATE_PATTERNS = new String[]{"yyyy", "yyyy-MM", "yyyyMM",
            "yyyy/MM", "yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd", "yyyy-MM-dd HH:mm:ss",
            "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss", "yyyyMMddHHmmss"};

    public static String getDateStringByPattern(Date date, DatePattern pattern) {
        SimpleDateFormat format = new SimpleDateFormat(getDatePattern(pattern.getValue()));
        return format.format(date);
    }

    public static String getDatePattern(Integer index) {
        return DATE_PATTERNS[index];
    }

    public static String[] getDatePatterns() {
        return DATE_PATTERNS;
    }

}
