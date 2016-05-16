package com.educonsulting.mms.util;

/**
 * Created by Wayne on 2016/5/16.
 * 使用了双重检查，同时使用 volatile 修饰 INSTANCE
 * 避免由于多线性同步和可见性问题造成的多实例。
 */
public class LazySingleton {

    private static volatile LazySingleton INSTANCE;

    private LazySingleton() {
    }

    public static LazySingleton getInstance() {
        if (INSTANCE == null) {
            synchronized (LazySingleton.class) {
                if (INSTANCE == null) {
                    INSTANCE = new LazySingleton();
                }
            }
        }
        return INSTANCE;
    }
}
