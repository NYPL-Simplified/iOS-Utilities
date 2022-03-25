//
//  NYPLOAuthAccessToken.swift
//  Created by Ettore Pasquini on 5/19/20.
//  Copyright © 2020 NYPL. All rights reserved.
//

import Foundation

public struct NYPLOAuthAccessToken: Decodable {
  public let accessToken: String
  public let expiresIn: TimeInterval? // Optional because non-essential

  private let tokenTypeInternal: String?

  /// Defaults to `Bearer` type in case an actual token type is missing.
  public var tokenType: String {
    return tokenTypeInternal ?? "Bearer"
  }

  enum CodingKeys: String, CodingKey {
    case accessToken, expiresIn
    case tokenTypeInternal = "tokenType"
  }

  public static func fromData(_ data: Data) -> NYPLOAuthAccessToken? {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return try? jsonDecoder.decode(NYPLOAuthAccessToken.self, from: data)
  }
}
