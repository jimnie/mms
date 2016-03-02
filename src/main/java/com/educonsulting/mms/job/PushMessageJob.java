package com.educonsulting.mms.job;

import com.educonsulting.mms.service.MessageService;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component("pushMessageJob")
@Lazy(false)
public class PushMessageJob {

    @Resource(name = "messageServiceImpl")
    private MessageService messageService;

    @Scheduled(cron = "${job.push_message.cron}")
    public void pushMessage() {
        System.out.println("Being push message.");
    }

}