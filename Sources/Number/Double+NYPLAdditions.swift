//
//  Created by Ettore Pasquini on 6/17/20.
//  Copyright © 2024 The New York Public Library. All Rights Reserved.
//

import Foundation

infix operator =~= : ComparisonPrecedence

public extension Double {

  /// Performs equality check minus an epsilon
  /// - Returns: `true` if the numbers differ by less than the epsilon,
  /// `false` otherwise.
  static func =~= (a: Double, b: Double?) -> Bool {
    guard let b = b else {
      return false
    }

    return abs(a - b) < Double.ulpOfOne
  }

  func roundTo(decimalPlaces: Int) -> String {
    return String(format: "%.\(decimalPlaces)f%%", self) as String
  }
}

