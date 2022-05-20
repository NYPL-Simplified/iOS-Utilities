//
//  iOS-Utilities
//  Created by Ettore Pasquini on 5/19/22.
//  Copyright © 2022 NYPL. All rights reserved.
//


import XCTest
import NYPLUtilities

class DictionaryFlattenTests: XCTestCase {

  func testIdempotentFlatten() throws {
    let dict: [String: Any] = ["key1": 1, "key2": "val2"]
    let flattened = dict.flattenToStringsAndNumbers()
    XCTAssertEqual(dict.keys, flattened.keys)
    XCTAssertEqual(flattened["key1"] as! Int, 1)
    XCTAssertEqual(flattened["key2"] as! String, "val2")
  }

  func testArrayNesting() throws {
    let dict: [String: Any] = ["key1": [1, "two"], "key2": "val2"]
    let flattened = dict.flattenToStringsAndNumbers()
    XCTAssertEqual(dict.keys, flattened.keys)
    XCTAssertEqual(flattened["key1"] as! String, "[1, \"two\"]")
    XCTAssertEqual(flattened["key2"] as! String, "val2")
  }

  func testNumberTypes() throws {
    let dict: [String: Any] = ["-1": Int(-1),
                               "0": 0,
                               "1": UInt(1),
                               "2": Double(2.2),
                               "3": NSNumber(value: 3.3),
                               "4": Decimal(4.4)]
    let flattened = dict.flattenToStringsAndNumbers()
    XCTAssertEqual(dict.keys, flattened.keys)
    flattened.values.forEach {
      XCTAssert($0 is NSNumber)
    }
    XCTAssertEqual(flattened["-1"] as! NSNumber, NSNumber(value: -1))
    XCTAssertEqual(flattened["0"] as! NSNumber, NSNumber(value: 0))
    XCTAssertEqual(flattened["1"] as! NSNumber, NSNumber(value: 1))
    XCTAssertEqual(flattened["2"] as! NSNumber, NSNumber(floatLiteral: 2.2))
    XCTAssertEqual(flattened["2"] as! NSNumber, NSNumber(value: 2.2))
    XCTAssertEqual(flattened["2"] as! NSNumber, NSNumber(value: Double(2.2)))
    XCTAssertEqual(flattened["3"] as! NSNumber, NSNumber(value: 3.3))
    XCTAssertEqual(flattened["4"] as! NSNumber, NSNumber(value: 4.4))
  }

  func testDictionaryNesting() throws {
    let dict: [String: Any] = ["str": "ciao",
                               "num": 444,
                               "dict": ["nestkey1": "nest_val1",
                                        "nestkey2": 2,
                                        "nestkey3": "nest_val3",
                                        "nestkey4": ["4", 44.4],
                                        "nestkey5": ["subkey1": "sub1",
                                                     "subkey2": ["abc", 6]
                                                    ]
                                       ]]
    let flattened = dict.flattenToStringsAndNumbers()
    XCTAssertEqual(flattened.keys.count, 8)

    XCTAssertEqual(flattened["str"] as! String, "ciao")
    XCTAssertEqual(flattened["num"] as! NSNumber, 444)
    XCTAssertNil(flattened["dict"])
    XCTAssertEqual(flattened["dict_nestkey1"] as! String, "nest_val1")
    XCTAssertEqual(flattened["dict_nestkey2"] as! NSNumber, 2)
    XCTAssertEqual(flattened["dict_nestkey3"] as! String, "nest_val3")
    XCTAssertEqual(flattened["dict_nestkey4"] as! String, "[\"4\", 44.4]")
    XCTAssertNil(flattened["dict_nestkey5"])
    XCTAssertEqual(flattened["dict_nestkey5_subkey1"] as! String, "sub1")
    XCTAssertEqual(flattened["dict_nestkey5_subkey2"] as! String, "[\"abc\", 6]")
  }
}
