//
//  SHA256Tests.swift
//  Created by Ettore Pasquini on 12/29/21.
//  Copyright © 2020 NYPL. All rights reserved.
//

import Foundation
import XCTest
import CryptoKit
@testable import NYPLUtilities

class SHA256Tests: XCTestCase {
  @available(iOS 13, *)
  func testSHA256ObjcAndSwift() {
    // actual string format we're hashing in SimplyE
    let audiobookId = "urn:librarysimplified.org/terms/id/Overdrive%20ID/2f33f6a1-e645-4acd-b994-92bef5494010"
    let spineKey = "\(audiobookId)-0"

    // create a hash using Apple's CryptoKit (iOS 13+) as a way to verify the
    // correctedness of our code
    let spineKeyData = Data(spineKey.utf8)
    let cryptoKitHashDigest = SHA256.hash(data: spineKeyData)
    let cryptoKitHash = cryptoKitHashDigest.compactMap {
      String(format: "%02x", $0)
    }.joined()

    // test
    let spineKeyHash = spineKey.sha256

    // test secondary function
    let rsaUtilsHashData = RSAUtils.SHA256HashedData(from: spineKeyData as NSData)
    let rsaUtilsHash = rsaUtilsHashData.compactMap {
      String(format: "%02x", $0)
    }.joined()

    // verify
    XCTAssertEqual(spineKeyHash, cryptoKitHash)
    XCTAssertEqual(rsaUtilsHash, cryptoKitHash)
  }

  func testSHA256() {
    XCTAssertEqual("967824¬Ó¨⁄€™®©♟♞♝♜♛♚♙♘♗♖♕♔".sha256,
                   "269b80eff0cd705e4b1de9fdbb2e1b0bccf30e6124cdc3487e8d74620eedf254")
  }
}
