import static com.jayway.jsonpath.JsonPath.using;

import io.ballerina.xlibb.jsonpath.BaseTest;
import org.junit.Test;
import static org.hamcrest.MatcherAssert.assertThat;

public class BTest extends BaseTest {
    @Test
    public void an_object_can_be_read() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[0]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                book.toString().equals("{\"category\":\"reference\",\"author\":\"Nigel Rees\",\"title\":\"Sayings of the Century\",\"display-price\":8.95}"));
    }

    @Test
    public void an_object_can_be_read2() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[*]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                book.toString().equals("" +
                        "[{\"category\":\"reference\",\"author\":\"Nigel Rees\",\"title\":\"Sayings of the Century\",\"display-price\":8.95},{\"category\":\"fiction\",\"author\":\"Evelyn Waugh\",\"title\":\"Sword of Honour\",\"display-price\":12.99},{\"category\":\"fiction\",\"author\":\"Herman Melville\",\"title\":\"Moby Dick\",\"isbn\":\"0-553-21311-3\",\"display-price\":8.99},{\"category\":\"fiction\",\"author\":\"J. R. R. Tolkien\",\"title\":\"The Lord of the Rings\",\"isbn\":\"0-395-19395-8\",\"display-price\":22.99}]"));
    }

//    @Test
//    public void an_object_can_be_read3() {
//        Object book = using(BJSON_CONFIGURATION)
//                .parse(JSON_DOCUMENT)
//                .read("$.store.bicycle[*]");
//
//        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
//                //TODO: Check
//                book.toString().equals("" +
//                        "[\"baz\",\"Es\f\n" +
//                        "\t\n" +
//                        "\t*\",\"red\",19.95,\"fooBar\",\"new\",\"dashes\"]"));
//    }

    @Test
    public void an_object_can_be_read4() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[?(@.display-price>9)]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                //TODO: Check
                book.toString().equals("" +
                        "[{\"category\":\"fiction\",\"author\":\"Evelyn Waugh\",\"title\":\"Sword of Honour\",\"display-price\":12.99},{\"category\":\"fiction\",\"author\":\"J. R. R. Tolkien\",\"title\":\"The Lord of the Rings\",\"isbn\":\"0-395-19395-8\",\"display-price\":22.99}]"));
    }

    @Test
    public void an_object_can_be_read5() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[?(@.category==\"reference\")]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                //TODO: Check
                book.toString().equals("" +
                        "[{\"category\":\"reference\",\"author\":\"Nigel Rees\",\"title\":\"Sayings of the Century\",\"display-price\":8.95}]"));
    }

    @Test
    public void an_object_can_be_read6() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.store.book[?(@.display-price>9.001)]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                //TODO: Check
                book.toString().equals("" +
                        "[{\"category\":\"fiction\",\"author\":\"Evelyn Waugh\",\"title\":\"Sword of Honour\",\"display-price\":12.99},{\"category\":\"fiction\",\"author\":\"J. R. R. Tolkien\",\"title\":\"The Lord of the Rings\",\"isbn\":\"0-395-19395-8\",\"display-price\":22.99}]"));
    }

    @Test
    public void an_object_can_be_read7() {
        Object book = using(BJSON_CONFIGURATION)
                .parse(JSON_DOCUMENT)
                .read("$.[\"store\"].[\"book\"][*]");

        assertThat("Test Failed, expected:- Nigel Rees, found" + book.toString(),
                book.toString().equals("" +
                        "[{\"category\":\"reference\",\"author\":\"Nigel Rees\",\"title\":\"Sayings of the Century\",\"display-price\":8.95},{\"category\":\"fiction\",\"author\":\"Evelyn Waugh\",\"title\":\"Sword of Honour\",\"display-price\":12.99},{\"category\":\"fiction\",\"author\":\"Herman Melville\",\"title\":\"Moby Dick\",\"isbn\":\"0-553-21311-3\",\"display-price\":8.99},{\"category\":\"fiction\",\"author\":\"J. R. R. Tolkien\",\"title\":\"The Lord of the Rings\",\"isbn\":\"0-395-19395-8\",\"display-price\":22.99}]"));
    }
}
