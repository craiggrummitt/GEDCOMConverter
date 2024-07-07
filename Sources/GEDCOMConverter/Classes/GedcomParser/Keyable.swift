//
//  Keyable.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation
public struct KeyObject {
  public var keyPath: AnyKeyPath
  public var gedcomKey: String
}
public protocol Keyable {
  static var keys: [KeyObject] {get}
  // var unparsedData:[String:Any] {get set}
}
public extension Keyable {
  func initKeys(with data: [String: Any]) {
    var instance = self
    var data: [String: Any] = data
    for key in Self.keys {
      if let keyPath = key.keyPath as?  WritableKeyPath<Self, String?> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let value = value as? String {
          instance[keyPath: keyPath] =  value
        } else if let value = value as? [String: Any], let rootValue = value["ROOT"] as? String {
          instance[keyPath: keyPath] =  rootValue
        } else if let value = value as? [String] {
          instance[keyPath: keyPath] = value[0]
        } else if let value = value as? [[String: Any]], let rootValue = value.first?["ROOT"] as? String {
          instance[keyPath: keyPath] = rootValue
        } else {
          instance[keyPath: keyPath] = nil
        }
      }
        // HEAD
      else if let keyPath = key.keyPath as? WritableKeyPath<Self, Gedc?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String: Any] {
          instance[keyPath: keyPath] = Gedc(internalData)
        }
      } else if let keyPath = key.keyPath as?  WritableKeyPath<Self, Sour?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String: Any] {
          instance[keyPath: keyPath] = Sour(internalData)
        }
      }
        // INDIVIDUAL
      else if let keyPath = key.keyPath as? WritableKeyPath<Self, Event?> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let value = value as? [String: Any] {
          instance[keyPath: keyPath] = Event(value)
        } else if let value = value as? [[String: Any]], let internalData = value.first {
          instance[keyPath: keyPath] = Event(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<Self, [Event]> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let internalData = value as? [String: Any] {
          instance[keyPath: keyPath].append(Event(internalData))
        } else if let internalData = value as? [[String: Any]] {
          internalData.forEach {
            instance[keyPath: keyPath].append(Event($0))
          }
        }
      } else if let keyPath = key.keyPath as?  WritableKeyPath<Self, PlaceObject?> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let internalData = value as? String {
          instance[keyPath: keyPath] = PlaceObject(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<Self, [Object]> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let internalData = value as? [String: Any] {
          instance[keyPath: keyPath].append(Object(internalData))
        } else if let internalData = value as? [[String: Any]] {
          internalData.forEach {
            instance[keyPath: keyPath].append(Object($0))
          }
        }
      }
        // FAMILY
      else if let keyPath = key.keyPath as?  WritableKeyPath<Self, [Child]> {
        let value = data.removeValue(forKey: key.gedcomKey)
        if let internalData = value as? [String: Any] {
          instance[keyPath: keyPath].append(Child(internalData))
        } else if let internalData = value as? [[String: Any]] {
          internalData.forEach {
            instance[keyPath: keyPath].append(Child($0))
          }
        }
      }
        // GENERAL
      else if let keyPath = key.keyPath as?  WritableKeyPath<Self, DateObject?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? String {
          instance[keyPath: keyPath] = DateObject(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<Self, Data?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String: Any] {
          instance[keyPath: keyPath] = Data(internalData)
        }
      }
    }
    if data.count>0 {
      // if var instance = instance as? Keyable {
      //  instance.unparsedData = data
      // }
      print("Unparsed data: \(data) in \(String(describing: type(of: self)))")
    }
  }
}
