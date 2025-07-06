import Testing
@testable import CalculatorEngine

@Suite("Flow basic operations")
struct FlowTest {
    let sut = Flow()
    @Test func initialDisplayValue_isZero() async throws {
        #expect(sut.displayValue == "0")
    }
    
    @Test func singleDigitInput_updatesDisplayValue() async throws {
        sut.input("1")
        #expect(sut.displayValue == "1")
    }
    
    @Test func multipleDigitInput_appendsToDisplayValue() async throws {
        sut.input("1")
        sut.input("2")
        sut.input("0")
        #expect(sut.displayValue == "120")
    }
    
    @Test func clear_resetsDisplayValueToZero() async throws {
        sut.input("1")
        sut.input("2")
        sut.clear()
        #expect(sut.displayValue == "0")
    }
    
    @Test func negativeSignInput_addsNegativeSignToZero() async throws {
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "0")
    }
    
    @Test func negativeSignWithDigit_setsNegativeValue() {
        sut.input("4")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-4)")
    }
    
    @Test func negativeSignWithZero_setsZero() {
        sut.changeSign(to: .negative)
        sut.input("0")
        #expect(sut.displayValue == "0")
    }
    
    @Test func positiveSignWithDigit_setsPositiveValue() async throws {
        sut.input("5")
        sut.changeSign(to: .positive)
        #expect(sut.displayValue == "5")
    }
    
    @Test func switchFromNegativeToPositiveSign() async throws {
        sut.input("5")
        sut.changeSign(to: .negative)
        sut.changeSign(to: .positive)
        #expect(sut.displayValue == "5")
    }
    
    @Test func inputCommaAfterZero() async throws {
        sut.input(",")
        #expect(sut.displayValue == "0,")
    }
    
    @Test func inputDigitAfterZeroWithComma_createsFractionalDisplayValue() async throws {
        sut.input("0")
        sut.input(",")
        sut.input("2")
        #expect(sut.displayValue == "0,2")
    }
    
    @Test func inputDigitAfterCommaDigit_createsFractionalDisplayValue() async throws {
        sut.input("1")
        sut.input(",")
        sut.input("2")
        #expect(sut.displayValue == "1,2")
    }
    
    @Test func switchFromPositiveToNegative_addsNegativeSign() async throws {
        sut.input("5")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-5)")
    }
    
    @Test func addMultipleCommas_doesNotChangeValue() async throws {
        sut.input("1")
        sut.input(",")
        sut.input("2")
        sut.input(",")
        #expect(sut.displayValue == "1,2")
    }
    
    @Test func negativeZeroWithComma() async throws {
        sut.input(",")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-0,)")
    }
    
    @Test func negativeDigitWithComma() async throws {
        sut.input("5")
        sut.input(",")
        sut.input(",")
        sut.input("8")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-5,8)")
    }
    
    @Test func negativeDigitWithCommaToPositive() async throws {
        sut.input("5")
        sut.input(",")
        sut.input(",")
        sut.input("8")
        sut.changeSign(to: .negative)
        sut.changeSign(to: .positive)
        #expect(sut.displayValue == "5,8")
    }
    
    @Test func zeroAfterComma_keepsValueZero() async throws {
        sut.input("0")
        sut.input(",")
        sut.input("0")
        #expect(sut.displayValue == "0,0")
    }
    
    @Test func inputAddition_addsPlusSign() async throws {
        sut.input("0")
        sut.input(.addition)
        sut.input("5")
        #expect(sut.displayValue == "0+5")
    }
    
    @Test func inputSubtraction_addsMinusSign() async throws {
        sut.input("9")
        sut.input(.subtraction)
        sut.input("5")
        #expect(sut.displayValue == "9-5")
    }
    
    @Test func inputMultiplication_addsTimesSign() async throws {
        sut.input("9")
        sut.input(.multiplication)
        sut.input("5")
        #expect(sut.displayValue == "9×5")
    }
    
    @Test func inputDivision_addsDividedBySign() async throws {
        sut.input("9")
        sut.input(.division)
        sut.input("5")
        #expect(sut.displayValue == "9÷5")
    }
    
    @Test func inputAddition_ofNegativeNumbers_keepsSign() {
        sut.input("5")
        sut.changeSign(to: .negative)
        sut.input(.addition)
        sut.input("6")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-5)+(-6)")
    }
    
    @Test func subtractionOfNegativeNumber_transformsToAdditionToPositiveNumber() async throws {
        sut.input("5")
        sut.input(.subtraction)
        sut.input("7")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "5+7")
    }
    
    @Test func multiplyNegativeNumbers() async throws {
        sut.input("5")
        sut.changeSign(to: .negative)
        sut.input(.multiplication)
        sut.input("7")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-5)×(-7)")
    }
    
    @Test func negativeDecimalNumber() async throws {
        sut.input("5")
        sut.input(",")
        sut.input("7")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-5,7)")
    }
    
    @Test func negativeDecimalNumberWithZero() async throws {
        sut.input("0")
        sut.input(",")
        sut.input("7")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-0,7)")
    }
    
    @Test func subtractionOfTwoNegativeDecimalNumber_transformsToAdditionToPositive() async throws {
        sut.input("0")
        sut.input(",")
        sut.input("7")
        sut.changeSign(to: .negative)
        sut.input(.subtraction)
        sut.input("0")
        sut.input(",")
        sut.input("7")
        sut.changeSign(to: .negative)
        #expect(sut.displayValue == "(-0,7)+0,7")
    }
}
