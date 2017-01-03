//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Brett Foreman on 1/1/17.
//  Copyright © 2017 Brett Foreman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel! // outputLabel outlet... allows actions to be taken on it...
    
    var buttonSound: AVAudioPlayer! // bittpm sound variable

    enum Operation: String { // these are the various operations
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
        
    }
    
    var currentOperation = Operation.Empty // these are the initial settings of the formula(s)
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    
//////////
//This is what shows everytime the screen is loaded...
//////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        }   catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
}
    
//////////
// Functions on the button sound
//////////
    @IBAction func numberPressed(sender: UIButton) {
        playSound() // this should be here because it's calling the below function...
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber // this has to do with adding the numbers together, regardless of how many digits..
    }
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }

//////////
// Functions on the operators
//////////
    @IBAction func onDividePressed(sender:AnyObject) {
        processOpration(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender:AnyObject) {
        processOpration(operation: .Multiply)

    }
    @IBAction func onAddPressed(sender:AnyObject) {
        processOpration(operation: .Add)

    }
    @IBAction func onSubtractPressed(sender:AnyObject) {
        processOpration(operation: .Subtract)

    }
    @IBAction func onEqualsButtonPressed(sender:AnyObject) {
        processOpration(operation: currentOperation)
    }
    
//////////
// Here's the clear button at work
//////////
    @IBAction func onClearButtonPressed(sender: UIButton) {
        playSound()
        
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
        
       // you may only want to set currOper and runnintNum to "0" instead because the process operation below is handy in deciphering what we find by setting "" for all other variables...
    }


    
//////////
// These are the operation processes
//////////
    func processOpration(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            // a user selected an operator but then selected another operator without first entering a number
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"

                }
                    leftValStr = result
                    outputLbl.text = result
                
            }
                    currentOperation = operation

        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}








