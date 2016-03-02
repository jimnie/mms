package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.CommonAttributes;
import com.educonsulting.mms.LogConfig;
import com.educonsulting.mms.service.LogConfigService;
import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service("logConfigServiceImpl")
public class LogConfigServiceImpl implements LogConfigService {

    @Cacheable("logConfig")
    public List<LogConfig> getAll() {
        try {
            File settingXmlFile = new ClassPathResource(CommonAttributes.SETTING_XML_PATH)
                    .getFile();
            Document document = new SAXReader().read(settingXmlFile);
            List<org.dom4j.Element> elements = document.selectNodes(CommonAttributes
                    .LOG_CONFIG_NODE_PATH);
            List<LogConfig> logConfigs = new ArrayList<LogConfig>();
            for (org.dom4j.Element element : elements) {
                String operation = element.attributeValue("operation");
                String urlPattern = element.attributeValue("urlPattern");
                LogConfig logConfig = new LogConfig();
                logConfig.setOperation(operation);
                logConfig.setUrlPattern(urlPattern);
                logConfigs.add(logConfig);
            }
            return logConfigs;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}