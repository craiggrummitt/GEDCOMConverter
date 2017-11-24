//
//  Data.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation
public struct Data:Keyable,CustomStringConvertible {
  public var unparsedData:[String:Any] = [:]
  public var keys = [
    KeyObject(keyPath: \Data.text, gedcomKey: "TEXT")
  ]
  public var text:String?
  public init(_ data:[String:Any]) {
    self.initKeys(&self, with: data, from:keys)
  }
  public var description: String {
    return ("Data: \(text ?? q)")
  }
}
