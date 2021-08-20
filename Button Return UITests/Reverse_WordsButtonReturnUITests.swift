//
//  Reverse_WordsButtonReturnUITests.swift
//  Reverse WordsButtonReturnUITests
//
//  Created by Иван Тарасенко on 20.08.2021.
//

import XCTest

class ReverseWordsButtonReturnUITests: XCTestCase {

    func testExample() throws {

        let app = XCUIApplication()
        app.launch()
        app.textFields["InputWords"].tap()
        app.textFields["InputWords"].typeText("Test string")
        app.buttons["Return"].tap()

        XCTAssert(app.staticTexts["tseT gnirts"].exists)
    }
}
