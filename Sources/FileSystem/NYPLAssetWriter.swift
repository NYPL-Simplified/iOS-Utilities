//
//  NYPLAssetWriter.swift
//  Created by Raman Singh on 2021-04-06.
//  Copyright © 2021 NYPL. All rights reserved.
//

import Foundation

public protocol NYPLAssetWriting {
  func writeAsset(_ data: Data, atURL url: URL) throws
}

public struct NYPLAssetWriter: NYPLAssetWriting {

  public init() {
  }

  /// writes asset at provided url while creating intermediate directories if not present.
  /// - Parameters:
  ///   - data: Data to be written
  ///   - url: Desired location of asset to be written
  /// - Throws: Throws an error if failure to create directories or write data occurs.
  public func writeAsset(_ data: Data, atURL url: URL) throws {
    let folderURL = url.deletingLastPathComponent()
    let dirExists = FileManager.default.fileExists(atPath: folderURL.path)
    if (!dirExists) {
      try FileManager.default.createDirectory(at: folderURL,
                                              withIntermediateDirectories: true,
                                              attributes: nil)
    }
    
    try data.write(to: url)
  }
  
}
