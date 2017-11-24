//
//  Gedc.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation
public struct Gedc:Keyable, CustomStringConvertible {
  public var unparsedData:[String:Any] = [:]
  public var keys = [
    KeyObject(keyPath: \Gedc.version, gedcomKey: "VERS"),
    KeyObject(keyPath: \Gedc.form, gedcomKey: "FORM")
  ]
  public var version:String?
  public var form:String?
  public init(_ data:[String:Any]) {
    self.initKeys(&self, with: data, from:keys)
  }
  public var description: String {
    return ("GEDC:   Version: \(version ?? q), Form: \(form ?? q)")
  }
}

