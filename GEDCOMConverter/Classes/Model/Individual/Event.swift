//
//  Birthday.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 20/11/17.
//

import Foundation
public struct Event:Keyable, CustomStringConvertible {
  public var unparsedData:[String:Any] = [:]
  public var keys = [
    KeyObject(keyPath: \Event.date, gedcomKey: "DATE"),
    KeyObject(keyPath: \Event.place, gedcomKey: "PLAC"),
    KeyObject(keyPath: \Event.type, gedcomKey: "TYPE"),
    KeyObject(keyPath: \Event.sour, gedcomKey: "SOUR"),
    KeyObject(keyPath: \Event.sour, gedcomKey: "OBJE"),
    KeyObject(keyPath: \Event.root, gedcomKey: "ROOT"),
  ]
  public var date:DateObject?
  public var place:PlaceObject?
  public var type:String?
  public var sour:Sour?
  public var object:Object?
  public var root:String?
  public init(_ data:[String:Any]) {
    self.initKeys(&self, with: data, from:keys)
  }
  public var description: String {
    let q = "?"
    return ("Event: (Date: \( date?.description ?? q ), place:\(place?.description ?? q))")
    //return ("(Date: \( date != nil ? date!.description : q ), place:\(place != nil ? place!.description : q))")
  }
}
