//
//  Anagrams_UnitTest.swift
//  Reverse WordsTests
//
//  Created by Иван Тарасенко on 30.08.2021.
//

import XCTest
@testable import Reverse_Words
class AnagramsUnitTest: XCTestCase {

    var sut: Anagrams!
    let characterXL = "xl"

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Anagrams()
    }

    override func tearDownWithError() throws {
        sut = Anagrams()
        try super.tearDownWithError()
    }

    func testInputStringEmpty() {
        let string = ""
        let customCharacters = sut.setCustomCharacter(string: "")

        let anagram = sut.reverse(string: string, ignored: customCharacters)

        XCTAssertEqual(anagram, string)
        XCTAssertNotNil(anagram, "function 'ignoredCharacters' returned nil empty string")
    }

    func testEnterOneSymbol() {
        let string = "R"
        let customCharacters = sut.setCustomCharacter(string: "RFT")

        let anagram = sut.reverse(string: string, ignored: customCharacters)

        XCTAssertIdentical(anagram as AnyObject, string as AnyObject)
        XCTAssertNotNil(anagram, "function returned nil")
    }

    func testEnterOneWordAndIgnoredTwoCharacters() {
        let string = "Foxminded"
        let customCharacters = sut.setCustomCharacter(string: "Fnx")
        let result = "Fdxednimo"

        let anagram = sut.reverse(string: string, ignored: customCharacters)

        XCTAssertEqual(anagram, result)
    }

    func testEmptyStringDefaultExcluding() {
        let string = ""

        let anagram = sut.reversedWithDefaultRules(string: string)

        XCTAssertNotNil(anagram, "function 'DefaultExcluding' returned nil empty string")
        XCTAssertEqual(anagram, string)
    }

    func testEnterOneWordInDefaultExcluding() {
        let string = "3+2-1"
        let defaultResult = "3+2-1"

        let anagram = sut.reversedWithDefaultRules(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testInputManyWordsInDefaultExcludingOption1() {
        let stringManyWords = "Foxminded cool 24/7"
        let resultManyWords = "dednimxoF looc 24/7"

        let anagram = sut.reversedWithDefaultRules(string: stringManyWords)

        XCTAssertEqual(anagram, resultManyWords)
    }

    func testInputManyWordsInDefaultExcludingOption2() {
        let string = "abcd efgh"
        let defaultResult = "dcba hgfe"

        let anagram = sut.reversedWithDefaultRules(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testInputManyWordsInDefaultExcludingOption3() {
        let string = "a1bcd efg!h"
        let defaultResult = "d1cba hgf!e"

        let anagram = sut.reversedWithDefaultRules(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testIfValuesAreNotEqualInDefaultExcluding() {
        let string = "Foxminded cool 24/7"
        let defaultResult = "Fdednimxo looc 24/7"

        let anagram = sut.reversedWithDefaultRules(string: string)

        XCTAssertNotEqual(anagram, defaultResult)
    }
}
