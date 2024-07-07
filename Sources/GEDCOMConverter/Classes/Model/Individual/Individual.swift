//
//  Individual.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 20/11/17.
//

import Foundation

public class Individual: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Individual.name, gedcomKey: "NAME"),
    KeyObject(keyPath: \Individual.sex, gedcomKey: "SEX"),
    KeyObject(keyPath: \Individual.birthday, gedcomKey: "BIRT"),
    KeyObject(keyPath: \Individual.death, gedcomKey: "DEAT"),
    KeyObject(keyPath: \Individual.fams, gedcomKey: "FAMS"),
    KeyObject(keyPath: \Individual.famc, gedcomKey: "FAMC"),
    KeyObject(keyPath: \Individual.rin, gedcomKey: "RIN"),
    KeyObject(keyPath: \Individual.occu, gedcomKey: "OCCU"),
    KeyObject(keyPath: \Individual.note, gedcomKey: "NOTE"),
    KeyObject(keyPath: \Individual.object, gedcomKey: "OBJE"),
    KeyObject(keyPath: \Individual.residence, gedcomKey: "RESI"),
    KeyObject(keyPath: \Individual.event, gedcomKey: "EVEN"),
    KeyObject(keyPath: \Individual.married, gedcomKey: "MARR"),
    KeyObject(keyPath: \Individual.sour, gedcomKey: "SOUR"),
    KeyObject(keyPath: \Individual.burial, gedcomKey: "BURI"),
    KeyObject(keyPath: \Individual.christening, gedcomKey: "CHR"),
    KeyObject(keyPath: \Individual.cremated, gedcomKey: "CREM"),
    KeyObject(keyPath: \Individual.baptism, gedcomKey: "BAPM"),
    KeyObject(keyPath: \Individual.destination, gedcomKey: "_DEST"),
    KeyObject(keyPath: \Individual.mdcl, gedcomKey: "_MDCL"),
    KeyObject(keyPath: \Individual.immigration, gedcomKey: "IMMI"),
    KeyObject(keyPath: \Individual.root, gedcomKey: "ROOT"),
    KeyObject(keyPath: \Individual.emigration, gedcomKey: "EMIG")
  ]
  public var id: String?
  public var name: String?
  public var sex: String?
  public var birthday: Event?
  public var death: Event?
  public var fams: String?    // spouse family
  public var famc: String?    // child of family
  public var rin: String?
  public var occu: String?
  public var note: String?
  public var object: [Object] = []
  public var residence: [Event] = []
  public var event: [Event] = []
  public var married: Event?
  public var sour: Sour?
  public var burial: Event?
  public var christening: Event?
  public var cremated: Event?
  public var baptism: Event?
  public var destination: Event?
  public var mdcl: String?
  public var immigration: Event?
  public var emigration: Event?
  public var root: String?
  public init(_ data: [String: Any], for id: String) {
    self.id = id
    if id == "P1574" {
      print("STOP HERE")
    }
    self.initKeys(with: data)
  }
  public var description: String {
    let q = "?"
    return ("Indi: ID: \(id ?? q), name: \(name ?? q), sex: \(sex ?? q), birthday: \(birthday?.description ?? q)")
  }
}
