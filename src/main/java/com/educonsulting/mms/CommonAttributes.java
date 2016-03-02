package com.educonsulting.mms;

public final class CommonAttributes {

    public static final String[] DATE_PATTERNS = new String[]{"yyyy", "yyyy-MM", "yyyyMM",
            "yyyy/MM", "yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd", "yyyy-MM-dd HH:mm:ss",
            "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss"};

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
    public static final String RESOURCE_ROOT_ID = "00000000000000000000000000000000";
    public static final String MENU_CLOSED = "closed";

    private CommonAttributes() {
    }

    public static String getDatePattern(Integer index) {
        return DATE_PATTERNS[index];
    }
}