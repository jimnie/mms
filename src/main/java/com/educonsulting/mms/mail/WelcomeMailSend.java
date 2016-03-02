package com.educonsulting.mms.mail;

/**
 * Created by Songwc on 2015/11/19.
 * 入职资料确认后发送的：欢迎辞暨试用期启动通知
 */

public class WelcomeMailSend {
    public void welcomeMailSend(String entryName, String mailAddr, String trialDate) {
        MailWithAttachment se = new MailWithAttachment(false);
//        File affix = new File("c:\\测试-test.txt");
//        se.doSendHtmlEmail("邮件主题", "邮件内容", "xxx@XXX.com", affix);
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">" +
                "<head>" +
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" +
                "<title></title>" +
                "</head>" +
                "<body>" +
                "<div style=\"font-family: '楷体';font-size: 14px; width: 100%;\">" +
                "亲爱的" + entryName + "先生／小姐：<br />" +
                "&emsp;&emsp;" +
                "欢迎您加入恒银金融科技股份有限公司。我们为拥有您这样的伙伴而自豪。我们希望，您能对自己的选择感到同样的自豪，在这里，您将结识新的同伴！<br />" +
                "&emsp;&emsp;为了方便您在公司的工作与生活，友情提醒如下：<br />" +
                "&emsp;&emsp;1" +
                ".公司将为您建立、保管人事资料，并根据上级对您的工作评价和公司的薪资标准，制定或调整您的薪酬，公司将按国家有关规定替您购买五险一金。<br />" +
                "&emsp;&emsp;2.根据您的入职时间及公司相关规定，您的试用期将从" + trialDate +
                "开始计算，为期三个月。期间，您须学习公司的企业文化及相关管理制度，并接受相关培训。试用期的最后一个月，您须参加转正考核，考核合格后将成为公司正式员工，享受公司各项的福利制度。<br />" +
                "&emsp;&emsp;3.公司员工通讯录和相关规章制度均存放在公司OA系统上，您可以登录查阅。<br />" +
                "&emsp;&emsp;4.公司总部坐落于天津自贸区（空港经济区）西八道30号，您可选择乘坐地铁二号线，与空港经济区站换乘692" +
                "路公交车，在西八道站下车，即可到达公司总部。<br />" +
                "&emsp;&emsp;5.公司总部总机为022-24828888，总部座机拨打外线须先按“0”。<br />" +
                "&emsp;&emsp;6.公司总部的工作时间为星期一至星期五，每天上班时间为8:30-17:30，午休时间为12:00-13:00" +
                "，您可在公司食堂享受美味午餐。<br />" +
                "&emsp;&emsp;7.公司总部园区内禁止吸烟，办公区内禁止用餐、吃零食。<br />" +
                "&emsp;&emsp;我们真诚希望您能迅速适应、喜欢公司的环境。公司认为，您的愉快与工作成功同等重要。<br />" +
                "&emsp;&emsp;我们同样希望，在您完成本职工作的同时，能与公司一起不断发展、成长。<br />" +
                "&emsp;&emsp;预祝您工作、生活愉快！<br /></span>" +
                "<div style=\"width: 100%;text-align: right;\">恒银金融科技股份有限公司<br /></div>" +
                "<div style=\"width: 100%;text-align: right;\">客服技术中心--综合管理部<br /></div>" +
                "</div>" +
                "</body>" +
                "</html>");
        se.doSendHtmlEmail("欢迎辞暨试用期启动通知", String.valueOf(stringBuffer), mailAddr, null);
    }
}
