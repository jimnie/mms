package com.educonsulting.mms.mail;

/**
 * PackageName com.educonsulting.mms.mail
 * Created by Songwc
 * Date ：2015/11/19.
 * Time ：13:39.
 * 转正考试通知Email
 */
public class ExamNoticeMailSend {
    public void examNoticeMailSend(String entryName, String mailAddr) {
        MailWithAttachment se = new MailWithAttachment(false);
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">" +
                "<head>" +
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" +
                "<title></title>" +
                "</head>" +
                "<body>" +
                "<div style=\"font-family: '楷体';font-size: 20px; width: 100%;\">" +
                "亲爱的" + entryName + "先生／小姐：<br />" +
                "&emsp;&emsp;根据您的入职时间及公司相关规定，考试系统已为您准备了转正考核试题，" +
                "希望您在本周内登陆考试系统，完成转正考核。本次考核成绩将列为您试用期测评的重要参考依据，特此通知！<br/>" +
                "祝：工作愉快！" +
                "<div style=\"width: 100%;text-align: right;\">恒银金融科技股份有限公司<br /></div>" +
                "<div style=\"width: 100%;text-align: right;\">客服技术中心--综合管理部<br /></div>" +
                "</div>" +
                "</body>" +
                "</html>");
        se.doSendHtmlEmail("欢迎辞暨试用期启动通知", String.valueOf(stringBuffer), mailAddr, null);
    }
}
