//
//  ViewController.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 09.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var lineUnderTextField: UIView!

    private let buttonOn: CGFloat = 1
    private let buttonOff: CGFloat = 0.6
    let reversingWords = ReversingWordsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        textInputField.delegate = self
        addsTapToScrollview()
        settingOfButton(
            button: reverseButton,
            alpha: buttonOff,
            cornerRadius: 14,
            label: resultLabel
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
        if resultLabel.text!.isEmpty {
            resultLabel.text = reversingWords.reverseWords(string: textInputField.text!)
            setTitleButton(button: sender, titleButton: "Clear")
        } else {
            clear()
            setTitleButton(button: sender, titleButton: "Reverse")
        }
    }

    // MARK: - clearing fields
    private func clear() {
        resultLabel.text?.removeAll()
        textInputField.text?.removeAll()
        textInputField.sendActions(for: .editingChanged)
        textFieldDidEndEditing(textInputField)
    }
}

// MARK: - Extension for Text Field
extension ViewController: UITextFieldDelegate {

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
        if !resultLabel.text!.isEmpty {
            reverseButton.setTitle("Clear", for: .normal)
        }
        return true
    }
}
