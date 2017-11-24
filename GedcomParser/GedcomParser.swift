//
//  Parser.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation



public let q = "?"
public enum Type:String {
  //head
  case head
  case sour
  case name
  case vers
  case date
  case gedc
  case form
  case char
  case subm
  //indi
  case sex
  case fams
  case famc
  //fam
  case husb
  case wife
  case marr
  case chil
  //submitter
  case trlr
  //unknown
  case unknown
  
  public init(_ typeText:String) {
    if let type = Type(rawValue:typeText.lowercased()) {
      self = type
    } else {
      print("Unknown line: \(typeText)")
      self = .unknown
    }
  }
}
//0 @I1@ INDI
public struct Line {
  public var level:Int
  public var type = ""
  public var data = ""
  public init?(_ lineText:String) {
    //level
    guard let level = Int(lineText.prefix(1)) else {return nil}
    self.level = level
    //type
    var dataOffset=3
    let i = lineText.index(lineText.startIndex, offsetBy: 2)
    if lineText[i] == "@" {
      let parts = lineText.split(separator: "@")
      if parts.count>1 {
        type = String(parts[1])
        dataOffset = type.count + 5
      }
    } else {
      let indexStartOfType = lineText.index(lineText.startIndex, offsetBy: 2)
      type = String(lineText[indexStartOfType...])
      if let spaceIndex = type.index(of: " ") {
        type = String(type[..<spaceIndex])
      }
      dataOffset = type.count + 3
    }
    //get data
    if lineText.count > dataOffset {
      let indexStartOfData = lineText.index(lineText.startIndex, offsetBy: dataOffset)
      data = String(lineText[indexStartOfData...])
      if data.contains("@") {
        let dataSplit = data.split(separator: "@")
        if dataSplit.count>=1 {
          data = String(dataSplit[0])
        }
      }
    } else {
      data = ""
    }
  }
}

public struct GedcomParser {
  /*public static func getData(for level:Int, and type:Type, from line:Line?)->String? {
    guard let line = line else {return nil}
    if line.level == level && line.type == type {
      return line.data
    }
    return nil
  }
  public static func isLevel(_ level:Int, and type:Type, from line:Line?)->Bool {
    guard let line = line else {return false}
    return line.level == level && line.type == type
  }*/
  public static func getAllData(atOrAbove level:Int,
                                from lines:inout [Line],
                                with property:[String:Any]? = nil)->[String:Any] {
    var data:[String:Any] = [:]
    if let property = property {
      data += property
    }
    while lines.count>0 && lines[0].level == level {
      let line = lines[0]
      lines.removeFirst()
      
      if lines.count>0 && lines[0].level == level + 1 {
        if line.data != "" {
          data[line.type] = getAllData(atOrAbove: level+1, from: &lines, with: ["ROOT":line.data])
        } else {
          data[line.type] = getAllData(atOrAbove: level+1, from: &lines)
        }
      } else {
        data[line.type] = line.data
      }
    }
    return data
  }
}

