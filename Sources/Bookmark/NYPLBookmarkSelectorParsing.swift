//
//  NYPLBookmarkSelectorParsing.swift
//  NYPLUtilities
//
//  Created by Ernest Fan on 2022-09-22.
//

import Foundation

public protocol NYPLBookmarkSelectorParsing {
  static func parseSelectorJSONString(fromServerAnnotation annotation: [String: Any],
                                     annotationType: NYPLBookmarkSpec.Motivation,
                                     bookID: String) -> String?
}
