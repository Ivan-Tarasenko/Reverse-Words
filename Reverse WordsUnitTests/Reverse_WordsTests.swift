//
//  Reverse_WordsTests.swift
//  Reverse WordsTests
//
//  Created by Иван Тарасенко on 22.08.2021.
//

import XCTest

@testable import Reverse_Words

class ReverseWordsTests: XCTestCase {
    var sut: FirstViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirstViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInputEmptyString() {
        let stringInput = ""
        let stringOut = ""

        let reverse = sut.reverseWords(string: stringInput)

        XCTAssertEqual(reverse, stringOut)
        XCTAssertNotNil(reverse, "function 'Rverse' returned nill empty string")
    }

    func testInputSinglWord() {
        let stringInput = "Test"
        let stringOut = "tseT"

        let reverse = sut.reverseWords(string: stringInput)

        XCTAssertEqual(stringOut, reverse )
    }

    func testMultipleWords() {
        let stringInput = "Test string"
        let stringOut = "tseT gnirts"

        let reverse = sut.reverseWords(string: stringInput)

        XCTAssertEqual(reverse, stringOut)
    }

    func testIfValueAreNotEqual() {
        let stringInput = "Test string"
        let stringOut = "tset gnirts"

        let reverse = sut.reverseWords(string: stringInput)

        XCTAssertNotEqual(reverse, stringOut)
    }
}
