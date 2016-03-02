package com.educonsulting.mms;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

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
        SimpleDateFormat formatter = new SimpleDateFormat(CommonAttributes.getDatePattern(7));
        String formattedDate = formatter.format(value);
        gen.writeString(formattedDate);
    }
}
