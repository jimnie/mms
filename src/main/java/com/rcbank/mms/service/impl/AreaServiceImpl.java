package com.rcbank.mms.service.impl;

import com.rcbank.mms.dao.AreaDao;
import com.rcbank.mms.entity.Area;
import com.rcbank.mms.service.AreaService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("areaServiceImpl")
public class AreaServiceImpl extends BaseServiceImpl<Area, Long> implements AreaService {

    @Resource(name = "areaDaoImpl")
    private AreaDao areaDao;

    @Resource(name = "areaDaoImpl")
    public void setBaseDao(AreaDao areaDao) {
        super.setBaseDao(areaDao);
    }

    @Transactional(readOnly = true)
    public List<Area> findRoots() {
        return areaDao.findRoots(null);
    }

    @Transactional(readOnly = true)
    public List<Area> findRoots(Integer count) {
        return areaDao.findRoots(count);
    }

    @Transactional(readOnly = true)
    public List<Area> getAresByParent(Long id) {
        return areaDao.getAresByParent(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void save(Area area) {
        super.save(area);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public Area update(Area area) {
        return super.update(area);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public Area update(Area area, String... ignoreProperties) {
        return super.update(area, ignoreProperties);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Long id) {
        super.delete(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Long... ids) {
        super.delete(ids);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Area area) {
        super.delete(area);
    }

}