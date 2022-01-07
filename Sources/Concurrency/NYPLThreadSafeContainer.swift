//
//  NYPLThreadSafeContainer.swift
//  Created by Raman Singh on 2021-06-01.
//  Copyright © 2021 NYPL Labs. All rights reserved.
//

import Foundation

public class NYPLThreadSafetyBase {
  fileprivate let queue: DispatchQueue
  
  public init(queue: DispatchQueue) {
    self.queue = queue
  }
  
}

public class NYPLThreadSafeDictionaryContainer<S: Hashable,T>: NYPLThreadSafetyBase {
  
  private var dictionary: [S:T]
  
  public init(dictionary:[S:T] = [:], queue: DispatchQueue) {
    self.dictionary = dictionary
    super.init(queue: queue)
  }
  
  public subscript(key: S) -> T? {
    get {
      return queue.sync { [weak self] in
        self?.dictionary[key]
      }
    }
    set(newValue) {
      queue.sync { [weak self] in
        self?.dictionary[key] = newValue
      }
    }
  }
  
  public func forEach(closure: (S, T) -> Void) {
    queue.sync {
      self.dictionary.forEach {
        closure($0, $1)
      }
    }
  }
  
  public func removeAll() {
    queue.sync { [weak self] in
      self?.dictionary.removeAll()
    }
  }
  
}

public class NYPLThreadSafeValueContainer<T>: NYPLThreadSafetyBase {
  private var _value: T
  
  public init(value: T, queue: DispatchQueue) {
    self._value = value
    super.init(queue: queue)
  }
  
  public var value: T? {
    get {
      return queue.sync { [weak self] in
        self?._value
      }
    }
    set(newValue) {
      queue.sync { [weak self] in
        guard let newValue = newValue else { return }
        self?._value = newValue
      }
    }
  }
  
}
