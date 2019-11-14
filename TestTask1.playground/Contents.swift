import UIKit

class TestTask1 {

    func getPercentageFromStringArray(array: [String]) -> [String] {
//        let initialArray = ["1.5", "3", "6", "1.5"]

        let transformedArray = array.map { (element) -> Float in
            return Float(element)!
        }
        let sum = transformedArray.reduce(0, +)

        let resultArray = transformedArray.map { (element) -> String in
            return String(format: "%.3f", element / sum * 100)
        }
        
        return resultArray
    }
}

import XCTest
class SimpleTestTaskTests: XCTestCase {
    func testBurningActuallyChars() {
        let testTask = TestTask1()
        
        let result1 = testTask.getPercentageFromStringArray(array: ["3.0", "1.25", "2.75", "4", "12"])
        let result2 = testTask.getPercentageFromStringArray(array: ["1", "2", "3", "4", "5"])
        let result3 = testTask.getPercentageFromStringArray(array: ["6", "7", "8", "9", "5"])
        
        XCTAssertTrue(result1 == ["13.043", "5.435", "11.957", "17.391", "52.174"])
        XCTAssertTrue(result2 == ["6.667", "13.333", "20.000", "26.667", "33.333"])
        XCTAssertTrue(result3 == ["17.143", "20.000", "22.857", "25.714", "14.286"])
    }
}

SimpleTestTaskTests.defaultTestSuite.run()



