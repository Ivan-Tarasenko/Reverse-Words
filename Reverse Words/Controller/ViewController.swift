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
    @IBOutlet weak var inputFieldAnagrams: UITextField!
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
    }

    // MARK: - Actions
    @IBAction func textFieldPressed(_ sender: Any) {
        textFieldDidBeginEditing(textInputField)
        realTimeInput()
    }

    @IBAction func reverseButtonPressed() {
        changingTheButton()
    }

    @IBAction func modeSwich() {
        setapSegmented()
    }

    @IBAction func resultButtonPressed() {
        setButtonResult()
    }

    @IBAction func textFieldIgnor() {
        textFieldDidBeginEditing(inputFieldAnagrams)
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if segmented.selectedSegmentIndex == 2 {
                resultLabel.text = inputFieldAnagrams.text
                resultLabel.text = anagram.customCharacter(string: textInputField.text!,
                                                           ignorCharacter: inputFieldAnagrams.text!)
            }
        }
    }

    // MARK: - Change button status
    func changingTheButton() {
        switch reverseButton.titleLabel?.text {
        case "Reverse":
            setIfbuttonTitleReverse()
        case "Clear":
            setIfbuttonTitleCrear()
        default:
            break
        }
    }

    // MARK: - Set the condition for button "Reverse"
    func setIfbuttonTitleReverse() {
        resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
        if textInputField.text == "" {
            reverseButton.setTitle("Reverse", for: .normal)
            showAlert(title: "Attention", message: "Please enter the words")
        } else {
            reverseButton.setTitle("Clear", for: .normal)
        }
    }

    // MARK: - Set the condition for button "Clear"
    func setIfbuttonTitleCrear() {
        lineUnderTextField.backgroundColor = .systemGray5
        textInputField.text = ""
        reverseButton.setTitle("Reverse", for: .normal)
        reverseButton.alpha = buttonOff
        resultLabel.text = ""
    }

    // MARK: - Set the condition for Segmented control
    func setapSegmented() {
        switch segmented.selectedSegmentIndex {
        case 0:
            resultLabel.text = ""
            inputFieldAnagrams.isHidden = true
            alertsLabel.isHidden = false
            resultButton.isHidden = false
        case 1:
            resultLabel.text = ""
            alertsLabel.isHidden = true
            inputFieldAnagrams.isHidden = false
            resultButton.isHidden = false
        case 2:

            resultLabel.text = ""
            textInputField.text = ""
            inputFieldAnagrams.text = ""
            alertsLabel.isHidden = true
            inputFieldAnagrams.isHidden = false
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
            resultLabel.text = anagram.defaultExcuding(string: textInputField.text!)
        case 1:
            resultLabel.text = anagram.customCharacter(string: textInputField.text!,
                                                       ignorCharacter: inputFieldAnagrams.text!)
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
        inputFieldAnagrams.isHidden = true
    }

    // MARK: - Real-time input
    func realTimeInput() {
        if segmented.selectedSegmentIndex == 2 {
            resultLabel.text = textInputField.text
            resultLabel.text = anagram.defaultExcuding(string: textInputField.text!)
        }
    }

    // MARK: - Alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

// MARK: - Extention for Text Field
extension ViewController: UITextFieldDelegate {

    // MARK: - Hide keyboard by clicking outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

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

    // MARK: - Excute on the button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
        if resultLabel.text != "" {
            reverseButton.setTitle("Clear", for: .normal)
        }
        return true
    }
}
