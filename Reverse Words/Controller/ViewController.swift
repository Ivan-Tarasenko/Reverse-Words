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
        configButtonAndResultLabel()
    }

    // MARK: - начаись экшены
    @IBAction func textFieldPressed() {
        textFieldDidBeginEditing(textInputField)
    }
    @IBAction func reverseButtonPressed() {
        changingTheButton()
    }

    // MARK: - метод изменения кнопки
    func changingTheButton() {
        switch reverseButton.titleLabel?.text {
        case "Reverse":
            resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
            if textInputField.text == "" {
                reverseButton.setTitle("Reverse", for: .normal)
                showAlert(title: "Attention", message: "Please enter the words")
            } else {
                reverseButton.setTitle("Clear", for: .normal)
            }
        case "Clear":
            lineUnderTextField.backgroundColor = .systemGray5
            textInputField.text = ""
            reverseButton.setTitle("Reverse", for: .normal)
            reverseButton.alpha = buttonOff
            resultLabel.text = ""
        default:
            break
        }
    }

    // MARK: - Конфигурации кнопки и лэйбла результатов
    func configButtonAndResultLabel() {
        reverseButton.alpha = buttonOff
        reverseButton.layer.cornerRadius = 14
        resultLabel.text = ""
    }
    // MARK: - Предупреждение
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Расширение для Text Field
extension ViewController: UITextFieldDelegate {
    // MARK: - Скрытие клавиатуры по тапу за пределами клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - методы отслеживания ввода
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemBlue
        if textInputField.text == "" {
            reverseButton.alpha = buttonOff
        } else {
            reverseButton.alpha = buttonOn
        }
        if textInputField.text != "" {
            reverseButton.setTitle("Reverse", for: .normal)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lineUnderTextField.backgroundColor = .systemGray5
    }

    // MARK: - Выполнение по кнопке return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resultLabel.text = reversingWords.reverseWords(text: textInputField.text!)
        if resultLabel.text != "" {
            reverseButton.setTitle("Clear", for: .normal)
        }
        return true
    }
}
