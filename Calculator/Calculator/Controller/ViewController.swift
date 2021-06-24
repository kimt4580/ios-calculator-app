//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayUserInputNumber: UILabel!
    
    private var userInput: Bool = false
    private var input = Infix()
    private var postfix = Postfix()
    private var calculator = Calculator()
    
    @IBAction func numberButtonDidTap(_ sender: UIButton) {
        if userInput {
            let currentDisplay = displayUserInputNumber.text!
            displayUserInputNumber.text = currentDisplay + sender.currentTitle!
        } else {
            displayUserInputNumber.text = sender.currentTitle!
        }
        userInput = true
    }
    
    @IBAction func operatorButtonDidTap(_ sender: UIButton) {
        input.infix.append(displayUserInputNumber.text!)
        input.infix.append(sender.currentTitle!)
        userInput = false
    }
    
    @IBAction func equalButtonDidTap(_ sender: UIButton) {
        input.infix.append(displayUserInputNumber.text!)
        print(input.infix)
        postfix.separateNumberAndOperator(from: input.infix)
        print(postfix.postfix)
        print(postfix.operatorsStack)
        print(calculator.calculatePostfix())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
