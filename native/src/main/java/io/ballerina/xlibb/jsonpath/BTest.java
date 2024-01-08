package io.ballerina.xlibb.jsonpath;

import io.ballerina.runtime.api.values.BMap;

import static com.jayway.jsonpath.JsonPath.using;

public class BTest extends BaseTest {
    @Test
    public void an_object_can_be_read() {
        BMap book = using(JAKARTA_JSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[0]");

        assertThat(((JsonString) book.get("author")).getChars()).isEqualTo("Nigel Rees");
    }
}
