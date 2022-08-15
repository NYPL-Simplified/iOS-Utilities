//
//  NYPLBookmark.swift
//  NYPLUtilities
//
//  Created by Ernest Fan on 2022-08-12.
//

import Foundation

public protocol NYPLBookmark {
  var annotationId: String? { get set }
  var device: String? { get }
  var creationTime: Date { get }
  
  func serializableRepresentation(forMotivation motivation: NYPLBookmarkSpec.Motivation,
                                  bookID: String) -> [String: Any]
}
