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
        let character: [Character] = [" "]

        let anagram = sut.excludingСharacters(string, excluded: character)

        XCTAssertEqual(anagram, string)
        XCTAssertNotNil(anagram, "function 'excludingСharacters' returned nill empty string")
    }

    func testInputSinglCharacter() {
        let string = "R"
        let character: [Character] = ["R", "F", "T"]

        let anagram = sut.excludingСharacters(string, excluded: character)

        XCTAssertIdentical(anagram as AnyObject, string as AnyObject)
        XCTAssertNotNil(anagram, "function returned nill")
    }

    func testInputSinglWordAndExcludingTwoCharacters() {
        let string = "Foxminded"
        let character: [Character] = ["F", "n", "x"]
        let result = "Fdxednimo"

        let anagram = sut.excludingСharacters(string, excluded: character)

        XCTAssertEqual(anagram, result)
    }

    func testEmptyStrngDefaultExcluding() {
        let string = ""

        let anagram = sut.defaultExcuding(string: string)

        XCTAssertNotNil(anagram, "function 'DefaultExcluding' returned nill empty string")
        XCTAssertEqual(anagram, string)
    }

    func testInputSinglWordInDefaultExcluding() {
        let string = "3+2-1"
        let defaultResult = "3+2-1"

        let anagram = sut.defaultExcuding(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testInputManyWordsInDefaultExcludingOption1() {
        let stringManyWords = "Foxminded cool 24/7"
        let resultManyWords = "dednimxoF looc 24/7"

        let anagram = sut.defaultExcuding(string: stringManyWords)

        XCTAssertEqual(anagram, resultManyWords)
    }

    func testInputManyWordsInDefaultExcludingOption2() {
        let string = "abcd efgh"
        let defaultResult = "dcba hgfe"

        let anagram = sut.defaultExcuding(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testInputManyWordsInDefaultExcludingOption3() {
        let string = "a1bcd efg!h"
        let defaultResult = "d1cba hgf!e"

        let anagram = sut.defaultExcuding(string: string)

        XCTAssertEqual(anagram, defaultResult)
    }

    func testIfValuesAreNotEqualInDefaultExcluding() {
        let string = "Foxminded cool 24/7"
        let defaultResult = "Fdednimxo looc 24/7"

        let anagram = sut.defaultExcuding(string: string)

        XCTAssertNotEqual(anagram, defaultResult)
    }

    func testEmptyStrngInCustomCharacter() {
        let string = ""
        let character = ""

        let anagram = sut.customCharacter(string: string, ignorCharacter: character)

        XCTAssertNotNil(anagram, "function 'customCharacter' returned nill empty string")
        XCTAssertEqual(anagram, string)
    }

    func testInputSinglWordInCustomCharacter() {
        let string = "Foxminded"
        let character = "Fnx"
        let result = "Fdxednimo"

        let anagram = sut.customCharacter(string: string, ignorCharacter: character)

        XCTAssertEqual(anagram, result)
    }

    func testInputManyWordsInCustomCharacterOption1() {
        let string = "Foxminded cool 24/7"
        let result = "dexdnimoF oocl 7/42"

        let anagram = sut.customCharacter(string: string, ignorCharacter: characterXL)

        XCTAssertEqual(anagram, result)
    }

    func testInputManyWordsInCustomCharacterOption2() {
        let string = "abcd efgh"
        let result = "dcba hgfe"

        let anagram = sut.customCharacter(string: string, ignorCharacter: characterXL)

        XCTAssertEqual(anagram, result)
    }

    func testInputManyWordsInCustomCharacterOption3() {
        let string = "a1bcd efglh"
        let result = "dcb1a hgfle"

        let anagram = sut.customCharacter(string: string, ignorCharacter: characterXL)

        XCTAssertEqual(anagram, result)
    }

    func testIfValuesAreNotEqualInCustomCharacter() {
        let string = "a1bcd efglh"
        let result = "dcb1a hfgle"

        let anagram = sut.customCharacter(string: string, ignorCharacter: characterXL)

        XCTAssertNotEqual(anagram, result)
    }
}
