package com.educonsulting.mms.util;

/**
 * Created by Wayne on 2016/5/16.
 * 无线程同步问题，实现了 lazy loading。
 * 只有调用 getInstance 时才会加载内部类并创建实例。
 */
public class HungrySingleton {

    private HungrySingleton() {
    }

    public static HungrySingleton getInstance() {
        return InnerClass.INSTANCE;
    }

    private static class InnerClass {
        private static final HungrySingleton INSTANCE = new HungrySingleton();
    }
}
