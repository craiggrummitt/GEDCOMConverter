//
//  Family.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation

public class Family: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Family.husband, gedcomKey: "HUSB"),
    KeyObject(keyPath: \Family.wife, gedcomKey: "WIFE"),
    KeyObject(keyPath: \Family.children, gedcomKey: "CHIL"),
    KeyObject(keyPath: \Family.marriage, gedcomKey: "MARR"),
    KeyObject(keyPath: \Family.root, gedcomKey: "ROOT"),
    KeyObject(keyPath: \Family.divorced, gedcomKey: "DIV")
    ]
  public var id: String?
  public var husband: String?
  public var wife: String?
  public var children: [Child] = []
  public var marriage: Event?
  public var divorced: Event?
  public var root: String?
  public init(_ data: [String: Any], for id: String) {
    self.id = id
    self.initKeys(with: data)
  }
  public var description: String {
    let q = "?"
    return ("Family: ID: \(id ?? q), husband: \(husband ?? q), wife: \(wife ?? q), children: \(children.count)")
  }
}
