//
//  NYPLRepeatingTimerTests.swift
//  NYPLUtilitiesTests
//
//  Created by Ernest Fan on 2022-03-10.
//

import XCTest
@testable import NYPLUtilities

class NYPLRepeatingTimerTests: XCTestCase {

  var timer: NYPLRepeatingTimer!
  
  override func setUp() {
    timer = NYPLRepeatingTimer(interval: .seconds(1), handler: {})
  }

  override func tearDown() {
    timer = nil
  }

  func testTimerResumeMultipleCall() throws {
    timer.resume()
    timer.resume()
    timer.resume()
    timer.resume()
    
    XCTAssert(true)
  }
  
  func testTimerSuspendMultipleCall() throws {
    timer.suspend()
    timer.suspend()
    timer.suspend()
    timer.suspend()
    
    XCTAssert(true)
  }

}
