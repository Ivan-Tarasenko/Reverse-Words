//
//  ExtensionViewController.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 11.09.2021.
//

import UIKit

extension UIViewController {

    // MARK: - Sets the title for the button
    func setTitleButton(button: UIButton, titleButton: String) {
        button.setTitle(titleButton, for: .normal)
    }

    // MARK: - Adds a tap on the scrollview to hide the keyboard outside the textfield
    func addsTapToScrollview() {
        self.view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self.view,
                action: #selector(UIView.endEditing(_:)))
        )
    }

    // MARK: - Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    // MARK: - Initial settings of ui elements
    func settingOfButton(button: UIButton, alpha: CGFloat, cornerRadius: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.alpha = alpha
    }
}
