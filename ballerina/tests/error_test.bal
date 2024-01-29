import ballerina/test;

@test:Config {}
function errorTest() {
    json|Error result = readJson(j4, `$.a1[:]`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Failed to parse SliceOperation: :");

    result = readJson(j4, `#`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '#' on the provided JSON value");

    result = readJson({name: ""}, `$.id`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.id' on the provided JSON value");

    result = readJson("test", `$.id`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.id' on the provided JSON value");

    result = readJson(1, `$.a1[:]`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Failed to parse SliceOperation: :");

    result = readJson([j4], `$.a3[-1]`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.a3[-1]' on the provided JSON value");

    result = readJson(j4, `$.a1[-1].a12`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.a1[-1].a12' on the provided JSON value");

    result = readJson(j4, `$.a40.sum()`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.a40.sum()' on the provided JSON value");

    result = readJson(j1, `$.a1[1]`);
    test:assertTrue(result is Error);
    test:assertEquals((<Error> result).message(), "Unable to execute query '$.a1[1]' on the provided JSON value");
}