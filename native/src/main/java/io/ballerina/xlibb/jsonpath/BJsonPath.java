package io.ballerina.xlibb.jsonpath;

import com.jayway.jsonpath.JsonPathException;
import com.jayway.jsonpath.PathNotFoundException;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BObject;

import static com.jayway.jsonpath.JsonPath.using;
import static io.ballerina.xlibb.jsonpath.BaseTest.BJSON_CONFIGURATION;
import static io.ballerina.xlibb.jsonpath.Utils.convertRawTemplateToString;

/**
 * Provides native function implementation of json-path.
 */
public class BJsonPath {
    public static Object read2(Object json, BObject query) {
        try {
            return using(BJSON_CONFIGURATION)
                    .parse(json)
                    .read(convertRawTemplateToString(query));
        } catch (PathNotFoundException e) {
            BError cause = Utils.createError(e.getMessage());
            return Utils.createError(Utils.getCanNotExecuteQueryErrorMessage(StringUtils.
                fromString(convertRawTemplateToString(query))), cause);
        } catch (IllegalArgumentException | JsonPathException e) {
            return Utils.createError(e.getMessage());
        }
    }
}
