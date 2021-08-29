//
//  Anagram.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 29.08.2021.
//

import Foundation

class Anagrams {

    func excludingСharacters(_ input: String, excluded: [Character]) -> String {

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
}
