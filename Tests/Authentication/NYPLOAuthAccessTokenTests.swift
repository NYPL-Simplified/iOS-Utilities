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
    let token = NYPLOAuthAccessToken.fromData(data)
    XCTAssertNotNil(token)
    XCTAssertEqual(token?.accessToken, "cazzo.strunz")
    XCTAssertEqual(token?.expiresIn, 3600)
    XCTAssertEqual(token?.tokenType, "Bearer")
  }

  func testOAuthAccessTokenParsingUTF8() {
    guard let data = tokenJSON.data(using: .utf8) else {
      XCTFail("Failed to parse valid token as utf8")
      return
    }
    let token = NYPLOAuthAccessToken.fromData(data)
    XCTAssertNotNil(token)
    XCTAssertEqual(token?.accessToken, "cazzo.strunz")
    XCTAssertEqual(token?.expiresIn, 3600)
    XCTAssertEqual(token?.tokenType, "Bearer")
  }
}
