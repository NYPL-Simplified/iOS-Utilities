//
//  iOS-Utilities
//  Created by Ettore Pasquini on 3/25/22.
//  Copyright © 2022 NYPL. All rights reserved.
//


import Foundation
import XCTest
@testable import NYPLUtilities

class NYPLOAuthAccessTokenTests: XCTestCase {
  let tokenJSON = """
    {
    "access_token": "cazzo.strunz",
    "expires_in": 3600,
    "token_type": "Bearer"
    }
    """

  func testOAuthAccessTokenParsingNonLossyASCII() {
    guard let data = tokenJSON.data(using: .nonLossyASCII) else {
      XCTFail("Failed to parse valid token as nonLossyASCII")
      return
    }
    guard let token = NYPLOAuthAccessToken.fromData(data) else {
      XCTFail("nil token! Probably a parse failure")
      return
    }
    XCTAssertEqual(token.accessToken, "cazzo.strunz")
    XCTAssertEqual(token.expiresIn, 3600)
    XCTAssertEqual(token.tokenType, "Bearer")
    XCTAssertGreaterThan(token.expiration, token.creation)
    XCTAssertGreaterThan(token.expiration, Date(timeInterval: token.expiresIn - 1, since: Date()))
    XCTAssertLessThan(token.expiration, Date(timeInterval: token.expiresIn, since: Date()))
  }

  func testOAuthAccessTokenParsingUTF8() {
    guard let data = tokenJSON.data(using: .utf8) else {
      XCTFail("Failed to parse valid token as utf8")
      return
    }
    guard let token = NYPLOAuthAccessToken.fromData(data) else {
      XCTFail("nil token! Probably a parse failure")
      return
    }
    XCTAssertEqual(token.accessToken, "cazzo.strunz")
    XCTAssertEqual(token.expiresIn, 3600)
    XCTAssertEqual(token.tokenType, "Bearer")
    XCTAssertGreaterThan(token.expiration, token.creation)
    XCTAssertGreaterThan(token.expiration, Date(timeInterval: token.expiresIn - 1, since: Date()))
    XCTAssertLessThan(token.expiration, Date(timeInterval: token.expiresIn, since: Date()))
  }
}
