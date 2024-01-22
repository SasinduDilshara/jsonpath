import ballerina/'lang.'int as integer;
import ballerina/lang.'float as fl;
import ballerina/test;

@test:Config {}
function testSelectAllExpression() returns error? {
    JsonPathRawTemplate jsonpath = `$.*`;

    json result = check readJson(decimalJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[2.34, 3.65, (), 4.12, 0.0, 0.0, 2.34]);
    json[] resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 7);
    test:assertTrue(resultsArray[0] is float);
    test:assertTrue(resultsArray[1] is float);
    test:assertTrue(resultsArray[2] is ());
    test:assertTrue(resultsArray[3] is float);
    test:assertTrue(resultsArray[4] is float);
    test:assertTrue(resultsArray[5] is float);
    test:assertTrue(resultsArray[6] is float);

    result = check readJson(floatJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]> [1.23, 4.32, fl:Infinity, -fl:Infinity, (), 4.12, 0.0, 0.0, 1.23]);
    resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 9);
    test:assertTrue(resultsArray[0] is float);
    test:assertTrue(resultsArray[1] is float);
    test:assertTrue(resultsArray[2] is float);
    test:assertTrue(resultsArray[3] is float);
    test:assertTrue(resultsArray[4] is ());
    test:assertTrue(resultsArray[5] is float);
    test:assertTrue(resultsArray[6] is float);
    test:assertTrue(resultsArray[7] is float);
    test:assertTrue(resultsArray[8] is float);

    result = check readJson(intJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]> [1, -1, 0, 0, integer:MAX_VALUE, integer:MIN_VALUE, 2, 2, (), 1]);
    resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 10);
    test:assertTrue(resultsArray[0] is int);
    test:assertTrue(resultsArray[1] is int);
    test:assertTrue(resultsArray[2] is int);
    test:assertTrue(resultsArray[3] is int);
    test:assertTrue(resultsArray[4] is int);
    test:assertTrue(resultsArray[5] is int);
    test:assertTrue(resultsArray[6] is int);
    test:assertTrue(resultsArray[7] is int);
    test:assertTrue(resultsArray[8] is ());
    test:assertTrue(resultsArray[9] is int);

    result = check readJson(booleanJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]> [true, false, true, (), false, true]);
    resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 6);
    test:assertTrue(resultsArray[0] is boolean);
    test:assertTrue(resultsArray[1] is boolean);
    test:assertTrue(resultsArray[2] is boolean);
    test:assertTrue(resultsArray[3] is ());
    test:assertTrue(resultsArray[4] is boolean);
    test:assertTrue(resultsArray[5] is boolean);

    result = check readJson(stringJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]> ["", "string", "a", "string", (), "string", ""]);
    resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 7);
    test:assertTrue(resultsArray[0] is string);
    test:assertTrue(resultsArray[1] is string);
    test:assertTrue(resultsArray[2] is string);
    test:assertTrue(resultsArray[3] is string);
    test:assertTrue(resultsArray[4] is ());
    test:assertTrue(resultsArray[5] is string);
    test:assertTrue(resultsArray[6] is string);

    result = check readJson(nilJson, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [(), (), ()]);
    resultsArray = <json[]>result;
    test:assertEquals(resultsArray.length(), 3);
    test:assertTrue(resultsArray[0] is ());
    test:assertTrue(resultsArray[1] is ());
    test:assertTrue(resultsArray[2] is ());

    result = check readJson(j1, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [decimalJson, floatJson, intJson, booleanJson, stringJson, nilJson, intJson]);

    result = check readJson(j2, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [jsonMap, jsonMap, {}]);

    result = check readJson(j3, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[j1, j2, n1, i1, <float>d1, f1, b1, s1]);

    result = check readJson(j4, jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [[decimalJson, intJson, floatJson], [nilJson, stringJson, booleanJson], []]);
}

@test:Config {}
function testSelectElementExpression() returns error? {
    string expression = "$.a1";
    string elementName = "a1";

    json result = check readJson(decimalJson, `$.a1`);
    test:assertTrue(result is float);
    test:assertEquals(result, 2.34);

    result = check readJson(floatJson, `$.${elementName}`);
    test:assertTrue(result is float);
    test:assertEquals(result, 1.23);

    result = check readJson(intJson, `$.a1`);
    test:assertTrue(result is int);
    test:assertEquals(result, 1);

    result = check readJson(booleanJson, `$.${elementName}`);
    test:assertTrue(result is boolean);
    test:assertEquals(result, true);

    result = check readJson(stringJson, `$.${elementName}`);
    test:assertTrue(result is string);
    test:assertEquals(result, "");

    result = check readJson(nilJson, `$.a1`);
    test:assertTrue(result is ());
    test:assertEquals(result, ());

    result = check readJson(j1, `${expression}`);
    test:assertEquals(result, decimalJson);

    result = check readJson(j2, `${expression}`);
    test:assertTrue(result is map<json>);
    test:assertEquals(result, jsonMap);

    result = check readJson(j3, `$.a1`);
    test:assertEquals(result, j1);

    result = check readJson(j4, `$.a1`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [decimalJson, intJson, floatJson]);
}

