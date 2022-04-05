//
//  Label.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 19.09.2021.
//

import UIKit

extension UILabel {

    var labelText: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }

}
