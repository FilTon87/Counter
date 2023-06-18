//
//  ViewController.swift
//  Counter
//
//  Created by Anton Filipchuk on 18.06.2023.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterButton: UIButton!
    @IBOutlet weak var counterButtonPlus: UIButton!
    @IBOutlet weak var counterButtonMinus: UIButton!
    @IBOutlet weak var counterButtonZeroing: UIButton!
    @IBOutlet weak var changesHistory: UITextView!
    
    func textViewShouldBeginEditing(_ changesHistory: UITextView) -> Bool {
    return false
    }
    
    func takeADate() -> String {    //функция по получению даты и преобразованию в строку
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private var counter = 0 //переменная счетчика
    private var history: [String] = ["История изменений:"] //массив с историей изменений
    
    
    private func printHistory() {   //функция по выводу истории изменений
        let text = history.joined(separator: "\n")
        changesHistory.text = text
    }
    
    private func counterPlus() {    //функция увеличения счетчика
        counter += 1
        counterLabel.text = "Значение счётчика: \(counter)"
        history.append("\(takeADate()): значение изменено на +1")
        printHistory()
    }
    
    private func counterMinus() {   //функция уменьшения счетчика
        counter -= 1
        if counter < 0 {    //цикл для ограничения изменения счетчика меньше 0
            counter = 0
            counterLabel.text = "Значение счётчика: \(counter)"
            history.append("\(takeADate()): попытка уменьшить значение счётчика ниже 0")
            printHistory()
        } else {
            counterLabel.text = "Значение счётчика: \(counter)"
            history.append("\(takeADate()): значение изменено на -1")
          printHistory()
        }
    }
    
    private func counterZeroing() {     //функция обнуления счетчика
        counter = 0
        counterLabel.text = "Значение счётчика: \(counter)"
        history.append("\(takeADate()): значение сброшено")
        printHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "0" //присвоили значение полю Label
        counterButton.setTitle("Счетчик", for: .normal) //присвоили название кнопке "Счетчик"
        counterButtonPlus.backgroundColor = .red //присвоили цвет кнопке "+"
        counterButtonMinus.backgroundColor = .blue //присвоили цвет кнопке "-"
        changesHistory.text = "История изменений:" //задали начальное значение полю TextView
        changesHistory.delegate = self
    }

    @IBAction func counterButtonDidTap(_ sender: Any) { //обработка нажатия на кнопку "Счетчик"
        counterPlus()
    }
    
    @IBAction func buttonPlusDidTap(_ sender: Any) {    //обработка нажатия на кнопку "+"
        counterPlus()
    }
    
    @IBAction func buttonMinusDidTap(_ sender: Any) {   //обработка нажатия на кнопку "-"
        counterMinus()
    }
    
    @IBAction func buttonZeroingDidTap(_ sender: Any) { //обработка нажатия на кнопку "0"
        counterZeroing()
    }
    
}

