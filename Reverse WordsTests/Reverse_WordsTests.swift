//
//  Reverse_WordsTests.swift
//  Reverse WordsTests
//
//  Created by Иван Тарасенко on 22.08.2021.
//

import XCTest

@testable import Reverse_Words

class ReverseWordsTests: XCTestCase {
    var sut: ReversingWordsModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ReversingWordsModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInputEmptyString() {
        let stringInput = ""
        let stringOut = ""
        XCTAssertEqual(stringOut, sut.reverseWords(text: stringInput))
    }

    func testInputSinglWord() {
        let stringInput = "Test"
        let stringOut = "tseT"
        XCTAssertEqual(stringOut, sut.reverseWords(text: stringInput))
    }

    func testMultipleWords() {
        // gevin
        let stringInput = "Test string"
        let stringOut = "tseT gnirts"
        // when
        let reverse = sut.reverseWords(text: stringInput)
        // then
        XCTAssertEqual(reverse, stringOut)
    }
}
