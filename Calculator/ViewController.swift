//
//  ViewController.swift
//  Calculator
//
//  Created by Brandon on 9/14/18.
//  Copyright © 2018 Brandon Carr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenLabel: UILabel!
    
    // globals
    var numberBuffer: String = ""
    var numberArray: [Int] = []
    var opArray: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        numberBuffer.append("\(sender.tag)")
        updateScreen()
    }
    
    @IBAction func opPressed(_ sender: UIButton) {
        if numberBuffer == "" {
            return
        }
        numberArray.append(Int(numberBuffer)!)
        // put operator into the opArray
        switch sender.tag {
        case 10: // +
            opArray.append("+")
            print ("Added + to opArray")
        case 11: // -
            opArray.append("-")
            print ("Added - to opArray")
        case 12: // *
            opArray.append("*")
            print ("Added * to opArray")
        case 13: // /
            opArray.append("/")
            print ("Added / to opArray")
        default:
            print("Something went wrong")
        }
        clearBuffer()
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        // grab the last value from numberBuffer and put it into numberArray
        if numberBuffer != "" {
            numberArray.append(Int(numberBuffer)!)
        }
        // iterate through all values in opArray and do each operation
        var runningValue: Int = numberArray[0]
        numberArray.removeFirst()
        
        for op in opArray {
            switch op {
            case "+":
                runningValue += numberArray[0]
            case "-":
                runningValue -= numberArray[0]
            case "*":
                runningValue *= numberArray[0]
            case "/":
                runningValue /= numberArray[0]
            default:
                print("Something happened.")
            }
            numberArray.removeFirst()
        }
        opArray.removeAll()
        numberBuffer = "\(runningValue)"
        updateScreen()
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        clearBuffer()
        clearOp()
        updateScreen()
    }
    
    func updateScreen() {
        screenLabel.text = numberBuffer
        print("Screen updated as \(numberBuffer)")
    }
    
    func clearBuffer() {
        numberBuffer = ""
        print("Number buffer cleared.")
    }
    
    func clearOp() {
        opArray.removeAll()
        print("Op array cleared.")
    }
    
    func clearNumber() {
        numberArray.removeAll()
        print("Number array cleared")
    }

}

