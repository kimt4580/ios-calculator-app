//
//  Calculator - CalculatorViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    private var calculatorItems = String.empty
    
    @IBOutlet weak var operandLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var calculatorItemsStackView: UIStackView!
    @IBOutlet weak var calculatorItemsScrollView: UIScrollView!
    
    private func addStackViewLabel() {
        let singleItem = UILabel()
        singleItem.font = UIFont.preferredFont(forTextStyle: .title3)
        singleItem.textColor = .white
        singleItem.adjustsFontSizeToFitWidth = true
        
        if operandLabel.text!.contains(String.decimalPoint) {
            while operandLabel.text!.hasSuffix(String.zero) || operandLabel.text!.hasSuffix(String.decimalPoint) {
                operandLabel.text!.removeLast()
            }
        }
        
        singleItem.text = "\(operatorLabel.text!)\(Character.whiteSpace)\(operandLabel.text!)"
        calculatorItemsStackView.addArrangedSubview(singleItem)
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        calculatorItemsScrollView.layoutIfNeeded()
        let bottomOffset = CGPoint(x: 0, y: calculatorItemsScrollView.contentSize.height - calculatorItemsScrollView.bounds.size.height + calculatorItemsScrollView.contentInset.bottom)
        if bottomOffset.y > 0 {
            calculatorItemsScrollView.setContentOffset(bottomOffset, animated: false)
        }
    }
    
    private func clearAllStackViewLabel() {
        let addedStackViewLabels = calculatorItemsStackView.arrangedSubviews
        
        addedStackViewLabels.forEach { subview in subview.removeFromSuperview() }
    }
    
    @IBAction func tappedResultButton(_ button: UIButton) {
        switch operatorLabel.text!.isEmpty {
        case true:
            return
        case false:
            appendCalculatorItem("\(operatorLabel.text!)")
            appendCalculatorItem("\(operandLabel.text!)")
            addStackViewLabel()
            resetOperatorLabelText()
            var parsedFormula = ExpressionParser.parse(from: calculatorItems)
            let result = parsedFormula.result()
            operandLabel.text = CalculatorSetting.formatNumber(result)
            resetCalculatorItems()
        }
    }
    
    @IBAction func tappedOperandButton(_ button: UIButton) {
        switch operandLabel.text! {
        case String.zero:
            operandLabel.text = String.empty
            operandLabel.text! = "\(operandLabel.text!)\(button.currentTitle!)"
        default:
            operandLabel.text! = "\(operandLabel.text!)\(button.currentTitle!)"
        }
    }
    
    @IBAction func tappedOperatorButton(_ button: UIButton) {
        switch operatorLabel.text!.isEmpty || operandLabel.text! != String.zero {
        case true:
            appendCalculatorItem("\(operatorLabel.text!)")
            appendCalculatorItem("\(operandLabel.text!)")
            addStackViewLabel()
            resetOperandLabelText()
            operatorLabel.text = button.currentTitle
        case false:
            operatorLabel.text = button.currentTitle
        }
    }
    
    @IBAction func tappedZeroButton(_ button: UIButton) {
        guard let operandLabelText = operandLabel.text,
              let buttonTitle = button.currentTitle,
              operandLabelText != String.zero else { return }
        
        operandLabel.text = "\(operandLabelText)\(buttonTitle)"
    }
    
    @IBAction func tappedDecimalPointButton(_ button: UIButton) {
        guard let operandLabelText = operandLabel.text,
              let buttonTitle = button.currentTitle,
              operandLabelText.notContains(String.decimalPoint) else { return }
        
        operandLabel.text = "\(operandLabelText)\(buttonTitle)"
    }
    
    @IBAction func tappedChangeSignButton(_ button: UIButton) {
        guard var operandLabelText = operandLabel.text,
              operandLabelText != String.zero else { return }
        
        guard operandLabelText.hasPrefix(String.negativeSign) else {
            operandLabel.text = "\(String.negativeSign)\(operandLabelText)"
            return
        }
        
        operandLabelText.removeFirst()
        operandLabel.text = operandLabelText
    }
    
    @IBAction func tappedAllClearButton(_ button: UIButton) {
        resetCalculatorItems()
        resetOperandLabelText()
        resetOperatorLabelText()
        clearAllStackViewLabel()
    }
    
    @IBAction func tappedClearEntryButton(_ button: UIButton) {
        resetOperandLabelText()
    }
    
    @IBAction func occurHapticFeedback() {
        CalculatorSetting.occurHapticFeedback()
    }
    
    private func appendCalculatorItem(_ item: String) {
        guard item.contains(String.decimalComma) else {
            calculatorItems = "\(calculatorItems)\(Character.whiteSpace)\(item)"
            return
        }

        let commaRemovedItem = item.components(separatedBy: String.decimalComma)
                                   .joined()
        calculatorItems = "\(calculatorItems)\(Character.whiteSpace)\(commaRemovedItem)"
    }
    
    private func resetCalculatorItems() {
        calculatorItems = String.empty
    }
    
    private func resetOperandLabelText() {
        operandLabel.text = String.zero
    }
    
    private func resetOperatorLabelText() {
        operatorLabel.text = String.empty
    }
}

