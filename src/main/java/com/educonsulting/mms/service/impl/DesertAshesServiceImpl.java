package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DesertAshesDao;
import com.educonsulting.mms.entity.DesertAshes;
import com.educonsulting.mms.service.DesertAshesService;
import com.educonsulting.mms.util.Constants;
import com.educonsulting.mms.util.DatePattern;
import com.educonsulting.mms.util.DateTimeUtils;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("desertAshesServiceImpl")
public class DesertAshesServiceImpl extends BaseServiceImpl<DesertAshes, Long> implements DesertAshesService {

    @Resource(name = "desertAshesDaoImpl")
    private DesertAshesDao desertAshesDao;

    @Resource(name = "desertAshesDaoImpl")
    public void setBaseDao(DesertAshesDao desertAshesDao) {
        super.setBaseDao(desertAshesDao);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return desertAshesDao.isServiceNoExist(serviceNo);
    }

    @Override
    public Page<DesertAshes> findpage(Pageable pageable) {
        return null;
    }

    @Override
    public String buildPdf(String serviceNo) {
        String webRoot = System.getProperty("webapp.root");
        String jasperPath = webRoot + Constants.JASPER_FILE_PATH;
        String outputPath = webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\" + Constants.GIVEUP_CONFIRM_PDF;
        String serviceNoPath = webRoot + Constants.GENERATE_PDF_PATH + serviceNo;
        File pdf = new File(outputPath);
        if (!pdf.exists()) {
            File file = new File(serviceNoPath);
            if (!file.exists()) {
                file.mkdir();
            }
            String jasper = Constants.GIVEUP_CONFIRM_JASPER;
            File jasperFile = new File(jasperPath + jasper);
            List<DesertAshes> list = findDesertAshesByServiceNo(serviceNo);

            if (CollectionUtils.isNotEmpty(list)) {
                Map<String, Object> parameters = new HashMap<String, Object>();
                DesertAshes desertAshes = list.get(0);

                parameters.put("dpName", desertAshes.getDpName());
                parameters.put("utName", desertAshes.getUtName());
                parameters.put("confirmDate", DateTimeUtils.getDateStringByPattern(desertAshes.getCreateDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("signPic", webRoot + Constants.GENERATE_PIC_PATH + desertAshes.getSignPic());

                try {
                    JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperFile);
                    JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JREmptyDataSource());
                    OutputStream outputStream = new FileOutputStream(outputPath);
                    JRPdfExporter exporter = new JRPdfExporter();
                    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                    exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
                    exporter.exportReport();
                    outputStream.flush();
                    outputStream.close();
                } catch (JRException e) {
                    e.printStackTrace();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return outputPath;
    }

    @Override
    public List<DesertAshes> findDesertAshesByServiceNo(String serviceNo) {
        return desertAshesDao.findDesertAshesByServiceNo(serviceNo);
    }
}
