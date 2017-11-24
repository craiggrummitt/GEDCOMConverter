//
//  Object.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 21/11/17.
//

import Foundation
public struct Object:Keyable,CustomStringConvertible {
  public var unparsedData:[String:Any] = [:]
  public var keys = [
    KeyObject(keyPath: \Object.file, gedcomKey: "FILE"),
    KeyObject(keyPath: \Object.form, gedcomKey: "FORM"),
    KeyObject(keyPath: \Object.title, gedcomKey: "TITL")
  ]
  public var file:String?
  public var form:String?
  public var title:String?
  public init(_ data:[String:Any]) {
    self.initKeys(&self, with: data, from:keys)
  }
  public var description: String {
    return ("Object: Title: \(title ?? q) file: \(file ?? q), Form: \(form ?? q)")
  }
}
