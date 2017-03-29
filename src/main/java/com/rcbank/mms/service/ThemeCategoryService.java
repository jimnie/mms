package com.rcbank.mms.service;

import com.rcbank.mms.entity.ThemeCategory;

/**
 * Created by Wayne on 2016/3/10.
 */
public interface ThemeCategoryService extends BaseService<ThemeCategory, Long> {

    boolean isCategoryNameExists(String categoryName);

    boolean isCategoryNameExists(String categoryName, Long id);
}
