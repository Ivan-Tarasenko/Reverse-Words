//
//  TextField.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 14.09.2021.
//

import UIKit

extension UITextField {

    var string: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }
}
