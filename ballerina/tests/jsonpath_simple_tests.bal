import ballerina/test;

final readonly & json value = {
  "event": {
    "name":"Bond Movies",
    "movies": [
      {
        "name": "Licence to Kill",
        "star": "Timothy Dalton",
        "rating": 6.6
      },
      {
        "name": "GoldenEye",
        "star": "Pierce Brosnan",
        "rating": 7.2
      },
      {
        "name": "Tomorrow Never Dies",
        "star": "Pierce Brosnan",
        "rating": 6.5
      },
      {
        "name": "Skyfall",
        "star": "Daniel Craig",
        "rating": 7.8
      }
    ]
  }
};

@test:Config {}
isolated function testQuery() returns error? {
    json result = check readJson(value, `$.event.movies`);
    test:assertTrue(result is json[]);
    test:assertEquals(result, (<json[]> [
        {
          "name": "Licence to Kill",
          "star": "Timothy Dalton",
          "rating": 6.6
        },
        {
          "name": "GoldenEye",
          "star": "Pierce Brosnan",
          "rating": 7.2
        },
        {
          "name": "Tomorrow Never Dies",
          "star": "Pierce Brosnan",
          "rating": 6.5
        },
        {
          "name": "Skyfall",
          "star": "Daniel Craig",
          "rating": 7.8
        }
    ]));
}

@test:Config {}
isolated function testQuery2() returns error? {
    json result = check readJson(value, `$.event.name`);
    test:assertEquals(result, "Bond Movies");
}

@test:Config {}
isolated function testQuery3() returns error? {
    json result = check readJson(value, `$.event.${"name"}`);
    test:assertEquals(result, "Bond Movies");
}

@test:Config {}
isolated function testQuery4() returns error? {
    json result = check readJson(value, `$.event.movies[?(@.rating>7)]`);
    test:assertEquals(result, <json[]>[
      {
        "name": "GoldenEye",
        "star": "Pierce Brosnan",
        "rating": 7.2
      },
      {
        "name": "Skyfall",
        "star": "Daniel Craig",
        "rating": 7.8
      }
    ]);
}

@test:Config {}
isolated function testQuery5() returns error? {
  int a = 7;
    json result = check readJson(value, `$.event.movies[?(@.rating>${a})]`);
    test:assertEquals(result, <json[]>[
        {
          "name": "GoldenEye",
          "star": "Pierce Brosnan",
          "rating": 7.2
        },
        {
          "name": "Skyfall",
          "star": "Daniel Craig",
          "rating": 7.8
        }
    ]);
}

@test:Config {}
function testQuery6() returns error? {
    json result = check readJson(value, `$..movies.length()`);
    test:assertEquals(result, 4);
}

@test:Config {}
function testQuery7() returns error? {
    json result = check readJson(value, `$.max($.event.movies..rating)`);
    test:assertEquals(result, 7.8);
}

@test:Config {}
function testQuery8() returns error? {
    json result = check readJson(value, `$..rating.avg()`);
    test:assertEquals(result, 28.1/4);
}
