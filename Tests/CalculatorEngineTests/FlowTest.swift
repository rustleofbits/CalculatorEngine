import Testing
import XCTest
@testable import CalculatorEngine

class FlowTest: XCTestCase {
    func test_initialDisplayValue_isZero() {
        let sut = Flow()
        XCTAssertEqual(sut.displayValue, "0")
    }
    
    func test_singleDigitInput_updatesDisplayValue() {
        let sut = Flow()
        sut.input("1")
        XCTAssertEqual(sut.displayValue, "1")
    }
    
    func test_multipleDigitInput_appendsToDisplayValue() {
        let sut = Flow()
        sut.input("1")
        sut.input("2")
        sut.input("0")
        XCTAssertEqual(sut.displayValue, "120")
    }
    
    func test_clear_resetsDisplayValueToZero() {
        let sut = Flow()
        sut.input("4")
        sut.input("3")
        sut.clear()
        XCTAssertEqual(sut.displayValue, "0")
    }
    
    func test_negativeSignInput_addsNegativeSignToZero() {
        let sut = Flow()
        sut.changeSign(to: .negative)
        XCTAssertEqual(sut.displayValue, "0")
    }
    
    func test_negativeSignWithDigit_setsNegativeValue() {
        let sut = Flow()
        sut.input("4")
        sut.changeSign(to: .negative)
        XCTAssertEqual(sut.displayValue, "(-4)")
    }
    
    func test_negativeSignWithZero_setsNegativeZero() {
        let sut = Flow()
        sut.changeSign(to: .negative)
        sut.input("0")
        XCTAssertEqual(sut.displayValue, "0")
    }
    
    func test_positiveSignWithDigit_setsPositiveValue() {
        let sut = Flow()
        sut.changeSign(to: .positive)
        sut.input("5")
        XCTAssertEqual(sut.displayValue, "5")
    }
    
    func test_setPositiveSign_toNegativeValue_removesNegativeSign() {
        let sut = Flow()
        sut.input("5")
        sut.changeSign(to: .negative)
        sut.changeSign(to: .positive)
        XCTAssertEqual(sut.displayValue, "5")
    }
    
    func test_inputCommaAfterZero() {
        let sut = Flow()
        sut.input(",")
        XCTAssertEqual(sut.displayValue, "0,")
    }
    
    func test_inputDigitAfterZeroWithComma_createsFractionalDisplayValue() {
        let sut = Flow()
        sut.input("0")
        sut.input(",")
        sut.input("2")
        XCTAssertEqual(sut.displayValue, "0,2")
    }
    
    func test_inputDigitAfterCommaDigit_createsFractionalDisplayValue() {
        let sut = Flow()
        sut.input("1")
        sut.input(",")
        sut.input("2")
        XCTAssertEqual(sut.displayValue, "1,2")
    }
    
    func test_switchFromPositiveToNegative_addsNegativeSign() {
        let sut = Flow()
        sut.input("5")
        sut.changeSign(to: .negative)
        XCTAssertEqual(sut.displayValue, "(-5)")
    }
    
    func test_addMultipleCommas_doesNotChangeValue() {
        let sut = Flow()
        sut.input("1")
        sut.input(",")
        sut.input("2")
        sut.input(",")
        XCTAssertEqual(sut.displayValue, "1,2")
    }
    
    func test_negativeZeroWithComma() {
        let sut = Flow()
        sut.input(",")
        sut.changeSign(to: .negative)
        XCTAssertEqual(sut.displayValue, "(-0,)")
    }
    
    func test_negativeDigitWithComma() {
        let sut = Flow()
        sut.input("5")
        sut.input(",")
        sut.input(",")
        sut.input("8")
        sut.changeSign(to: .negative)
        XCTAssertEqual(sut.displayValue, "(-5,8)")
    }
    
    func test_negativeDigitWithCommaToPositive() {
        let sut = Flow()
        sut.input("5")
        sut.input(",")
        sut.input(",")
        sut.input("8")
        sut.changeSign(to: .negative)
        sut.changeSign(to: .positive)
        XCTAssertEqual(sut.displayValue, "5,8")
    }
    
    func test_zeroAfterComma_keepsValueZero() {
        let sut = Flow()
        sut.input("0")
        sut.input(",")
        sut.input("0")
        XCTAssertEqual(sut.displayValue, "0,0")
    }
    
    func test_inputAddition_addsPlusSign() {
        let sut = Flow()
        sut.input("0")
        sut.input(.addition)
        sut.input("5")
        XCTAssertEqual(sut.displayValue, "0+5")
    }
    
    func test_inputSubtraction_addsMinusSign() {
        let sut = Flow()
        sut.input("9")
        sut.input(.subtraction)
        sut.input("5")
        XCTAssertEqual(sut.displayValue, "9-5")
    }
    
    func test_inputMultiplication_addsTimesSign() {
        let sut = Flow()
        sut.input("9")
        sut.input(.multiplication)
        sut.input("5")
        XCTAssertEqual(sut.displayValue, "9×5")
    }
    
    func test_inputDivision_addsDividedBySign() {
        let sut = Flow()
        sut.input("9")
        sut.input(.division)
        sut.input("5")
        XCTAssertEqual(sut.displayValue, "9÷5")
    }
    
//    func test_inputAddition_ofNegativeNumbers_keepsSign() {
//        let sut = Flow()
//        sut.input("5")
//        sut.changeSign(to: .negative)
//        sut.input(.addition)
//        sut.input("6")
//        sut.changeSign(to: .negative)
//        print("!!! ", sut.displayValue)
//        XCTAssertEqual(sut.displayValue, "(-5)+(-6)")
//    }
}
