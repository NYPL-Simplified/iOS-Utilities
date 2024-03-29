import Foundation
import CommonCrypto
import NYPLUtilitiesObjc

public class RSAUtils {
  public class func SHA256HashedData(from data: NSData) -> NSData {
    let outputLength = CC_SHA256_DIGEST_LENGTH
    var output = [UInt8](repeating: 0, count: Int(outputLength))
    CC_SHA256(data.bytes, CC_LONG(data.length), &output)
    return NSData(bytes: output, length: Int(outputLength))
  }
  
  public class func stripPEMKeyHeader(_ key: String) -> String {
    let fullRange = NSRange(location: 0, length: key.lengthOfBytes(using: .utf8))
    let regExp = try! NSRegularExpression(pattern: "(-----BEGIN.*?-----)|(-----END.*?-----)|\\s+", options: [])
    return regExp.stringByReplacingMatches(in: key, options: [], range: fullRange, withTemplate: "")
  }
}

extension String {
  public var sha256: String? {
    NYPLStringAdditions.sha256forString(self)
  }
}

extension NSString {
  @objc public var sha256: String? {
    NYPLStringAdditions.sha256forString(self as String)
  }
}
