//
//  TestDates.swift
//  GEDCOMConverter_Tests
//
//  Created by Craig Grummitt on 2/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import GEDCOMConverter

class TestDates: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testDates() {
        //,"1673-05-18","22 Oct 1587","2 Jul 1628"
        
        //assertDatesEqual(date1: Date(year: 1725, month: 6, day: 11) , date2String: "11 Jun 1725")
      
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func assertDatesEqual(date1:Date?,date2String:String) {
        XCTAssertNotNil(date1, "Ooops - couldn't create Date object")
        let date2Array = date2String.detectDates
        XCTAssertNotNil(date2Array, "Ooops - detection failed")
        XCTAssertGreaterThan(0, date2Array!.count, "Oops - couldn't detect any dates")
        let date2 = date2Array![0]
        XCTAssertEqual(date1!.timeIntervalSince1970, date2.timeIntervalSince1970, accuracy: 0.01, "Oops - the dates aren't equal! \(String(describing: date1)) ≠ \(String(describing: date2))")
    }
    
}

