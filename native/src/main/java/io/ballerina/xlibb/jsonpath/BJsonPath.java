package io.ballerina.xlibb.jsonpath;

import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.JsonPathException;
import com.jayway.jsonpath.PathNotFoundException;
import io.ballerina.runtime.api.utils.JsonUtils;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;

import static com.jayway.jsonpath.JsonPath.using;
import static io.ballerina.xlibb.jsonpath.BaseTest.BJSON_CONFIGURATION;

/**
 * Provides native function implementation of json-path.
 */
public class BJsonPath {
    public static Object read(Object json, BString query) {
        try {
            Object result = using(BJSON_CONFIGURATION)
                    .parse(json.toString())
                    .read(query.getValue());
//            Object result = JsonPath.parse(json.toString()).read(query.getValue());
            return JsonUtils.parse(result.toString());
        } catch (PathNotFoundException e) {
            BError cause = Utils.createError(e.getMessage());
            return Utils.createError(Utils.getCanNotExecuteQueryErrorMessage(query), cause);
        } catch (IllegalArgumentException | JsonPathException e) {
            return Utils.createError(e.getMessage());
        }
    }

    public static Object read2(Object json, BObject query) {
        try {
            Object result = using(BJSON_CONFIGURATION)
                    .parse(json)
                    .read(StringUtils.getStringValue(query));
//            Object result = JsonPath.parse(json.toString()).read(StringUtils.getStringValue(query));
            return result;
        } catch (PathNotFoundException e) {
            BError cause = Utils.createError(e.getMessage());
            return Utils.createError(Utils.getCanNotExecuteQueryErrorMessage(StringUtils.
                fromString(StringUtils.getStringValue(query))), cause);
        } catch (IllegalArgumentException | JsonPathException e) {
            return Utils.createError(e.getMessage());
        }
    }
}
