package com.rcbank.mms;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.rcbank.mms.util.DatePattern;
import com.rcbank.mms.util.DateTimeUtils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Wayne on 2015/6/29.
 */
public class JsonDateSerializer extends JsonSerializer<Date> {

    @Override
    public void serialize(Date value, JsonGenerator gen, SerializerProvider serializers) throws
            IOException, JsonProcessingException {
        SimpleDateFormat formatter = new SimpleDateFormat(DateTimeUtils.getDatePattern(DatePattern
                .TIME_WITH_MINUS.getValue()));
        String formattedDate = formatter.format(value);
        gen.writeString(formattedDate);
    }
}
