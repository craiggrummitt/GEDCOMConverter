//
//  DateObject.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 20/11/17.
//

import Foundation
public struct DateObject: Codable, CustomStringConvertible {
  public var datesDetected: [Date]?
  public var dateOriginalText: String
  public init(_ data: String) {
    self.dateOriginalText = data
    self.datesDetected = data.detectDates
  }
  public init(_ date: Date) {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    self.dateOriginalText =  formatter.string(from: date)
    self.datesDetected = [date]
  }
  public var description: String {
    return "\(dateOriginalText)"
  }
}
extension DateObject: Equatable {}
public func ==(lhs: DateObject, rhs: DateObject) -> Bool {
  let areEqual = lhs.dateOriginalText == rhs.dateOriginalText
  return areEqual
}
// https://stackoverflow.com/a/32595941/3220708
public extension String {
  var nsString: NSString { return self as NSString }
  var length: Int { return nsString.length }
  var nsRange: NSRange { return NSRange(location: 0, length: length) }
  var detectDates: [Date]? {
    var date = self
    // If only the year is known, to make a complete date let's assume 30 Jun
    if date.isYear() {
      // FIX one day: perhaps this and the following assumption should change the status of the date somehow
      date = "30 Jun " + self
    }
    // Work around limitation of NSDataDetector that it only deals with years >= 1700
    let characterSets = CharacterSet(charactersIn: " /\\-.:")
    var parts = date.components(separatedBy: characterSets)
    var joinAgain = false
    // If only the month and year is known, make a complete date and let's assume 15 of the month
    if parts.count == 2, parts[0].isMonth(), parts[1].isYear() {
      parts.insert("15", at: 0)
      joinAgain = true
    }
    var yearInWaiting: Int?
    var monthInLetters = false
    for (i, part) in parts.enumerated() {
      if part.isYear() {
        if let year = Int(part) {   // should always be true
          yearInWaiting = year
          if year<1700 {
            parts[i] = "2000"
            joinAgain = true
          }
        }
      } else if part.isMonth() {
        monthInLetters = true
      }
    }
    if joinAgain {
      date = parts.joined(separator: monthInLetters ? " " : "/")
    }
    // Do the date detection
    var returnDates: [Date]? = []
    returnDates = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
      .matches(in: date, range: date.nsRange)
      .compactMap {$0.date}
    if let returnDatesUnwrapped = returnDates, returnDatesUnwrapped.count == 0, let yearInWaiting = yearInWaiting {
      date = "30 Jun \(yearInWaiting)"
      returnDates = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        .matches(in: date, range: date.nsRange)
        .compactMap {$0.date}
    }

    // Reinstate year that we discovered earlier
    if var returnDates = returnDates {
      for (i, returnDate) in returnDates.enumerated() {
        if let year = yearInWaiting {
          var components = Calendar.current.dateComponents([.year, .month, .day], from: returnDate)
          components.year = year
          if let date = Calendar.current.date(from: components) {
            returnDates[i] = date
          }
        }
      }
      return returnDates
    } else {
      return nil
    }
  }
  // returns true if month
  func isMonth() -> Bool {
    return (self.count >= 3 && self.rangeOfCharacter(from: .letters) != nil)
  }
  // returns true if year
  func isYear() -> Bool {
    if self.count==4 && !self.contains(" "), let dateAsInt = Int(self), String(dateAsInt) == self {
      return true
    }
    return false
  }
}

public extension Collection where Iterator.Element == String {
  var dates: [Date] {
    return compactMap {$0.detectDates}.flatMap {$0}
  }
}
