package com.educonsulting.mms.mail;

/**
 * PackageName com.educonsulting.mms.mail
 * Created by Songwc
 * Date ：2015/11/19.
 * Time ：14:08.
 */
public class MakeUpExamMailSend {
    public void MakeUpExamMailSend(String entryName, String mailAddr) {
        MailWithAttachment se = new MailWithAttachment(false);
//        File affix = new File("c:\\测试-test.txt");
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">" +
                "<head>" +
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" +
                "<title></title>" +
                "</head>" +
                "<body>" +
                "<div style=\"font-family: '楷体';font-size: 20px; width: 100%;\">" +
                "亲爱的" + entryName + "先生／小姐：<br />" +
                "&emsp;&emsp;很遗憾的通知您，您的转正考核成绩未能达标。公司本着公平的原则，为了挽留人才，特给您一次补考机会。" +
                "考试系统已为您准备了转正考核试题，请您在本周内登陆考试系统，完成转正补考。希望您认真复习，在本次补考中取得优异成绩。" +
                "若补考仍未能达标，则您将被视为没有通过使用考评，将被终止试用，解除劳动合同。特此通知！<br/>" +
                "祝：工作愉快！" +
                "<div style=\"width: 100%;text-align: right;\">恒银金融科技股份有限公司<br /></div>" +
                "<div style=\"width: 100%;text-align: right;\">客服技术中心--综合管理部<br /></div>" +
                "</div>" +
                "</body>" +
                "</html>");
        se.doSendHtmlEmail("欢迎辞暨试用期启动通知", String.valueOf(stringBuffer), mailAddr, null);
    }
}
