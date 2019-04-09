package com.educonsulting.mms.util;

/**
 * Created by Wayne on 2016/6/23.
 */
public enum DatePattern {

    YEAR(0), YEAR_MONTH_WITH_MINUS(1), YEAR_MONTH(2), YEAR_MONTH_WITH_SLASH(3),
    YEAR_MONTH_DAY_WITH_MINUS(4), YEAR_MONTH_DAY(5), YEAR_MONTH_DAY_WITH_SLASH(6),
    TIME_WITH_MINUS(7), TIME(8), TIME_WITH_SLASH(9), TIME_IN_24H(10), YEAR_MONTH_DAY_WITH_HH_MM(11),
    YEAR_MONTH_DAY_IN_CHN(12), YEAR_MONTH_DAY_WITH_TIME_IN_CHN(13);

    private int value = 0;

    private DatePattern(int value) {    //    必须是private的，否则编译错误
        this.value = value;
    }

    public int getValue() {
        return this.value;
    }
}
