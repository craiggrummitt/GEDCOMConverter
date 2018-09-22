//
//  Object.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 21/11/17.
//

import Foundation
public class Object:Keyable,Codable, CustomStringConvertible {
  //public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Object.file, gedcomKey: "FILE"),
    KeyObject(keyPath: \Object.form, gedcomKey: "FORM"),
    KeyObject(keyPath: \Object.title, gedcomKey: "TITL")
  ]
  public var file:String?
  public var form:String?
  public var title:String?
  public init(_ data:[String:Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Object: Title: \(title ?? q) file: \(file ?? q), Form: \(form ?? q)")
  }
}
