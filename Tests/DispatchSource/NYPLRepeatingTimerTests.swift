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
  
  func testTimerResumeAndSuspend() throws {
    XCTAssertEqual(timer.state, .resumed)
    
    timer.suspend()
    
    XCTAssertEqual(timer.state, .suspended)
    
    timer.resume()
    
    XCTAssertEqual(timer.state, .resumed)
  }

  func testTimerResumeMultipleCall() throws {
    timer.resume()
    timer.resume()
    timer.resume()
    timer.resume()
    
    XCTAssertEqual(timer.state, .resumed)
  }
  
  func testTimerSuspendMultipleCall() throws {
    timer.suspend()
    timer.suspend()
    timer.suspend()
    timer.suspend()
    
    XCTAssertEqual(timer.state, .suspended)
  }

}
