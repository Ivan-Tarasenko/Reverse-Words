//
//  TwoViewController.swift
//  Reverse Words
//
//  Created by Иван Тарасенко on 10.09.2021.
//

import UIKit

class TwoViewController: UIViewController {

    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var lineUnderTextField: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var alertsLabel: UILabel!
    @IBOutlet weak var fieldWithIgnoredCharacters: UITextField!
    @IBOutlet weak var resultButton: UIButton!

    private let buttonOn: CGFloat = 1
    private let buttonOff: CGFloat = 0.6
    let anagram = Anagrams()

    override func viewDidLoad() {
        super.viewDidLoad()
        textInputField.delegate = self
        fieldWithIgnoredCharacters.delegate = self
        addsTapToScrollview()

        settingOfButton(
            button: resultButton,
            alpha: buttonOff,
            cornerRadius: 14,
            label: resultLabel
        )

        setBoolForUIElements(
            forAlertsLabel: false,
            forFieldWithIgnoredCharacters: true,
            forResultButton: false
        )
    }

    // MARK: - Actions
    @IBAction func fieldForWordInput(_ sender: UITextField) {
        textFieldDidBeginEditing(sender)
        showTextDuringInput()
    }

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            clear()
            setBoolForUIElements(
                forAlertsLabel: false,
                forFieldWithIgnoredCharacters: true,
                forResultButton: false
            )
        case 1:
            clear()
            setBoolForUIElements(
                forAlertsLabel: true,
                forFieldWithIgnoredCharacters: false,
                forResultButton: false
            )
        default:
            clear()
            setBoolForUIElements(
                forAlertsLabel: true,
                forFieldWithIgnoredCharacters: false,
                forResultButton: true
            )
            textInputField.text = ""
            fieldWithIgnoredCharacters.text = ""
        }
    }

    @IBAction func pressingResultButton(_ sender: UIButton) {
        switch segmented.selectedSegmentIndex {
        case 0:
            resultIfDefault()
        case 1:
            resultIfCustom()
        default:
            break
        }
    }

    @IBAction func fieldForEnterIgnoredCharacters(_ sender: UITextField) {
        showTextWhileEnteringIgnorChar()
    }
    // End Actions

    // MARK: - The method is executed when the button is clicked in the default section
    func resultIfDefault() {
        guard !textInputField.text!.isEmpty else {
            showAlert(title: "Attention", message: "Please enter the words")
            return
        }
        resultLabel.text = anagram.defaultException(string: textInputField.text!)
    }

    // MARK: - The method is executed when the button is clicked in the user settings section
    func resultIfCustom() {
        guard !textInputField.text!.isEmpty else {
            showAlert(title: "Attention", message: "Please enter the words")
            return
        }
        resultLabel.text = anagram.customCharacter(
            string: textInputField.text!,
            ignorCharacter: fieldWithIgnoredCharacters.text!
        )
    }

    // MARK: - Shows the text while entering ignored characters
    private func showTextWhileEnteringIgnorChar() {
        if segmented.selectedSegmentIndex == 2 {
            resultLabel.text = anagram.customCharacter(
                string: textInputField.text!,
                ignorCharacter: fieldWithIgnoredCharacters.text!
            )
        }
    }

    // MARK: - Shows the text simultaneously with its input
    func showTextDuringInput() {
        if segmented.selectedSegmentIndex == 2 {
            resultLabel.text = anagram.defaultException(string: textInputField.text!)
        }
    }

    // MARK: - clearing fields
    private func clear() {
        resultLabel.text = ""
        textFieldDidEndEditing(textInputField)
    }

    // MARK: - setting boolean values for elements alertLabel and fieldWithIgnoredCharacters and resultButton
    func setBoolForUIElements(
        forAlertsLabel: Bool,
        forFieldWithIgnoredCharacters: Bool,
        forResultButton: Bool
    ) {
        alertsLabel.isHidden = forAlertsLabel
        fieldWithIgnoredCharacters.isHidden = forFieldWithIgnoredCharacters
        resultButton.isHidden = forResultButton
    }

}

// MARK: - Extension for Text Field
extension TwoViewController: UITextFieldDelegate {

    // MARK: - Input tracking
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemBlue
        textInputField.text!.isEmpty ?
            (resultButton.alpha = buttonOff) :
            (resultButton.alpha = buttonOn)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemGray5
    }

    // MARK: - Perform reverse by button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if segmented.selectedSegmentIndex == 0 {
            resultLabel.text = anagram.defaultException(string: textInputField.text!)
        } else
        if segmented.selectedSegmentIndex == 1 {
            resultLabel.text = anagram.customCharacter(
                string: textInputField.text!,
                ignorCharacter: fieldWithIgnoredCharacters.text!
            )
        }
        return true
    }
}
