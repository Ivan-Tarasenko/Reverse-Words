//
//  Reverse_WordsUITests.swift
//  Reverse WordsUITests
//
//  Created by Иван Тарасенко on 22.08.2021.
//

import XCTest

class ReverseWordsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {

    }

    func testCheckingTheButtonOperationReturn() throws {

        let app = XCUIApplication()
        app.launch()
        app.textFields["InputWords"].tap()
        app.textFields["InputWords"].typeText("Test string")
        app.buttons["Return"].tap()

        XCTAssert(app.staticTexts["tseT gnirts"].exists)
    }

    func testCheckingTheButtonOperationReverse() throws {

        let app = XCUIApplication()
        app.launch()
        app.textFields["InputWords"].tap()
        app.textFields["InputWords"].typeText("Test string")
        app.otherElements["BigView"].tap()
        app.buttons["ReverseButton"].tap()

        XCTAssert(app.staticTexts["tseT gnirts"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
