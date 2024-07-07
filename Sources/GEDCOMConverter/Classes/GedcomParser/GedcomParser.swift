//
//  Parser.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 19/11/17.
//

import Foundation

public let q = "?"

// 0 @I1@ INDI
public struct Line {
  public var level: Int
  public var type = ""
  public var data = ""
  public init?(_ lineText: String) {
    // level
    guard let level = Int(lineText.prefix(1)) else {return nil}
    self.level = level
    // type
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
      if let spaceIndex = type.firstIndex(of: " ") {
        type = String(type[..<spaceIndex])
      }
      dataOffset = type.count + 3
    }
    // get data
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
  public static func getAllData(atOrAbove level: Int,
                                from lines: inout [Line],
                                with property: [String: Any]? = nil) -> [String: Any] {
    var data: [String: Any] = [:]
    if let property = property {
      data += property
    }
    while lines.count>0 && lines[0].level == level {
      let line = lines[0]
      lines.removeFirst()

      if lines.count>0 && lines[0].level == level + 1 {
        var dataToSet: [String: Any]
        // this is a multi-line property
        if line.data != "" {
          // the data of the root line contains something
          dataToSet = getAllData(atOrAbove: level+1, from: &lines, with: ["ROOT": line.data])
        } else {
          // the data of the root line contains nothing
          dataToSet = getAllData(atOrAbove: level+1, from: &lines)
        }
        setDictionary(data: &data, with: line.type, to: dataToSet)
      } else {
        // this is a single-line property, set to String
        setDictionary(data: &data, with: line.type, to: line.data)
      }

      /*
       //Turn data into array of data if it already exists
       if data[line.type] == nil {
       data[line.type] = dataToSet
       } else {
       var array = [data[line.type]]
       array.append(dataToSet)
       print(array)
       data[line.type] = array
       }*/
    }
    return data
  }
  public static func setDictionary<T>(data: inout [String: Any], with property: String, to dataToSet: T) {
    // Turn data into array of data if it already exists
    if data[property] == nil {
      data[property] = dataToSet
    } else if let oldData = data[property] as? T {
      var array: [T] = [oldData]
      array.append(dataToSet)
      data[property] = array
    } else if var array = data[property] as? [T] {
      array.append(dataToSet)
      data[property] = array
    }
  }
}
