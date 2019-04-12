package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DictionaryDao;
import com.educonsulting.mms.dao.DrawDao;
import com.educonsulting.mms.entity.Dictionary;
import com.educonsulting.mms.entity.Draw;
import com.educonsulting.mms.service.DrawService;
import com.educonsulting.mms.util.Constants;
import com.educonsulting.mms.util.DatePattern;
import com.educonsulting.mms.util.DateTimeUtils;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("drawServiceImpl")
public class DrawServiceImpl extends BaseServiceImpl<Draw, Long> implements DrawService {

    @Resource(name = "drawDaoImpl")
    private DrawDao drawDao;

    @Resource(name = "dictionaryDaoImpl")
    private DictionaryDao dictionaryDao;

    @Resource(name = "dictionaryDaoImpl")
    public void setDictionaryDao(DictionaryDao dictionaryDao) {
        this.dictionaryDao = dictionaryDao;
    }

    @Resource(name = "drawDaoImpl")
    public void setBaseDao(DrawDao drawDao) {
        super.setBaseDao(drawDao);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return drawDao.isServiceNoExist(serviceNo);
    }

    @Override
    public Page<Draw> findpage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public List<Draw> findDepositByServiceNo(String serviceNo) {
        return drawDao.findDrawByServiceNo(serviceNo);
    }

    @Override
    public String buildPdf(String serviceNo, String fileName, String type) {
        String webRoot = System.getProperty("webapp.root");
        String jasperPath = webRoot + Constants.JASPER_FILE_PATH;
        String outputPath = webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\" + fileName;
        File pdf = new File(outputPath);
        if (!pdf.exists()) {
            String jasper = null;
            if (type.equals("cert")) {
                jasper = Constants.DRAW_CERT_JASPER;
            } else if (type.equals("conf")) {
                jasper = Constants.PLACE_SERVICE_JASPER;
            }
            File jasperFile = new File(jasperPath + jasper);
            List<Draw> list = findDepositByServiceNo(serviceNo);

            if (CollectionUtils.isNotEmpty(list)) {
                Map<String, Object> parameters = new HashMap<String, Object>();
                Draw draw = list.get(0);

                String dpSex = findDictNameByValue("sex", draw.getDpSex().toString());
                String dpCertType = findDictNameByValue("certType", draw.getDpCertType().toString());
                String utCertType = findDictNameByValue("certType", draw.getUtCertType().toString());
                String invoiceState = findDictNameByValue("invoiceState", draw.getInvoiceState().toString());
                String magcardState = findDictNameByValue("magcardState", draw.getMagcardState().toString());
                String drawType = findDictNameByValue("drawType", draw.getDrawType().toString());
                parameters.put("createDate", DateTimeUtils.getDateStringByPattern(draw.getCreateDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("drawType", drawType);
                parameters.put("serviceNo", draw.getServiceNo());
                parameters.put("dpName", draw.getDpName());
                parameters.put("dpSex", dpSex); // 需要转为男女
                parameters.put("dpAge", draw.getDpAge().toString());
                parameters.put("dpCertType", dpCertType); // 需要转为证件类型
                parameters.put("dpCertNo", draw.getDpCertNo());
                parameters.put("utName", draw.getUtName());
                parameters.put("utCertType", utCertType); // 需要转为证件类型
                parameters.put("utCertNo", draw.getUtCertNo());
                parameters.put("phone", draw.getPhone());
                parameters.put("drawDate", DateTimeUtils.getDateStringByPattern(draw.getDrawDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("invoiceState", invoiceState);
                parameters.put("magcardState", magcardState);
                parameters.put("memo", StringUtils.isNotEmpty(draw.getMemo()) ? draw.getMemo() : "");
//                parameters.put("createDate", DateTimeUtils.getDateStringByPattern(deposit.getCreateDate(), DatePattern.YEAR_MONTH_DAY_WITH_HH_MM));
                parameters.put("signPic", webRoot + Constants.GENERATE_PIC_PATH + draw.getSignPic());

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

    private String findDictNameByValue(String fieldName, String value) {
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
