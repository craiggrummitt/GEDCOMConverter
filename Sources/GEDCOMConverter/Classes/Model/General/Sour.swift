//
//  Sour.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation
public class Sour: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Sour.name, gedcomKey: "NAME"),
    KeyObject(keyPath: \Sour.version, gedcomKey: "VERS"),
    KeyObject(keyPath: \Sour.corp, gedcomKey: "CORP"),
    KeyObject(keyPath: \Sour.api, gedcomKey: "_API"),
    KeyObject(keyPath: \Sour.data, gedcomKey: "DATA"),
    KeyObject(keyPath: \Sour.page, gedcomKey: "PAGE"),
    KeyObject(keyPath: \Sour.note, gedcomKey: "NOTE"),
    KeyObject(keyPath: \Sour.apid, gedcomKey: "_APID"),
    KeyObject(keyPath: \Sour.object, gedcomKey: "OBJE"),
    KeyObject(keyPath: \Sour.title, gedcomKey: "TITL"),
    KeyObject(keyPath: \Sour.file, gedcomKey: "FILE"),
    KeyObject(keyPath: \Sour.form, gedcomKey: "FORM"),
    KeyObject(keyPath: \Sour.root, gedcomKey: "ROOT"),
    KeyObject(keyPath: \Sour.auth, gedcomKey: "AUTH"),
    KeyObject(keyPath: \Sour.publ, gedcomKey: "PUBL"),
    KeyObject(keyPath: \Sour.repo, gedcomKey: "REPO")
    ]
  public var root: String?
  public var name: String?
  public var version: String?
  public var corp: String?
  public var api: String?
  public var data: Data?
  public var page: String?
  public var note: String?
  public var apid: String?
  public var object: Object?
  public var title: String?
  public var file: String?
  public var form: String?
  public var auth: String?
  public var publ: String?
  public var repo: String?
  // for non - 0 based SOUR eg.
  // 1 SOUR @S-2126195860@
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  // for 0 based SOUR eg.
  // 0 @S205747489@ SOUR
  public init(_ data: [String: Any], for id: String) {
    self.root = id
    var data = data
    data.removeValue(forKey: "ROOT")
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Sour:   Name: \(name ?? q), version: \(version ?? q)")
  }
}
