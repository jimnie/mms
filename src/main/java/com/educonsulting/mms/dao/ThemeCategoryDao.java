package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.ThemeCategory;

/**
 * Created by Wayne on 2016/3/10.
 */
public interface ThemeCategoryDao extends BaseDao<ThemeCategory, Long> {

    boolean isCategoryNameExists(String categoryName);

    boolean isCategoryNameExists(String categoryName, Long id);
}
