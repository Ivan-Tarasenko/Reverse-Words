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
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var fieldWithIgnoredCharacters: UITextField!
    @IBOutlet weak var alertsLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!

    private let buttonOn: CGFloat = 1
    private let buttonOff: CGFloat = 0.6
    let reversingWords = ReversingWordsModel()
    let anagram = Anagrams()

    override func viewDidLoad() {
        super.viewDidLoad()
        textInputField.delegate = self
        configButtonAndResultLabel()
        addsTapTocSrollview()
    }

    // MARK: - Actions
    @IBAction func fieldForWordInput() {
        textFieldDidBeginEditing(textInputField)
        showTextDuringInput()
    }

    @IBAction func pressingReverseButton() {
        changingTheButton()
    }

    @IBAction func segmentedControl() {
        switchSegmentedControl()
    }

    @IBAction func pressingResultButton() {
        setButtonResult()
    }

    @IBAction func fieldForEnterIgnoredCharacters() {
        textFieldDidBeginEditing(fieldWithIgnoredCharacters)
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if segmented.selectedSegmentIndex == 2 {
                resultLabel.text = anagram.customCharacter(
                    string: textInputField.text!,
                    ignorCharacter: fieldWithIgnoredCharacters.text!)
            }
        }
    }

    // MARK: - Change button status
    func changingTheButton() {
        switch reverseButton.titleLabel?.text {
        case "Reverse":
            setIfButtonTitleReverse()
        case "Clear":
            setIfButtonTitleClear()
        default:
            break
        }
    }

    // MARK: - Set the condition for button "Reverse"
    func setIfButtonTitleReverse() {
        resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
        if textInputField.text == "" {
            reverseButton.setTitle("Reverse", for: .normal)
            showAlert(title: "Attention", message: "Please enter the words")
        } else {
            reverseButton.setTitle("Clear", for: .normal)
        }
    }

    // MARK: - Set the condition for button "Clear"
    func setIfButtonTitleClear() {
        lineUnderTextField.backgroundColor = .systemGray5
        textInputField.text = ""
        reverseButton.setTitle("Reverse", for: .normal)
        reverseButton.alpha = buttonOff
        resultLabel.text = ""
    }

    // MARK: - Set the condition for Segmented control
    func switchSegmentedControl() {
        switch segmented.selectedSegmentIndex {
        case 0:
            resultLabel.text = ""
            fieldWithIgnoredCharacters.isHidden = true
            alertsLabel.isHidden = false
            resultButton.isHidden = false
        case 1:
            resultLabel.text = ""
            alertsLabel.isHidden = true
            fieldWithIgnoredCharacters.isHidden = false
            resultButton.isHidden = false
        case 2:

            resultLabel.text = ""
            textInputField.text = ""
            fieldWithIgnoredCharacters.text = ""
            alertsLabel.isHidden = true
            fieldWithIgnoredCharacters.isHidden = false
            resultButton.isHidden = true
        default:
            break
        }
    }

    // MARK: - Set button "Result"
    func setButtonResult() {
        if textInputField.text == "" {
            showAlert(title: "Attention", message: "Please enter the words")
        }
        switch segmented.selectedSegmentIndex {
        case 0:
            resultLabel.text = anagram.defaultException(string: textInputField.text!)
        case 1:
            resultLabel.text = anagram.customCharacter(
                string: textInputField.text!,
                ignorCharacter: fieldWithIgnoredCharacters.text!)
        default:
            break
        }
    }

    // MARK: - Config button and label
    func configButtonAndResultLabel() {
        reverseButton.alpha = buttonOff
        reverseButton.layer.cornerRadius = 14
        resultLabel.text = ""
        resultButton.alpha = buttonOff
        resultButton.layer.cornerRadius = 14
        fieldWithIgnoredCharacters.isHidden = true
    }

    // MARK: - Shows the text simultaneously with its input
    func showTextDuringInput() {
        if segmented.selectedSegmentIndex == 2 {
            resultLabel.text = anagram.defaultException(string: textInputField.text!)
        }
    }

    // MARK: - Adds a tap on the scrollview to hide the keyboard outside the textfield
    private func addsTapTocSrollview() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(
                                        target: self.view,
                                        action: #selector(UIView.endEditing(_:))))
    }

    // MARK: - Alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

// MARK: - Extension for Text Field
extension ViewController: UITextFieldDelegate {

    // MARK: - Input tracking
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemBlue
        if textInputField.text == "" {
            reverseButton.alpha = buttonOff
            resultButton.alpha = buttonOff
        } else {
            reverseButton.alpha = buttonOn
            resultButton.alpha = buttonOn
        }
        if textInputField.text != "" {
            reverseButton.setTitle("Reverse", for: .normal)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemGray5
    }

    // MARK: - Perform reverse by button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
        if resultLabel.text != "" {
            reverseButton.setTitle("Clear", for: .normal)
        }
        return true
    }
}
