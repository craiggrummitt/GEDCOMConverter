//
//  DateObject.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 20/11/17.
//

import Foundation
public struct DateObject:CustomStringConvertible {
  public var datesDetected:[Date]?
  public var dateOriginalText:String
  public init(_ data:String) {
    self.dateOriginalText = data
    self.datesDetected = data.detectDates
  }
  public var description: String {
    return "\(dateOriginalText)"
  }
}
//https://stackoverflow.com/a/32595941/3220708
public extension String {
  var nsString: NSString { return self as NSString }
  var length: Int { return nsString.length }
  var nsRange: NSRange { return NSRange(location: 0, length: length) }
  public var detectDates: [Date]? {
    return try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
      .matches(in: self, range: nsRange)
      .flatMap{$0.date}
  }
}

public extension Collection where Iterator.Element == String {
  public var dates: [Date] {
    return flatMap{$0.detectDates}.flatMap{$0}
  }
}
