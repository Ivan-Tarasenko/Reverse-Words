//
//  Model.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 09.08.2021.
//

import UIKit

class ReversingWordsModel {

    // MARK: - Perform reverse words
    func reverseWords(string: String) -> String {
        return string
            .split(separator: " ")
            .map { getReverse(word: $0) }
            .joined(separator: " ")
        }

    private func getReverse(word: Substring) -> String {
        return String(word.reversed())
    }
}
