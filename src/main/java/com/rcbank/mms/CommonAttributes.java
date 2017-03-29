package com.rcbank.mms;

import org.apache.commons.codec.binary.Base64;

import java.io.UnsupportedEncodingException;

public final class CommonAttributes {

    public static final String SETTING_XML_PATH = "/setting.xml";
    public static final String CONF_PROPERTIES_PATH = "/conf.properties";
    public static final String SETTING_NODE_PATH = "/config/setting";
    public static final String LOG_CONFIG_NODE_PATH = "/config/logConfig";
    public static final String RESOURCE_TYPE_NAV = "resource_01";
    public static final String RESOURCE_TYPE_MOD = "resource_02";
    public static final String RESOURCE_TYPE_MENU = "resource_03";
    public static final String MAIN_PAGE_NAVS_KEY = "navs";
    public static final String MAIN_PAGE_NAV_NAME = "name";
    public static final String MAIN_PAGE_NAV_TITLE = "title";
    public static final String NAVS_MODULES_MAPPING_KEY = "mods";
    public static final String MAIN_PAGE_NAV_CLASS_ATTR = "classname";
    public static final String MAIN_PAGE_NAV_ACTIVE = "active";
    public static final int ARRAYS_INDEX_FIRST = 0;
    public static final String NAV_JSON_ATTR_MENUID = "menuid";
    public static final String NAV_JSON_ATTR_MENUNAME = "menuname";
    public static final String NAV_JSON_ATTR_ICON = "icon";
    public static final String NAV_JSON_ATTR_URL = "url";
    public static final String NAV_JSON_ATTR_MENUS = "menus";
    public static final Long RESOURCE_ROOT_ID = 0L;
    public static final String MENU_CLOSED = "closed";
    public static final long DEFAULT_MEMBER_POINT = 0L;

    private CommonAttributes() {
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
        System.out.println(new String(Base64.encodeBase64("PoweredBy".getBytes("utf-8")), "utf-8"));
        System.out.println(new String(Base64.decodeBase64("UG93ZXJlZEJ5"), "utf-8"));
    }
}