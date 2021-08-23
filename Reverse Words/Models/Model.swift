//
//  Model.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 09.08.2021.
//

import UIKit

class ReversingWordsModel {

    // MARK: - Perform reverse words
    func reverseWords (text: String) -> String {
        let words = getWords(from: text)
        var reversedWordsArray = [String]()
        for word in words {
            let reverse = String(word.reversed())
            reversedWordsArray.append(reverse)
        }
        let result = reversedWordsArray.joined(separator: " ")
        return result
    }

    private func getWords(from text: String) -> [Substring] {
        return text.split(separator: " ")
    }
}
