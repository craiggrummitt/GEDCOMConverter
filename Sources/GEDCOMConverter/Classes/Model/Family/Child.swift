//
//  Child.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation

public class Child: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Child.id, gedcomKey: "ROOT"),
    KeyObject(keyPath: \Child.fatherRelationship, gedcomKey: "_FREL"),
    KeyObject(keyPath: \Child.motherRelationship, gedcomKey: "_MREL")
  ]
  public var id: String?
  public var fatherRelationship: String?
  public var motherRelationship: String?
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Child:   Name: \(id ?? q)")
  }
}
