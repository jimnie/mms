package com.rcbank.mms.service.impl;

import com.rcbank.mms.Message;
import com.rcbank.mms.service.MessageService;
import org.springframework.stereotype.Service;

/**
 * Created by Wayne on 2015/6/1.
 */
@Service("messageServiceImpl")
public class MessageServiceImpl extends BaseServiceImpl<Message, Long> implements MessageService {

}
