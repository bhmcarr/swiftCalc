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
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    // globals
    var displayBuffer: String = ""
    var op: Character = "i"
    
    var numArray: [Int] = []
    var runningValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        displayBuffer.append("\(sender.tag)")
        updateScreen()

        resetOpButtonColor()
    }
    
    @IBAction func opPressed(_ sender: UIButton) {
        // op pressed, store current value if it exists
        if !displayBuffer.isEmpty{
            numArray.append(Int(displayBuffer)!)
        }
        
        if op != "i" {
            // do math and update screen and running value
            switch op {
            case "+":
                numArray[0] = numArray[0] + numArray[1]
            case "-":
                numArray[0] = numArray[0] - numArray[1]
            case "*":
                numArray[0] = numArray[0] * numArray[1]
            case "/":
                numArray[0] = numArray[0] / numArray[1]
            default:
                print("Something went wrong")
            }
            
            // update screen
            displayBuffer = ("\(numArray[0])")
            updateScreen()
            
            // remove numArray[1]
            numArray.remove(at: 1)
            
            // unset op
            op = "i"
        }
        
        // set op mode
        if sender.tag != 14 {
            sender.backgroundColor = hexStringToUIColor(hex: "#e74c3c")
        }
        switch sender.tag {
        case 10:
            op = "+"
        case 11:
            op = "-"
        case 12:
            op = "*"
        case 13:
            op = "/"
        case 14: // =
            // equals pressed, put runningValue into buffer + update screen
            op = "i"
            displayBuffer = "\(numArray[0])"
            updateScreen()
        default:
            print("operator setting problem")
        }
        
        displayBuffer = ""
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        displayBuffer = ""
        numArray.removeAll()
        updateScreen()
    }
    
    func updateScreen() {
        screenLabel.text = displayBuffer
    }
    
    func resetOpButtonColor() {
        plusButton.backgroundColor = hexStringToUIColor(hex: "#F1C40F")
        minusButton.backgroundColor = hexStringToUIColor(hex: "#F1C40F")
        multiplyButton.backgroundColor = hexStringToUIColor(hex: "#F1C40F")
        divisionButton.backgroundColor = hexStringToUIColor(hex: "#F1C40F")
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

