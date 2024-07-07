//
//  Object.swift
//  GEDCOMConverter
//
//  Created by Craig Grummitt on 21/11/17.
//

import Foundation
public class Object: Keyable, Codable, CustomStringConvertible {
  // public var unparsedData:[String:Any] = [:]
  public static let keys = [
    KeyObject(keyPath: \Object.file, gedcomKey: "FILE"),
    KeyObject(keyPath: \Object.form, gedcomKey: "FORM"),
    KeyObject(keyPath: \Object.title, gedcomKey: "TITL")
  ]
  public var file: String?
  public var form: String?
  public var title: String?
  public init(_ data: [String: Any]) {
    self.initKeys(with: data)
  }
  public var description: String {
    return ("Object: Title: \(title ?? q) file: \(file ?? q), Form: \(form ?? q)")
  }
  /**Converts Ancestry URL to the URL of a JPG
     //File comes from Ancestry like:
     //http://trees.ancestry.com/rd?f=image&guid=1e1d842f-8619-4569-b320-f745ace26f19&tid=5973192&pid=1
     //Need to convert to following format:
     //https://mediasvc.ancestry.com/v2/image/namespaces/1093/media/1e1d842f-8619-4569-b320-f745ace26f19.jpg?client=Trees&imageQuality=hq
     //See: https://support.ancestry.com/s/question/0D515000021Ob3rCAC/getting-images-via-ancestrycom-gedcom-files
  **/
  public var url: URL? {
    guard let file = file,
      let fileUrlComponents = URLComponents(string: file),
      let fileQueryItems = fileUrlComponents.queryItems,
      let guid = fileQueryItems.first(where: { $0.name == "guid" })?.value,
      let form = form,
      let newURL = URL(string: "https://mediasvc.ancestry.com/v2/image/namespaces/1093/media/\(guid).\(form)?client=Trees&imageQuality=hq")
      else { return nil }
    return newURL
  }
}
