//
//  Birthday.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 20/11/17.
//

import Foundation
public class Event: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Event.date, gedcomKey: "DATE"),
    KeyObject(keyPath: \Event.place, gedcomKey: "PLAC"),
    KeyObject(keyPath: \Event.type, gedcomKey: "TYPE"),
    KeyObject(keyPath: \Event.sour, gedcomKey: "SOUR"),
    KeyObject(keyPath: \Event.sour, gedcomKey: "OBJE"),
    KeyObject(keyPath: \Event.root, gedcomKey: "ROOT")
    ]
  public var date: DateObject?
  public var place: PlaceObject?
  public var type: String?
  public var sour: Sour?
  public var object: Object?
  public var root: String?
  public init() {}
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    let q = "?"
    return ("Event: (Date: \( date?.description ?? q ), place:\(place?.description ?? q))")
    // return ("(Date: \( date != nil ? date!.description : q ), place:\(place != nil ? place!.description : q))")
  }
}
extension Event: Equatable {}
public func ==(lhs: Event, rhs: Event) -> Bool {
  let areEqual = lhs.type == rhs.type &&
    lhs.place == rhs.place &&
    lhs.date == rhs.date

  return areEqual
}
