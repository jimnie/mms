package com.educonsulting.mms;

import org.apache.commons.lang.time.DateUtils;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateEditor extends PropertyEditorSupport {

    private static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

    private boolean emptyAsNull;

    private String dateFormat = DEFAULT_DATE_FORMAT;

    public DateEditor(boolean emptyAsNull) {
        this.emptyAsNull = emptyAsNull;
    }

    public DateEditor(boolean emptyAsNull, String dateFormat) {
        this.emptyAsNull = emptyAsNull;
        this.dateFormat = dateFormat;
    }

    @Override
    public String getAsText() {
        Date value = (Date) getValue();
        return value != null ? new SimpleDateFormat(dateFormat).format(value) : "";
    }

    @Override
    public void setAsText(String text) {
        if (text == null) {
            setValue(null);
        } else {
            String value = text.trim();
            if (emptyAsNull && "".equals(value)) {
                setValue(null);
            } else {
                try {
                    setValue(DateUtils.parseDate(value, CommonAttributes.DATE_PATTERNS));
                } catch (ParseException e) {
                    setValue(null);
                }
            }
        }
    }

    /**
     * 判断当前日期是星期几
     *
     * @param pTime 修要判断的时间
     * @return dayForWeek 判断结果
     * @Exception 发生异常
     */
    public static String dayForWeek(String pTime) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(format.parse(pTime));
        String[] weeks = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        int dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (dayForWeek < 0) {
            dayForWeek = 0;
        }
        return weeks[dayForWeek];
    }

    /**
     * 获取指定某月的某天的日期
     *
     * @param month 相对月份 day 绝对日期
     * @return 转换结果
     */
    public static Date getGivenDate(int month, int day) {
        Calendar calendar = Calendar.getInstance();//今天的时间
        calendar.add(Calendar.MONTH, month);
        calendar.set(Calendar.DAY_OF_MONTH, day);
        return calendar.getTime();
    }

    /**
     * 日期格式转换
     *
     * @param date 要转换格式的日期
     * @return 转换结果String
     * @Exception 发生异常
     */
    public static String getYYYYMMDD(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }

    /**
     * 日期格式转换
     *
     * @param date 要转换格式的日期
     * @return 转换结果String
     * @Exception 发生异常
     */
    public static String getYYYYMM(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
        return format.format(date);
    }

    /**
     * 日期格式转换
     *
     * @param date 要转换格式的日期
     * @return 转换结果String
     * @Exception 发生异常
     */
    public static String getHHmm(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        return format.format(date);
    }

}