import Foundation

class Calculator {
    var currentInput = ""
    var infixNotation = [String]()
    
    func isPriorOperator(this first: String, to second: String) -> Bool {
        return "*/".contains(first) && "+-".contains(second)
    }
    
    func moveNonPriorOperator(from stack: Stack, to postfix: inout [String], than element: String) {
        while let top = stack.top(), !isPriorOperator(this: element, to: top) {
            guard let top = stack.pop() else {
                continue
            }
            postfix.append(top)
        }
    }

    func convertToPosfix() -> [String] {
        let tempStack = Stack()
        var postfix = [String]()

        for element in infixNotation {
            if let _ = Double(element) {
                postfix.append(element)
                continue
            }
            moveNonPriorOperator(from: tempStack, to: &postfix, than: element)
            tempStack.push(element: element)
        }
        while let top = tempStack.pop() {
            postfix.append(top)
        }
        return postfix
    }

    func calculatePosfix() -> String {
        let postfix = convertToPosfix()
        let tempStack = Stack()

        for element in postfix {
            if let _  = Double(element) {
                tempStack.push(element: element)
                continue
            }
            if let operand2 = Double(tempStack.pop()!), let operand1 = Double(tempStack.pop()!) {
                var result: Double?
                switch element {
                case "+":
                    result = operand1 + operand2
                case "-":
                    result = operand1 - operand2
                case "*":
                    result = operand1 * operand2
                case "/":
                    result = operand1 / operand2
                default:
                    break
                }
                tempStack.push(element: String(result!))
            }
        }
        return tempStack.pop()!
    }
}
