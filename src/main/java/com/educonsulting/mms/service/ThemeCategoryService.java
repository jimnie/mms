package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.ThemeCategory;

/**
 * Created by Wayne on 2016/3/10.
 */
public interface ThemeCategoryService extends BaseService<ThemeCategory, String> {

    boolean isCategoryNameExists(String categoryName);

    boolean isCategoryNameExists(String categoryName, String id);
}
