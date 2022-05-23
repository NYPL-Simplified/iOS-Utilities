//
//  iOS-Utilities
//  Created by Ettore Pasquini on 5/18/22.
//  Copyright © 2022 NYPL. All rights reserved.
//


import Foundation

extension Dictionary where Key == String, Value: Any {

  /// Flattens a nested dictionary to a single level dictionary made of
  /// key-value pairs, where the values are only Strings or NSNumbers.
  ///
  /// - Returns: A dictionary made of key-value pairs where the values are
  /// of type Strings or NSNumber.
  public func flattenToStringsAndNumbers() -> [String: Any] {
    var outDict = [String: Any]()
    for key in self.keys {
      guard let value = self[key] else {
        continue
      }

      if let string = value as? String {
        outDict[key] = string
      } else if let num = value as? NSNumber {
        outDict[key] = num
      } else if let nestedDict = value as? [String: Any] {
        let flattenedDict = nestedDict.flattenToStringsAndNumbers()
        for nestedKey in flattenedDict.keys {
          let newKey = "\(key)_\(nestedKey)"
          outDict[newKey] = flattenedDict[nestedKey]
        }
      } else if let stringConvertible = value as? CustomStringConvertible {
        outDict[key] = stringConvertible.description
      }
    }

    return outDict
  }
}