@test:Config {}
function testNestedSelectElementExpression() returns error? {
    string expression = "$.a1.a1";
    string nestedElementName = "a1.a1";

    check checkNestedSelectElementExpression(`$.a1.a1`);
    check checkNestedSelectElementExpression(`$.${nestedElementName}`);
    check checkNestedSelectElementExpression(`${expression}`);
}

@test:Config {}
function testSelectElementWithWildcardExpression() returns error? {
    JsonPathRawTemplate jsonpath = `$..*`;
    json [] assertResult = [decimalJson, floatJson, intJson, booleanJson, stringJson, nilJson, intJson, 
        2.34, 3.65, (), 4.12, 0.0, -0.0, 2.34, 1.23, 4.32, fl:Infinity, -fl:Infinity, 
        (), 4.12, 0.0, -0.0, 1.23, 1, -1, 0, -0, integer:MAX_VALUE, integer:MIN_VALUE, 
        2, 2, (), 1, true, false, true, (), false, true, "", "string", "a", "string",
        (), "string", "", (), (), (), 1, -1, 0, -0, integer:MAX_VALUE, integer:MIN_VALUE, 2, 2, (), 1];

    json result = check readJson(j1, jsonpath);
    test:assertEquals(result, assertResult);

    result = check readJson(j2, jsonpath);
    test:assertEquals(result, <json[]>[jsonMap, jsonMap, {}, ...assertResult, ...assertResult]);

    // result = check readJson(j3, jsonpath);
    // test:assertEquals(result, <json[]>[j1, j2, n1, i1, d1, f1, b1, s1, ...assertResult, jsonMap, jsonMap, {}, ...assertResult, ...assertResult]);

    // result = check readJson(j4, jsonpath);
    // test:assertEquals(result, assertResult);
}

@test:Config {}
function testSelectElementByIndexExpression() returns error? {
    string expression = "$[0]";
    JsonPathRawTemplate jsonpath = `$[0]`;

    int index = 5;

    json result = check readJson([d1, d2, f1, f2], jsonpath);
    test:assertTrue(result is decimal);
    test:assertEquals(result, <decimal>2.34);

    result = check readJson([d1, s1, n2, b6], `$[${3}]`);
    test:assertTrue(result is boolean);
    test:assertEquals(result, true);

    result = check readJson([n1, d3, f3, b4, s1, s5], `$[${index}]`);
    test:assertTrue(result is ());
    test:assertEquals(result, ());

    result = check readJson([(), (), ()], `${expression}`);
    test:assertTrue(result is ());
    test:assertEquals(result, ());

    result = check readJson([jsonMap], `$${"["}0${"]"}`);
    test:assertTrue(result is map<json>);
    test:assertEquals(result, jsonMap);

    result = check readJson([j4], `$[0]`);
    test:assertEquals(result, j4);

    result = check readJson(j4, `$.a1[0]`);
    test:assertEquals(result, decimalJson);

    result = check readJson(check j4?.a1, jsonpath);
    test:assertEquals(result, decimalJson);
}

@test:Config {}
function testSelectElementByIndexRangeExpression() returns error? {
    JsonPathRawTemplate jsonpath = `$[0:2]`;

    int index = 0;

    json result = check readJson([j1, j2, j3, j4], jsonpath);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [j1, j2]);

    result = check readJson([j1, j2, j3, j4], `$[3].a1[${index}:${index + 3}]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [decimalJson, intJson, floatJson]);

    result = check readJson(j4, `$.a1[0:]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [decimalJson, intJson, floatJson]);

    result = check readJson(j4, `$.a1[:2]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, [decimalJson, intJson]);

    result = check readJson(j4, `$.a1[10:3]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, []);

    result = check readJson(j4, `$.a1[-1:-2]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, []);

    result = check readJson(j4, `$.a1[-1:-100]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, []);

    // check
    result = check readJson(j4, `$.a1[-1:10]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[floatJson, decimalJson, intJson, floatJson]);

    result = check readJson(j4, `$.a1[-1:1]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[floatJson, decimalJson]);

    result = check readJson(j4, `$.a1[-3:-1]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[decimalJson, intJson]);

    result = check readJson(j4, `$.a1[2:10]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[floatJson]);

    result = check readJson(j4, `$.a1[-2:]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[intJson, floatJson]);

    result = check readJson(j4, `$.a1[:-2]`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, <json[]>[decimalJson]);
}

function checkNestedSelectElementExpression(JsonPathRawTemplate jsonpath) returns error? {
    json result = check readJson(j1, jsonpath);
    test:assertTrue(result is float);
    test:assertEquals(result, 2.34);

    result = check readJson(j2, jsonpath);
    test:assertEquals(result, decimalJson);

    result = check readJson(j3, jsonpath);
    test:assertEquals(result, decimalJson);
}
