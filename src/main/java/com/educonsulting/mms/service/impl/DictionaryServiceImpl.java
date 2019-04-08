package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DictionaryDao;
import com.educonsulting.mms.entity.Dictionary;
import com.educonsulting.mms.service.DictionaryService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
@Service("dictionaryServiceImpl")
public class DictionaryServiceImpl extends BaseServiceImpl<Dictionary, Long> implements
        DictionaryService {

    @Resource(name = "dictionaryDaoImpl")
    private DictionaryDao dictionaryDao;

    @Resource(name = "dictionaryDaoImpl")
    public void setBaseDao(DictionaryDao dictionaryDao) {
        super.setBaseDao(dictionaryDao);
    }

    @Cacheable(value = "dictionary")
    public List<Dictionary> findDict(String fieldName) {
        return dictionaryDao.findDict(fieldName);
    }

    @Override
    @Cacheable(value = "dictionary")
    public Page<Dictionary> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    @Cacheable(value = "dictionary")
    public List<Dictionary> findAll() {
        return super.findAll();
    }

    @Override
    @Cacheable(value = "dictionary")
    public Dictionary find(Long id) {
        return super.find(id);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public Dictionary update(Dictionary entity) {
        return super.update(entity);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public Dictionary update(Dictionary entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public void delete(Long... ids) {
        super.delete(ids);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public void delete(Long id) {
        super.delete(id);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public void delete(Dictionary entity) {
        super.delete(entity);
    }

    @Override
    @CacheEvict(value = "dictionary", allEntries = true)
    public void save(Dictionary entity) {
        Subject currentUser = SecurityUtils.getSubject();
        String username = currentUser.getPrincipal().toString();
        entity.setCreator(username);
        super.save(entity);
    }

    @Override
    public String findDictNameByValue(String fieldName, String value) {
        List<Dictionary> dList = dictionaryDao.findDict(fieldName);
        String name = null;
        for (Dictionary dictionary : dList) {
            if (dictionary.getValue().equals(value)) {
                name = dictionary.getName();
            }
        }
        return name;
    }
}
