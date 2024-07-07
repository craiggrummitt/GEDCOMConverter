//
//  Data.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation
public class Data: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Data.text, gedcomKey: "TEXT")
  ]
  public var text: String?
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Data: \(text ?? q)")
  }
}
