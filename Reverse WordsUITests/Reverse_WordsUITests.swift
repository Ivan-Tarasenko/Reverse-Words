//
//  Reverse_WordsUITests.swift
//  Reverse WordsUITests
//
//  Created by Иван Тарасенко on 22.08.2021.
//

import XCTest

class ReverseWordsUITests: XCTestCase {
    var app: XCUIApplication!
    let stringTest = "Foxminded cool 24/7"
    let ignoredChar = "Foxminded"

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCheckingTheButtonOperationReturn() throws {

        inputStringInTextField(string: stringTest)
        app.buttons["Return"].tap()

        XCTAssert(app.staticTexts["dednimxoF looc 7/42"].exists)
    }

    func testCheckingTheButtonOperationReverse() throws {

        inputStringInTextField(string: stringTest)
        app.otherElements["BigView"].tap()
        app.buttons["ReverseButton"].tap()

        XCTAssert(app.staticTexts["dednimxoF looc 7/42"].exists)
    }

    func testCheckigTheButtonResultDefaultValue() throws {

        inputStringInTextField(string: stringTest)
        pressedResultButton()

        XCTAssert(app.staticTexts["dednimxoF looc 24/7"].exists)

    }

    func testCheckigTheButtonResultForInputCustomCharacter() throws {

        app.segmentedControls.buttons["Custom"].tap()
        inputStringInTextField(string: stringTest)
        pressedResultButton()
        pressedIgnorTextField(string: ignoredChar)
        pressedResultButton()

        XCTAssert(app.staticTexts["Foxminded looc 7/42"].exists)
    }

    func testRealTimeInputText() {

        app.segmentedControls.buttons["Hardcore"].tap()
        inputStringInTextField(string: stringTest)

        XCTAssert(app.staticTexts["dednimxoF looc 24/7"].exists)

    }

    func testRealTimeInputTextAndInputIgnorCharacter() {

        app.segmentedControls.buttons["Hardcore"].tap()
        inputStringInTextField(string: stringTest)
        app.otherElements["BigView"].tap()
        pressedIgnorTextField(string: ignoredChar)
        app.otherElements["BigView"].tap()

        XCTAssert(app.staticTexts["Foxminded looc 7/42"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    private func inputStringInTextField(string: String) {
        app.textFields["InputWords"].tap()
        app.textFields["InputWords"].typeText(string)
    }

    private func pressedIgnorTextField(string: String) {
        app.textFields["FieldIgnorChar"].tap()
        app.textFields["FieldIgnorChar"].typeText("Foxminded")
    }

    private func pressedResultButton() {
        app.otherElements["BigView"].tap()
        app.buttons["ResultButton"].tap()
    }
}
