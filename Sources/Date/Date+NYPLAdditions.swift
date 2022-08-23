import Foundation

/// A date formatter to get date strings formatted per RFC 3339
/// without incurring in the high cost of creating a new DateFormatter
/// each time, which would be ~300% more expensive.
fileprivate let rfc3339DateFormatter: DateFormatter = {
  let df = DateFormatter()
  df.locale = Locale(identifier: "en_US_POSIX")
  df.timeZone = TimeZone(secondsFromGMT: 0)
  return df
}()

public extension Date {
  var rfc3339String: String {
    rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
    return rfc3339DateFormatter.string(from: self)
  }
}

@objc public extension NSDate {
  @objc convenience init?(rfc3339String: String?) {
    guard let rfc3339String = rfc3339String,
          !rfc3339String.isEmpty else {
      return nil
    }
    
    rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssX5"
    if let date = rfc3339DateFormatter.date(from: rfc3339String) {
      self.init(timeIntervalSince1970: date.timeIntervalSince1970)
      return
    }
    
    // Attempt to parse RFC3339 string with fractional seconds
    rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSSSSX5"
    if let date = rfc3339DateFormatter.date(from: rfc3339String) {
      self.init(timeIntervalSince1970: date.timeIntervalSince1970)
      return
    }

    return nil
  }
  
  @objc var rfc3339String: String {
    return (self as Date).rfc3339String
  }
}
