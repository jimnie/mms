package com.educonsulting.mms;

import com.educonsulting.mms.util.DatePattern;
import org.apache.commons.lang.time.DateUtils;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateEditor extends PropertyEditorSupport {

    private boolean emptyAsNull;

    private String dateFormat = com.educonsulting.mms.util.DateUtils.getDatePattern(DatePattern
            .TIME_IN_24H.getValue());

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
                    setValue(DateUtils.parseDate(value, com.educonsulting.mms.util.DateUtils
                            .getDatePatterns()));
                } catch (ParseException e) {
                    setValue(null);
                }
            }
        }
    }

}