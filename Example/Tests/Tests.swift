import UIKit
import XCTest
import GEDCOMConverter

//Tests not working, will return to this.

class Tests: XCTestCase {
    var gedcom:GEDCOM?
    override func setUp() {
        super.setUp()
        if let gedcom = try? GEDCOM(fileName:"sample") {
          self.gedcom = gedcom
        } else {
          XCTFail("GEDCOM returns nil")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func testHead() {
    XCTAssertNotNil(gedcom?.head, "Head is nil")
  }
  
    
}
