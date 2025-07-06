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

enum FlowItem {
    case digit(Digit)
    case operation(Operation)
    
    var displayValue: String {
        switch self {
        case let .digit(value):
            return value.displayValue
        case let .operation(value):
            return value.symbol
        }
    }
}

class Digit {
    private var isNegative = false
    private var values: String = "0"
    
    var displayValue: String {
        isNegative ? "(-\(values))" : values
    }
    
    init() {}
    
    func input(v: String) {
        if v == "," {
            handleDecimalPoint()
        } else if values == "0" {
            values = v
        } else {
            values += v
        }
    }
    
    func changeSign(to sign: Sign) {
        guard values != "0" else { return }
        isNegative = sign == .negative
    }
    
    func handleDecimalPoint() {
        if !values.contains(",") {
            values += ","
        }
    }
}

class Flow {
    private var digits: [FlowItem] = []
    private var isNegative = false
    
    var displayValue: String {
        if digits.isEmpty { return "0" }
        return digits.map { $0.displayValue }.joined()
    }
    
    init() {}
    
    func changeSign(to sign: Sign) {
        guard case let .digit(value) = digits.last else { return }
        if digits.count >= 2,
           case let .operation(op) = digits[digits.count - 2],
           op == .subtraction
        {
            digits[digits.count - 2] = .operation(.addition)
        } else {
            value.changeSign(to: sign)
        }
    }
    
    func input(_ operation: Operation) {
        digits.append(.operation(operation))
    }
   
    func input(_ digit: String) {
        if case let .digit(val) = digits.last {
            val.input(v: digit)
            return
        }
        let d = Digit()
        d.input(v: digit)
        digits.append(
            .digit(d)
        )
    }
    
    func clear() {
        digits = []
    }
}

private extension Flow {
    
    
}
