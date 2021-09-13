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
        app.staticTexts["LabelReverseWords"].tap()
        app.buttons["ReverseButton"].tap()
        XCTAssert(app.staticTexts["dednimxoF looc 7/42"].exists)
    }

    func testClear() throws {

        let stringEmpty = ""
        inputStringInTextField(string: stringTest)
        app.staticTexts["LabelReverseWords"].tap()
        app.buttons["ReverseButton"].tap()
        app.buttons["ReverseButton"].tap()
        XCTAssertEqual(app.textFields["InputWords"].title, stringEmpty)
        XCTAssertEqual(app.staticTexts["ResultLabel"].title, stringEmpty)
    }

    func testCheckingTheButtonResultDefaultValue() throws {

        switchingCustomReverse()
        inputStringInTextField(string: stringTest)
        pressedResultButton()
        XCTAssert(app.staticTexts["dednimxoF looc 24/7"].exists)

    }

    func testCheckingTheButtonResultForInputCustomCharacter() throws {
        switchingCustomReverse()
        app.segmentedControls.buttons["Custom"].tap()
        inputStringInTextField(string: stringTest)
        app.otherElements["BigViewTwo"].tap()
        app.otherElements["BigViewTwo"].swipeUp()
        app.buttons["ResultButton"].tap()
        pressedIgnorTextField(string: ignoredChar)
        pressedResultButton()

        XCTAssert(app.staticTexts["Foxminded looc 7/42"].exists)
    }

    func testRealTimeInputText() {
        switchingCustomReverse()
        app.segmentedControls.buttons["Hardcore"].tap()
        inputStringInTextField(string: stringTest)

        XCTAssert(app.staticTexts["dednimxoF looc 24/7"].exists)

    }

    func testRealTimeInputTextAndInputIgnorCharacter() {
        switchingCustomReverse()
        app.segmentedControls.buttons["Hardcore"].tap()
        inputStringInTextField(string: stringTest)
        app.otherElements["BigViewTwo"].tap()
        pressedIgnorTextField(string: ignoredChar)

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
        app.textFields["FieldIgnorChar"].typeText(string)
    }

    private func pressedResultButton() {
        app.staticTexts["LabelReverseWordsViewTwo"].tap()
        app.otherElements["BigViewTwo"].swipeUp()
        app.buttons["ResultButton"].tap()
    }

    private func switchingCustomReverse() {
        app.otherElements["BigView"].swipeUp()
        app.buttons["CustomReverse"].tap()
    }
}
