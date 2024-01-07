package io.ballerina.xlibb.jsonpath;

import com.jayway.jsonpath.InvalidJsonException;
import com.jayway.jsonpath.spi.json.AbstractJsonProvider;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.utils.JsonUtils;

import java.io.InputStream;

public class BJsonProvider extends AbstractJsonProvider {
    /**
     * Parse the given json string
     *
     * @param json json string to parse
     * @return Object representation of json
     * @throws InvalidJsonException
     */
    @Override
    public Object parse(String json) throws InvalidJsonException {
        return JsonUtils.parse(json);
    }

    /**
     * Parse the given json bytes in UTF-8 encoding
     *
     * @param json json bytes to parse
     * @return Object representation of json
     * @throws InvalidJsonException
     */
    @Override
    public Object parse(byte[] json) throws InvalidJsonException {
        return super.parse(json);
    }

    /**
     * Parse the given json string
     *
     * @param jsonStream input stream to parse
     * @param charset    charset to use
     * @return Object representation of json
     * @throws InvalidJsonException
     */
    @Override
    public Object parse(InputStream jsonStream, String charset) throws InvalidJsonException {
        return JsonUtils.parse(jsonStream, charset);
    }

    /**
     * Convert given json object to a json string
     *
     * @param obj object to transform
     * @return json representation of object
     */
    @Override
    public String toJson(Object obj) {
        return JsonUtils.convertToJson(obj);
    }

    /**
     * Creates a provider specific json array
     *
     * @return new array
     */
    @Override
    public Object createArray() {
        return null;
    }

    /**
     * Creates a provider specific json object
     *
     * @return new object
     */
    @Override
    public Object createMap() {
        return null;
    }
}
