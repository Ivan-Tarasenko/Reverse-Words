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
            textInputField.text?.removeAll()
            fieldWithIgnoredCharacters.text?.removeAll()
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

    // MARK: - Custom reverse words
    func customReverse(inputString: String, customString: String, outString: UILabel) {
        let customCharacters = anagram.setCustomCharacter(string: customString)
        outString.text = anagram.reverse(string: inputString, ignored: customCharacters)
    }

    // MARK: - The method is executed when the button is clicked in the default section
    func resultIfDefault() {
        guard !textInputField.string.isEmpty else {
            showAlert(title: "Attention", message: "Please enter the words")
            return
        }
        resultLabel.text = anagram.reversedWithDefaultRules(string: textInputField.string)
    }

    // MARK: - The method is executed when the button is clicked in the user settings section
    func resultIfCustom() {
        guard !textInputField.string.isEmpty else {
            showAlert(title: "Attention", message: "Please enter the words")
            return
        }
        customReverse(
            inputString: textInputField.string,
            customString: fieldWithIgnoredCharacters.string,
            outString: resultLabel
        )
    }

    // MARK: - Shows the text while entering ignored characters
    private func showTextWhileEnteringIgnorChar() {
        if segmented.selectedSegmentIndex == 2 {
            customReverse(
                inputString: textInputField.string,
                customString: fieldWithIgnoredCharacters.string,
                outString: resultLabel
            )
        }
    }

    // MARK: - Shows the text simultaneously with its input
    func showTextDuringInput() {
        if segmented.selectedSegmentIndex == 2 {
            resultLabel.text = anagram.reversedWithDefaultRules(string: textInputField.string)
        }
    }

    // MARK: - clearing fields
    private func clear() {
        resultLabel.text?.removeAll()
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
        textInputField.string.isEmpty ?
            (resultButton.alpha = buttonOff) :
            (resultButton.alpha = buttonOn)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemGray5
    }

    // MARK: - Perform reverse by button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if segmented.selectedSegmentIndex == 0 {
            resultLabel.text = anagram.reversedWithDefaultRules(string: textInputField.string)
        } else
        if segmented.selectedSegmentIndex == 1 {
            customReverse(
                inputString: textInputField.string,
                customString: fieldWithIgnoredCharacters.string,
                outString: resultLabel
            )
        }
        return true
    }
}
