package com.educonsulting.mms.job;

//@Component("pushMessageJob")
//@Lazy(false)
public class PushMessageJob {

//    @Resource(name = "messageServiceImpl")
//    private MessageService messageService;

    //    @Scheduled(cron = "${job.push_message.cron}")
    public void pushMessage() {
        System.out.println("Being push message.");
    }

}