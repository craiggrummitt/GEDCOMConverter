//
//  PlaceObject.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 21/11/17.
//

import Foundation
public struct PlaceObject:CustomStringConvertible {
  public var place:String
  public init(_ data:String) {
    self.place = data
  }
  public var description: String {
    return ("PlaceObject:   place: \(place)")
  }
}
