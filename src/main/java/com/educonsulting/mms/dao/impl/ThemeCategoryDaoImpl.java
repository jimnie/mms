package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.ThemeCategoryDao;
import com.educonsulting.mms.entity.ThemeCategory;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2016/3/10.
 */
@Repository("themeCategoryDaoImpl")
public class ThemeCategoryDaoImpl extends BaseDaoImpl<ThemeCategory, String> implements
        ThemeCategoryDao {

    @Override
    public boolean isCategoryNameExists(String categoryName) {
        if (categoryName == null) {
            return false;
        }
        String jpql = "select count(category.name) from ThemeCategory category where lower" +
                "(category.name) = " +
                "lower(:categoryName)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("categoryName", categoryName).getSingleResult();
        return count > 0;
    }

    @Override
    public boolean isCategoryNameExists(String categoryName, String id) {
        if (categoryName == null) {
            return false;
        }
        String jpql = "select count(category.name) from ThemeCategory category where lower" +
                "(category.name) = " +
                "lower(:categoryName) and category.id != :id";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("categoryName", categoryName).setParameter("id", id)
                .getSingleResult();
        return count > 0;
    }
}
