//
//  Keyable.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation
public struct KeyObject {
  public var keyPath:AnyKeyPath
  public var gedcomKey:String
}
public protocol Keyable {
  public var keys:[KeyObject] {get set}
  public var unparsedData:[String:Any] {get set}
}
public extension Keyable {
  public func initKeys<T>(_ instance:inout T, with data:[String:Any], from keys:[KeyObject]) {
    var data:[String:Any] = data
    for key in keys {
      if let keyPath = key.keyPath as?  WritableKeyPath<T, String?> {
        instance[keyPath: keyPath] = data.removeValue(forKey: key.gedcomKey) as? String ?? nil
      }
        //HEAD
      else if let keyPath = key.keyPath as? WritableKeyPath<T, Gedc?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath] = Gedc(internalData)
        }
      } else if let keyPath = key.keyPath as?  WritableKeyPath<T, Sour?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath] = Sour(internalData)
        }
      }
        //INDIVIDUAL
      else if let keyPath = key.keyPath as? WritableKeyPath<T, Event?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath] = Event(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<T, [Event]> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath].append(Event(internalData))
        }
      } else if let keyPath = key.keyPath as?  WritableKeyPath<T, PlaceObject?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? String {
          instance[keyPath:keyPath] = PlaceObject(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<T, Object?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath] = Object(internalData)
        }
      }
        //FAMILY
      else if let keyPath = key.keyPath as?  WritableKeyPath<T, [Child]> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath].append(Child(internalData))
        }
      }
        //GENERAL
      else if let keyPath = key.keyPath as?  WritableKeyPath<T, DateObject?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? String {
          instance[keyPath:keyPath] = DateObject(internalData)
        }
      } else if let keyPath = key.keyPath as? WritableKeyPath<T, Data?> {
        if let internalData = data.removeValue(forKey: key.gedcomKey) as? [String:Any] {
          instance[keyPath:keyPath] = Data(internalData)
        }
      }
    }
    if data.count>0 {
      if var instance = instance as? Keyable {
        instance.unparsedData = data
      }
      print("Unparsed data: \(data) in \(String(describing: type(of: instance)))")
    }
  }
}
