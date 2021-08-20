//
//  Reverse_WordsTests.swift
//  Reverse WordsTests
//
//  Created by Иван Тарасенко on 19.08.2021.
//

import XCTest
@testable import Reverse_Words

class ReverseWordsUnitTests: XCTestCase {

    var sut: ReversingWordsModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ReversingWordsModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testReverse() {

        XCTAssertEqual(sut.reverseWords(text: "Test string"), "tseT gnirts")
    }
}
