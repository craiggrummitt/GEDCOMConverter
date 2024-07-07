//
//  GEDCOM.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation
public class GEDCOM: Codable {
  public var head: Head?
  public var individuals: [Individual] = []
  public var families: [Family] = []
  public var sours: [Sour] = []

  public init(_ content: String) {
    print("GEDCOM INIT")
    // break apart content into lines of text
    let linesAsStrings = content.components(separatedBy: .newlines).filter({$0 != ""})
    // convert to lines of level(Int),type(String) and data(String)
    let lines = linesAsStrings.compactMap({Line($0)})
    var linesCopy = lines
    // convert to multi-dimensional arrays/dictionaries of String
    let data = GedcomParser.getAllData(atOrAbove: 0, from: &linesCopy)
    // print(data)
    // parse parts
    if let headData = data["HEAD"] as? [String: Any] {
      self.head = Head(headData)
    }
    let individualLines = data.filter({ $0.key.first! == "I" ||  $0.key.first! == "P" })
    individuals = []
    for line in individualLines {
      if let individualData = line.value as? [String: Any] {
        let individual = Individual(individualData, for: line.key)
        individuals.append(individual)
      }
    }
    // individuals.forEach{print($0)}
    let familyLines = data.filter({ $0.key.first! == "F"})
    families = []
    for line in familyLines {
      if let familyData = line.value as? [String: Any] {
        families.append(Family(familyData, for: line.key))
      }
    }
    let sourLines = data.filter({ $0.key.first! == "S"})
    sours = []
    for line in sourLines {
      if let sourData = line.value as? [String: Any] {
        sours.append(Sour(sourData, for: line.key))
      }
    }
  }

  public convenience init?(fileName: String) throws {
    print("GEDCOM convenience INIT")
    guard let path = Bundle.main.path(forResource: fileName, ofType: "ged") else {return nil}
    let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    self.init(content)
  }
}
