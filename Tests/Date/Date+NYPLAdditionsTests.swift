//
//  iOS-Utilities
//  Created by Ernest Fan on 2022-08-23.
//  Copyright © 2022 NYPL. All rights reserved.
//

import XCTest
@testable import NYPLUtilities

class Date_NYPLAdditionsTests: XCTestCase {
  let calendar: Calendar = {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar
  }()
  
  func testInvalidRFC3339Date() {
    XCTAssertNil(NSDate(rfc3339String:"not a date"))
    XCTAssertNil(NSDate(rfc3339String:""))
  }

  func testParsesRFC3339DateCorrectly() {
    let date = NSDate(rfc3339String: "1984-09-08T08:23:45Z")

    guard let date = date else {
      XCTFail()
      return
    }
    
    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
    XCTAssertNotNil(dateComponents)
    XCTAssertEqual(dateComponents.year, 1984);
    XCTAssertEqual(dateComponents.month, 9);
    XCTAssertEqual(dateComponents.day, 8);
    XCTAssertEqual(dateComponents.hour, 8);
    XCTAssertEqual(dateComponents.minute, 23);
    XCTAssertEqual(dateComponents.second, 45);
  }

  func testParsesRFC3339DateWithFractionalSecondsCorrectly() {
    let date = NSDate(rfc3339String:"1984-09-08T08:23:45.99Z")
    
    guard let date = date else {
      XCTFail()
      return
    }

    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
    XCTAssertNotNil(dateComponents)
    XCTAssertEqual(dateComponents.year, 1984);
    XCTAssertEqual(dateComponents.month, 9);
    XCTAssertEqual(dateComponents.day, 8);
    XCTAssertEqual(dateComponents.hour, 8);
    XCTAssertEqual(dateComponents.minute, 23);
    XCTAssertEqual(dateComponents.second, 45);
  }

  func testRFC3339RoundTrip() {
    let date = NSDate(rfc3339String:"1984-09-08T10:23:45+0200")
    XCTAssertNotNil(date)

    let dateString = date?.rfc3339String
    XCTAssertNotNil(dateString)

    XCTAssertEqual(dateString, "1984-09-08T08:23:45Z")
  }
}
