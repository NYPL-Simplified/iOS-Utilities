//
//  NYPLRepeatingTimer.swift
//  NYPLUtilities
//
//  Created by Ernest Fan on 2022-03-09.
//

import Foundation

enum NYPLTimerState {
  case resumed
  case suspended
}

// This is a wrapper class of DispatchSourceTimer.
// It keeps track of the state of the timer to avoid crash from
// releasing, resuming or suspending the timer in the incorrect state.
public class NYPLRepeatingTimer {
  
  private(set) var state: NYPLTimerState
  
  private var timer: DispatchSourceTimer
  
  private var serialQueue: DispatchQueue
  
  public init(interval: DispatchTimeInterval,
       leeway: DispatchTimeInterval = .nanoseconds(0),
       queue: DispatchQueue = DispatchQueue.global(),
       handler: @escaping () -> Void) {
    timer = DispatchSource.repeatingTimer(interval: interval, leeway: leeway, queue: queue, handler: handler)
    state = .resumed
    serialQueue = DispatchQueue(label: "org.nypl.labs.iOSUtilities.repeatingTimer")
  }
  
  deinit {
    // Make sure timer is in the right state,
    // releasing a suspended timer will cause a crash
    // ref: https://developer.apple.com/forums/thread/15902?answerId=669654022#669654022
    if state == .suspended {
      timer.resume()
    }
  }
  
  public func resume() {
    // Make sure timer is in the right state,
    // calling resume or suspend twice in a row will cause a crash
    // ref: https://developer.apple.com/forums/thread/15902?answerId=669654022#669654022
    serialQueue.sync {
      guard state == .suspended else {
        return
      }
      state = .resumed
      timer.resume()
    }
  }
  
  public func suspend() {
    // Make sure timer is in the right state,
    // calling resume or suspend twice in a row will cause a crash
    // ref: https://developer.apple.com/forums/thread/15902?answerId=669654022#669654022
    serialQueue.sync {
      guard state == .resumed else {
        return
      }
      state = .suspended
      timer.suspend()
    }
  }
}
