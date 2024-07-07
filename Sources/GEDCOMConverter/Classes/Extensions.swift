//
//  Extensions.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 23/11/17.
//

import Foundation

public func += <K, V> (left: inout [K: V], right: [K: V]) {
  for (k, v) in right {
    left[k] = v
  }
}
