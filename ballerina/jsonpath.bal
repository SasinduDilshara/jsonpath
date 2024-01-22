import ballerina/jballerina.java;
import ballerina/lang.'object as obj;

public type JsonPathValue ()|boolean|int|float|decimal|string|json[]|map<json>;

public type JsonPathRawTemplate object {
    *obj:RawTemplate;
    public (string[] & readonly) strings;
    public JsonPathValue[] insertions;
};

# Extract details from the given JSON value using the provided query template expression
# + 'json - JSON value
# + query - JSON path expression
# + return - extracted details as JSON value, a jsonpath:Error otherwise
public isolated function readJson(json 'json, JsonPathRawTemplate query) returns json|Error {
    return read2('json, new JsonPathRawTemplateImpl(query));
}

public class JsonPathRawTemplateImpl {
    *object:RawTemplate;
    public string[] & readonly strings;
    public JsonPathValue[] insertions;

    public isolated function init(JsonPathRawTemplate jsonPathRawTemplate) {
        self.strings = jsonPathRawTemplate.strings;
        self.insertions = jsonPathRawTemplate.insertions;
    }
}

# Extract details from the given JSON value using the provided query expression
# + 'json - JSON value
# + query - JSON path expression
# + return - extracted details as JSON value, a jsonpath:Error otherwise
public isolated function read2(json 'json, JsonPathRawTemplateImpl query) returns json|Error = @java:Method {
    'class: "io.ballerina.xlibb.jsonpath.BJsonPath"
} external;
