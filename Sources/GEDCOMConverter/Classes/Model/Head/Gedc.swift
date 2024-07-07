//
//  Gedc.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation
public class Gedc: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Gedc.version, gedcomKey: "VERS"),
    KeyObject(keyPath: \Gedc.form, gedcomKey: "FORM")
  ]
  public var version: String?
  public var form: String?
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("GEDC:   Version: \(version ?? q), Form: \(form ?? q)")
  }
}
