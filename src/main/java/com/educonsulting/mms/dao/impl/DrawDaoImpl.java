package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.DrawDao;
import com.educonsulting.mms.entity.Draw;
import org.springframework.stereotype.Repository;

@Repository("drawDaoImpl")
public class DrawDaoImpl extends BaseDaoImpl<Draw, Long> implements DrawDao {
}
