//
//  ViewController.swift
//  Calculator
//
//  Created by Diego Negrelli on 27/05/15.
//  Copyright (c) 2015 Diego Negrelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!;
        if(userIsInTheMiddleOfTypingANumber) {
            display.text = display.text! + digit;
        } else {
            display.text = digit;
            userIsInTheMiddleOfTypingANumber = true;
        }
        
    }

    @IBAction func appendDot(sender: UIButton) {
        
        if(display.text!.rangeOfString(sender.currentTitle!) == nil) {
            display.text = display.text! + ".";
        } else {
            display.text = "0.";
        }
        userIsInTheMiddleOfTypingANumber = true;
        
    }
    
    @IBAction func clear(sender: AnyObject) {
        operandStack.removeAll(keepCapacity: false);
        display.text! = "0";
        historyDisplay.text! = "";
    }
    
    @IBAction func appendPI(sender: AnyObject) {
        
        if(userIsInTheMiddleOfTypingANumber) {
            enter();
        }
        display.text = "\(M_PI)";
        enter();

    }
    
    var operandStack = Array<Double>();
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false;
        operandStack.append(displayValue);
        println("operandStack = \(operandStack)");
        historyDisplay.text! = "\(operandStack)";
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
            display.text = "\(newValue)";
            userIsInTheMiddleOfTypingANumber = false;
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!;
        if(userIsInTheMiddleOfTypingANumber) {
            enter();
        }
        
        switch operation {
            case "×": performOperation {$0 * $1};
            case "÷": performOperation {$1 / $0};
            case "+": performOperation {$0 + $1};
            case "−": performOperation {$1 - $0};
            case "√": performOperation {sqrt($0)};
            case "sin": performOperation {sin($0)};
            case "cos": performOperation {cos($0)};
            default: break;
        }
        
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast());
            enter();
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast());
            enter();
        }
    }

}

