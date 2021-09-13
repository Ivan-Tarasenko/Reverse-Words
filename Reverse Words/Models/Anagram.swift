//
//  Anagram.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 29.08.2021.
//

import Foundation

class Anagrams {

    func ignoredCharacters(_ input: String, excluded: [Character]) -> String {

        var result = Array(input)
        var charOne = 0
        var charTwo = result.count - 1

        while charOne < charTwo {
            while charOne < charTwo && excluded.contains(result[charOne]) {
                charOne += 1
            }

            while charOne < charTwo && excluded.contains(result[charTwo]) {
                charTwo -= 1
            }

            guard charOne < charTwo else { break }

            result.swapAt(charOne, charTwo)

            charOne += 1
            charTwo -= 1
        }

        return String(result)
    }

    // MARK: - Ignoring default character
    func defaultException(string: String) -> String {

        let arrayString: [String] = []
        let string = string.split(separator: " ")
        let defaultCharacter = setDefaultCharacters()
        return reverseString(
            string: string,
            inputCharacters: defaultCharacter,
            emptyArray: arrayString
        )
    }

    // MARK: - Entering custom characters
    func customCharacter(string: String, ignorCharacter: String) -> String {

        let inputArrayString = Array(ignorCharacter)
        let arrayString: [String] = []
        let string = string.split(separator: " ")
        var customCharacter: [Character] = []
        customCharacter += inputArrayString
        return reverseString(
            string: string,
            inputCharacters: customCharacter,
            emptyArray: arrayString
        )
    }

    // MARK: - The method expands the string with the exception of the specified characters
    func reverseString(
        string: [String.SubSequence],
        inputCharacters: [Character],
        emptyArray: [String]
    ) -> String {

        var emptyArray = emptyArray

        for word in string {
            let excludingChar = ignoredCharacters(
                String(word),
                excluded: inputCharacters
            )
            emptyArray.append(excludingChar)
        }
        return emptyArray.joined(separator: " ")
    }

    // MARK: - Set Array default characters
    func setDefaultCharacters() -> [Character] {
        let aScalars = "\u{0020}".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let letters: [Character] = (0..<33).map {char in Character(UnicodeScalar(aCode + char)!)
        }
        return letters
    }
}
