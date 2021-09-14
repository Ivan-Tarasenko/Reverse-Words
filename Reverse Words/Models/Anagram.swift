//
//  Anagram.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 29.08.2021.
//

import Foundation

class Anagrams {

    let defaultIgnoreSet = CharacterSet.letters.inverted // built-in character set
    // я понял!!! эта переменная это и есть тот самый набор символов которые будут использоваться как дефолтные значени!

    // MARK: - Ignoring default character
    func reversedWithDefaultRules(string: String) -> String {
        return reverse(string: string, ignored: defaultIgnoreSet)
    }

    /// Method returns expanded string with excluded characters.
    /// - Parameters:
    ///   - string: Input string to reverse.
    ///   - ignored: Characters that the method ignores.
    /// - Returns: Returns an expanded string with excluded characters.
    func reverse(string: String, ignored: CharacterSet) -> String {
        return string
            .split(separator: " ")    // parses a string into separate words.
            .map { reverse(word: $0, ignored: ignored) } /* expands the string
             ignoring the characters specified in "defaultIgnoreSet".*/
            .joined(separator: " ")  // gathers words into a string.
    }

    /// The method sorts the string into characters that match the list of excluded symbols and
    ///  which characters are not in the list. Then it combines all the characters.
    /// - Parameters:
    ///   - word: Word separated from common string.
    ///   - ignored: Exclusion symbols
    /// - Returns: Returns a reversed string.
    private func reverse(word: Substring, ignored: CharacterSet) -> String {

        var charactersArray = Array(word)
        guard var begin = charactersArray.indices.first,
              var end = charactersArray.indices.last,
              end > begin
        else {
            return String(charactersArray)
        }
        while begin < end {
            if ignored.checkIsSuperSet(for: charactersArray[begin]) {
                begin += 1
            } else if ignored.checkIsSuperSet(for: charactersArray[end]) {
                end -= 1
            } else {
                charactersArray.swapAt(begin, end)
                begin += 1
                end -= 1
            }
        }
        return String(charactersArray)
    }

    /// Converts a string to a character set.
    /// - Parameters:
    ///   - string: Input a string of ignored characters.
    /// - Returns: Return charaacter set.

    func setCustomCharacter(string: String) -> CharacterSet {
        return CharacterSet(charactersIn: string)
    }

}

// To simplify use
extension CharacterSet {

    /// An extension for characterSet that converts characters to unicode values and checks if
    /// the input character is in this parameter or not.
    /// - Parameters:
    /// - forCharacter: Input character.
    /// - Returns: Boolean value.

    func checkIsSuperSet(for character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
