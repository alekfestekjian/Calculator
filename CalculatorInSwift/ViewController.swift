//
//  ViewController.swift
//  CalculatorInSwift
//
//  Created by Alek Festekjian on 3/1/15.
//  Copyright (c) 2015 Alek Festekjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    /*
    if let displayText = display.text {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.locale = NSLocale(localeIdentifier: "en_US")
        if let displayNumber = numberFormatter.numberFromString(displayText) {
            return displayNumber.doubleValue
        }
    }*/

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            if digit != "." || nil == display.text?.rangeOfString("."){
                display.text = display.text! + digit
            }
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $0 + $1 }
            case "-": performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0)}
            case "sin": performOperation { sin($0)}
            case "cos": performOperation { cos($0)}
            case "π": performOperation { $0 * M_PI }
            default : break
        }
    }
    
    
   
    
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operation: (Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    @IBAction func ClearAll(sender: UIButton) {
        if(!operandStack.isEmpty){
            operandStack.removeAll();
        }
        displayValue = 0
        println("operandStack= \(operandStack)")
    }
    
    
    var operandStack =  Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        operandStack.append(displayValue)
        println("operandStack= \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
           display.text = "\(newValue)"
           userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

