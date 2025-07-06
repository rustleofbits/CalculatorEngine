// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

enum Sign {
    case positive, negative
}

enum Operation {
    case addition, subtraction, multiplication, division
    
    var symbol: String {
        switch self {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "×"
        case .division: return "÷"
        }
    }
}

struct Digit {
    private var isNegative = false
    private var value = "0"
}

class Flow {
    private var digits = "0"
    private var isNegative = false
    
    var displayValue: String {
        isNegative ? "(-\(digits))" : digits
    }
    
    init() {}
    
    func changeSign(to sign: Sign) {
        guard digits != "0" else { return }
        isNegative = sign == .negative
    }
    
    func input(_ operation: Operation) {
        digits += operation.symbol
    }
   
    func input(_ digit: String) {
        if digit == "," {
            handleDecimalPoint()
        } else if digits == "0" {
            digits = digit
        } else {
            digits += digit
        }
    }
    
    func clear() {
        digits = "0"
        isNegative = false
    }
}

private extension Flow {
    
    func handleDecimalPoint() {
        if !digits.contains(",") {
            digits += ","
        }
    }
}
