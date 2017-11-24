# GEDCOMConverter

[![CI Status](http://img.shields.io/travis/iosappdevelopmentwithswift@gmail.com/GEDCOMConverter.svg?style=flat)](https://travis-ci.org/iosappdevelopmentwithswift@gmail.com/GEDCOMConverter)
[![Version](https://img.shields.io/cocoapods/v/GEDCOMConverter.svg?style=flat)](http://cocoapods.org/pods/GEDCOMConverter)
[![License](https://img.shields.io/cocoapods/l/GEDCOMConverter.svg?style=flat)](http://cocoapods.org/pods/GEDCOMConverter)
[![Platform](https://img.shields.io/cocoapods/p/GEDCOMConverter.svg?style=flat)](http://cocoapods.org/pods/GEDCOMConverter)

With GEDCOMConverter, parsing a GEDCOM file to native Swift objects is too easy!

Just create a `GEDCOM` object, passing in the name of your GEDCOM file:
```
let gedcom = try GEDCOM(fileName:"sample")
```

The `GEDCOM` object will automatically generate a `head`, and `individuals`, `families` and `sour` arrays of data.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
The example project shows the individuals of a sample GEDCOM file in a table.

## Requirements
iOS 9.3.

## Installation

GEDCOMConverter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GEDCOMConverter'
```

## Author

Craig Grummitt craiggrummitt@gmail.com

## License

GEDCOMConverter is available under the MIT license. See the LICENSE file for more info.
