//
//  FirstViewController.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 09.08.2021.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var lineUnderTextField: UIView!

    private let buttonOn: CGFloat = 1
    private let buttonOff: CGFloat = 0.6
    let reversingWords = FirstViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        textInputField.delegate = self
        addsTapToScrollview()
        settingOfButton(
            button: reverseButton,
            alpha: buttonOff,
            cornerRadius: 14
        )
        
    }

    // MARK: - Actions
    @IBAction func fieldForWordInput(_ sender: UITextField) {
        textFieldDidBeginEditing(sender)
    }

    @IBAction func pressingReverseButton(_ sender: UIButton) {
        guard !textInputField.string.isEmpty else {
            showAlert(title: "Attention", message: "Please enter the words")
            return
        }
        if resultLabel.labelText.isEmpty {
            resultLabel.text = reversingWords.reverseWords(string: textInputField.text!)
            setTitleButton(button: sender, titleButton: "Clear")
        } else {
            clear()
            setTitleButton(button: sender, titleButton: "Reverse")
        }
    }

    // MARK: - clearing fields
    private func clear() {
        resultLabel.labelText.removeAll()
        textInputField.string.removeAll()
        textInputField.sendActions(for: .editingChanged)
        textFieldDidEndEditing(textInputField)
    }
}

// MARK: - Extension for Text Field
extension FirstViewController: UITextFieldDelegate {

    // MARK: - Input tracking
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemBlue
        textInputField.string.isEmpty ?
            (reverseButton.alpha = buttonOff) :
            (reverseButton.alpha = buttonOn)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemGray5
    }

    // MARK: - Perform reverse by button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resultLabel.text = reversingWords.reverseWords(string: textInputField.text!)
        if !resultLabel.labelText.isEmpty {
            reverseButton.setTitle("Clear", for: .normal)
        }
        return true
    }
}

extension UIViewController {

    // Sets the title for the button
    func setTitleButton(button: UIButton, titleButton: String) {
        button.setTitle(titleButton, for: .normal)
    }

    // Adds a tap on the scrollview to hide the keyboard outside the textfield
    func addsTapToScrollview() {
        self.view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self.view,
                action: #selector(UIView.endEditing(_:)))
        )
    }

    func settingOfButton(button: UIButton, alpha: CGFloat, cornerRadius: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.alpha = alpha
    }

    // Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
