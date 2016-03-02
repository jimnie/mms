package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Message;
import com.educonsulting.mms.service.MessageService;
import org.springframework.stereotype.Service;

/**
 * Created by Wayne on 2015/6/1.
 */
@Service("messageServiceImpl")
public class MessageServiceImpl extends BaseServiceImpl<Message, String> implements MessageService {

}
