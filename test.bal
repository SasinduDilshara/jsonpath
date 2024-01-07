import ballerina/io;
import ballerina/lang.'xml;
public function main() returns error? {


    xml x = xml `<book>Hamlet</book><book>Macbeth</book>`;
    xml mappedXml = x.map(function (xml xmlContent) returns xml =>
    xml `<book kind="play">${xmlContent.children()}</book>` 
    );

    string y = x.;
    io:println(y);
}