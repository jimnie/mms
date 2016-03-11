package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.ThemeCategoryDao;
import com.educonsulting.mms.entity.ThemeCategory;
import com.educonsulting.mms.service.ThemeCategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wayne on 2016/3/10.
 */
@Service("themeCategoryServiceImpl")
public class ThemeCategoryServiceImpl extends BaseServiceImpl<ThemeCategory, String> implements
        ThemeCategoryService {

    @Resource(name = "themeCategoryDaoImpl")
    private ThemeCategoryDao themeCategoryDao;

    @Resource(name = "themeCategoryDaoImpl")
    public void setBaseDao(ThemeCategoryDao themeCategoryDao) {
        super.setBaseDao(themeCategoryDao);
    }

    @Override
    public void delete(ThemeCategory entity) {
        super.delete(entity);
    }

    @Override
    public ThemeCategory find(String id) {
        return super.find(id);
    }

    @Override
    public List<ThemeCategory> findAll() {
        return super.findAll();
    }

    @Override
    public List<ThemeCategory> findList(String... ids) {
        return super.findList(ids);
    }

    @Override
    public List<ThemeCategory> findList(Integer count, List<Filter> filters, List<Order> orders) {
        return super.findList(count, filters, orders);
    }

    @Override
    public List<ThemeCategory> findList(Integer first, Integer count, List<Filter> filters,
                                        List<Order> orders) {
        return super.findList(first, count, filters, orders);
    }

    @Override
    public Page<ThemeCategory> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public long count() {
        return super.count();
    }

    @Override
    public long count(Filter... filters) {
        return super.count(filters);
    }

    @Override
    public boolean exists(String id) {
        return super.exists(id);
    }

    @Override
    public boolean exists(Filter... filters) {
        return super.exists(filters);
    }

    @Override
    public void save(ThemeCategory entity) {
        super.save(entity);
    }

    @Override
    public ThemeCategory update(ThemeCategory entity) {
        return super.update(entity);
    }

    @Override
    public ThemeCategory update(ThemeCategory entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Override
    public void delete(String id) {
        super.delete(id);
    }

    @Override
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Override
    public boolean isCategoryNameExists(String categoryName) {
        return themeCategoryDao.isCategoryNameExists(categoryName);
    }

    @Override
    public boolean isCategoryNameExists(String categoryName, String id) {
        return themeCategoryDao.isCategoryNameExists(categoryName, id);
    }
}