//
//  Reverse_WordsButtonReverseUITests.swift
//  Reverse WordsButtonReverseUITests
//
//  Created by Иван Тарасенко on 20.08.2021.
//

import XCTest

class ReverseWordsUITests: XCTestCase {

    func testExample() throws {

        let app = XCUIApplication()
        app.launch()
        app.textFields["InputWords"].tap()
        app.textFields["InputWords"].typeText("Test string")
        app.otherElements["BigView"].tap()
        app.buttons["ReverseButton"].tap()

        XCTAssert(app.staticTexts["tseT gnirts"].exists)
    }
}
