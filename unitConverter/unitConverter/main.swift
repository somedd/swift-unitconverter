import Foundation
//기본단위
enum Baseunits : String {
    case cm
    case g
    case l
    case none
    }
//단위의 집합 구조체
struct units {
    static let lengthDic : [String : Double] = ["cm" : 1, "m" : 100, "inch" : 2.54, "yard" : 91.44]
    static let weightDic : [String : Double] = ["g" : 1, "kg" : 1000, "oz" : 28.3495, "lb" : 453.592 ]
    static let volumeDic : [String : Double] = ["l" : 1, "pt" :0.473176, "qt" : 0.946353, "gal" : 3.78541]
    static let error : [String : Double] = ["error" : 0]
}
//입력받은 문자열을 배열로 나누기
func inputstrToArr (_ string : String) -> Array<String> {
    let arrOfStr = string.components(separatedBy: " ")
    return arrOfStr
}
//계산하는 함수
func converter (_ inputnum : Double, _ inputunit : (String?,[String:Double]), _ outputunit :(String?,[String:Double]) ,_ isBase : Bool) -> Double {
    var result : Double = 0.0
    if isBase == true {
        result = inputnum / (outputunit.1)[outputunit.0!]!
    } else {
        result =  inputnum * (inputunit.1)[inputunit.0!]! / (outputunit.1)[outputunit.0!]!
    }
    return result
}
//단위를 찾는 함수
func searchUnit (_ inputString : String) -> (key : String?, unitDic : [String:Double]){
    for key in units.lengthDic.keys {
        if inputString.hasSuffix(key) {return (key, units.lengthDic)}
    }
    for key in units.weightDic.keys {
        if inputString.hasSuffix(key) {return (key, units.weightDic)}
    }
    for key in units.volumeDic.keys {
        if inputString.hasSuffix(key) {return (key, units.volumeDic)}
    }
    print("지원하지 않는 단위입니다.")
    return (nil, units.error)
}
//기본단위인지 확인하는 함수
func checkBase (_ unit : String) -> Bool {
    switch unit {
    case Baseunits.cm.rawValue:
        return true
    case Baseunits.g.rawValue :
        return true
    case Baseunits.l.rawValue :
        return true
    default:
        return false
    }
}
//숫자를 빼는 함수
func sliceString (_ str : String, _ unit : String) -> Double {
    let numbers =  str.components(separatedBy: "\(unit)")
    return Double(numbers[0]) ?? 0
}
func unitConverter (_ inputString : String) {
    let strArr = inputstrToArr(inputString)
    switch strArr.count {
    case 0:
        return
    case 1:
        return
    case 2:
        let inputUnit = searchUnit(strArr[0])
        let outputUnit = searchUnit(strArr[1])
        let inputNum = sliceString(strArr[0], inputUnit.key!)
        let chkBase = checkBase(inputUnit.key!)
        let resultNum = converter(inputNum, inputUnit, outputUnit, chkBase)
        print("\(resultNum)" + outputUnit.key!)
        return
    default:
        print("지원하지 않는 단위입니다.")
    }
}
var str = readLine()
unitConverter(str!)

