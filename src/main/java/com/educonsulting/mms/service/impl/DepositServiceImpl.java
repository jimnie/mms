package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DepositDao;
import com.educonsulting.mms.dao.DictionaryDao;
import com.educonsulting.mms.entity.Deposit;
import com.educonsulting.mms.entity.Dictionary;
import com.educonsulting.mms.service.DepositService;
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

@Service("depositServiceImpl")
public class DepositServiceImpl extends BaseServiceImpl<Deposit, Long> implements DepositService {

    @Resource(name = "depositDaoImpl")
    private DepositDao depositDao;

    @Resource(name = "dictionaryDaoImpl")
    private DictionaryDao dictionaryDao;

    @Resource(name = "dictionaryDaoImpl")
    public void setDictionaryDao(DictionaryDao dictionaryDao) {
        this.dictionaryDao = dictionaryDao;
    }

    @Override
    public List<Deposit> findDepositByServiceNo(String serviceNo) {
        return depositDao.findDepositByServiceNo(serviceNo);
    }

    @Resource(name = "depositDaoImpl")
    public void setBaseDao(DepositDao depositDao) {
        super.setBaseDao(depositDao);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return depositDao.isServiceNoExist(serviceNo);
    }

    @Override
    public Page<Deposit> findpage(Pageable pageable) {
        return super.findPage(pageable);
    }


    @Override
    public String buildPdf(String serviceNo) {
        String webRoot = System.getProperty("webapp.root");
        String jasperPath = webRoot + Constants.JASPER_FILE_PATH;
        String outputPath = webRoot + Constants.GENERATE_PDF_PATH + serviceNo + "\\" + Constants.DEPOSIT_INVOICE_PDF;
        String serviceNoPath = webRoot + Constants.GENERATE_PDF_PATH + serviceNo;
        File pdf = new File(outputPath);
        if (!pdf.exists()) {
            File file = new File(serviceNoPath);
            if (!file.exists()) {
                file.mkdir();
            }
            String jasper = Constants.DEPOSIT_INVOICE_JASPER;
            File jasperFile = new File(jasperPath + jasper);
            List<Deposit> list = findDepositByServiceNo(serviceNo);

            if (CollectionUtils.isNotEmpty(list)) {
                Map<String, Object> parameters = new HashMap<String, Object>();
                Deposit deposit = list.get(0);

                String dpSex = findDictNameByValue("sex", deposit.getDpSex().toString());
                String facade = findDictNameByValue("facade", deposit.getFacade().toString());
                String urgent = findDictNameByValue("isUrgent", deposit.getUrgent().toString());
                String dpCertType = findDictNameByValue("certType", deposit.getDpCertType().toString());
                String utCertType = findDictNameByValue("certType", deposit.getUtCertType().toString());

                parameters.put("serviceNo", deposit.getServiceNo());
                parameters.put("dpName", deposit.getDpName());
                parameters.put("dpSex", dpSex); // TODO: 需要转为男女
                parameters.put("dpAge", deposit.getDpAge().toString());
                parameters.put("dpCertType", dpCertType); // TODO: 需要转为证件类型
                parameters.put("dpCertNo", deposit.getDpCertNo());
                parameters.put("utName", deposit.getUtName());
                parameters.put("utCertType", utCertType); // TODO: 需要转为证件类型
                parameters.put("utCertNo", deposit.getUtCertNo());
                parameters.put("phone", deposit.getPhone());
                parameters.put("position", deposit.getPosition());
                parameters.put("urgent", urgent); // TODO: 需转为是否急取
                parameters.put("facade", facade); // TODO: 需转为外观
                parameters.put("depositDate", DateTimeUtils.getDateStringByPattern(deposit.getDepositDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("preDrawDate", DateTimeUtils.getDateStringByPattern(deposit.getPreDrawDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("memo", StringUtils.isNotEmpty(deposit.getMemo()) ? deposit.getMemo() : "");
                parameters.put("createDate", DateTimeUtils.getDateStringByPattern(deposit.getCreateDate(), DatePattern.YEAR_MONTH_DAY_IN_CHN));
                parameters.put("signPic", webRoot + Constants.GENERATE_PIC_PATH + deposit.getSignPic());

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
