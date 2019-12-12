package com.educonsulting.mms.listener;


import com.educonsulting.mms.entity.TempInf;
import com.educonsulting.mms.service.TempInfService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jms.listener.SessionAwareMessageListener;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.jms.*;

/**
 * Created by Administrator on 2017/1/5.
 */
@Component
public class QueueMessageListener implements SessionAwareMessageListener<Message> {

    private static final Logger logger = LoggerFactory.getLogger(QueueMessageListener.class);

    @Resource(name = "tempInfServiceImpl")
    private TempInfService tempInfService;

    @Override
    public void onMessage(Message message, Session arg1) throws JMSException {
        try {
            Destination destination = message.getJMSDestination();
            String topic = destination.toString();
            logger.info("接收订阅消息 =========================" + topic);
            logger.info("业务消息开始 =========================");

            MapMessage mapMessage = (MapMessage) message;
            logger.info("业务编号:" + mapMessage.getStringProperty("biz_num"));
            logger.info("逝者证件号:" + mapMessage.getStringProperty("ds_id_card"));
            logger.info("逝者姓名:" + mapMessage.getStringProperty("ds_name"));
            logger.info("逝者性别:" + mapMessage.getIntProperty("ds_sex"));
            logger.info("逝者年龄:" + mapMessage.getIntProperty("ds_age"));
            logger.info("逝者住址:" + mapMessage.getStringProperty("ds_addr"));
            logger.info("RFID:" + mapMessage.getStringProperty("rfid"));

            logger.info("承办人姓名:" + mapMessage.getStringProperty("name"));
            logger.info("承办人证件号:" + mapMessage.getStringProperty("id_card"));
            logger.info("承办人电话:" + mapMessage.getStringProperty("tel"));
            logger.info("业务消息结束 =========================");

            logger.info("查询业务编号数据:" + mapMessage.getStringProperty("biz_num"));

            TempInf tempInf = new TempInf();
            tempInf.setServiceNo(mapMessage.getStringProperty("biz_num"));
            tempInf.setDsCertNo(mapMessage.getStringProperty("ds_id_card"));
            tempInf.setDsName(mapMessage.getStringProperty("ds_name"));
            tempInf.setDsSex(mapMessage.getIntProperty("ds_sex"));
            tempInf.setDsAge(mapMessage.getIntProperty("ds_age"));
            tempInf.setDsAddr(mapMessage.getStringProperty("ds_addr"));
            tempInf.setRfid(mapMessage.getStringProperty("rfid"));

            tempInf.setAgentCertNo(mapMessage.getStringProperty("id_card"));
            tempInf.setName(mapMessage.getStringProperty("name"));
            tempInf.setPhone(mapMessage.getStringProperty("tel"));
            tempInf.setAgentAddr(mapMessage.getStringProperty("addr"));

            if (!tempInfService.isServiceNoExist(mapMessage.getStringProperty("biz_num"))) {
                logger.info("业务编号数据不存在 -> " + mapMessage.getStringProperty("biz_num"));
                tempInfService.save(tempInf);
                logger.info("业务编号数据已保存 -> " + mapMessage.getStringProperty("biz_num"));
            } else {
                logger.info("业务编号数据已存在 -> " + mapMessage.getStringProperty("biz_num"));
                tempInfService.update(tempInf);
                logger.info("业务编号数据已更新 -> " + mapMessage.getStringProperty("biz_num"));
            }
        } catch (Exception e) {

        }
    }

}