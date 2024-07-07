//
//  Head.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation
public class Head: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Head.sour, gedcomKey: "SOUR"),
    KeyObject(keyPath: \Head.date, gedcomKey: "DATE"),
    KeyObject(keyPath: \Head.gedc, gedcomKey: "GEDC"),
    KeyObject(keyPath: \Head.char, gedcomKey: "CHAR"),
    KeyObject(keyPath: \Head.submitter, gedcomKey: "SUBM")
  ]
  public var sour: Sour?
  public var date: DateObject?
  public var gedc: Gedc?
  public var char: String?
  public var submitter: String?
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Head: sour: \(sour?.description ?? q), Date: \(date?.description ?? q), Gedc: \(gedc?.description ?? q), Char: \(char ?? q), Submitter: \(submitter ?? q)")
  }
}
