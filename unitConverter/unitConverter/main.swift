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
    var arrOfStr = string.components(separatedBy: " ")
    switch arrOfStr.count {
    case 1: //inputUnit만 입력했을 경우
        return arrOfStr
    default:
        let tempArr = arrOfStr[1].components(separatedBy: ",")// 출력단위에 ","가 포함되어 있을 경우
        if tempArr.count == 2 {
            arrOfStr[1] = tempArr[0]
            arrOfStr.append(tempArr[1])
        }
    return arrOfStr
    }
}
//계산하는 함수
func calculNum (_ inputnum : Double, _ inputunit : (String?,[String:Double]), _ outputunit :(String?,[String:Double]) ,_ isBase : Bool) -> Double {
    var result : Double = 0.0
    if isBase == true { //기본단위일 경우
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
    let inputUnit = searchUnit(strArr[0])
    let inputNum = sliceString(strArr[0], inputUnit.key!)
    let chkBase = checkBase(inputUnit.key!)
    switch strArr.count {
    case 0...1:
        if inputUnit.key == nil {
            print("지원하지 않는 단위가 포함되어 있습니다. 다시 입력해주세요.")
            return
        }
        var resultStr : String = ""
        for unit in inputUnit.unitDic {
            if unit.key != inputUnit.key {
                resultStr += String(calculNum(inputNum, inputUnit, (unit.key, inputUnit.unitDic) , chkBase)) + unit.key + " "
            }
        }
        print(resultStr)
        return
    case 2:
        let outputUnit = searchUnit(strArr[1])
        if inputUnit.key == nil || outputUnit.key == nil {
            print("지원하지 않는 단위가 포함되어 있습니다. 다시 입력해주세요.")
            return
        }
        let resultNum = calculNum(inputNum, inputUnit, outputUnit, chkBase)
        print("\(resultNum)" + outputUnit.key!)
        return
    case 3:
        let outputUnit1 = searchUnit(strArr[1])
        let outputUnit2 = searchUnit(strArr[2])
        if inputUnit.key == nil || outputUnit1.key == nil || outputUnit2.key == nil{
            print("지원하지 않는 단위가 포함되어 있습니다. 다시 입력해주세요.")
            return
        }
        var resultNum : String = ""
        resultNum = String(calculNum(inputNum, inputUnit, outputUnit1, chkBase)) + outputUnit1.key! + " " +
                    String(calculNum(inputNum, inputUnit, outputUnit2, chkBase)) + outputUnit2.key!
        print(resultNum)
        return
    default:
        print("다시 입력해주세요.")
    }
}

var boolVal : Bool = true
mainLoop: while boolVal {
    let inputStr = readLine()
    if inputStr == "q" || inputStr == "quit" {
        break;
    }
    unitConverter(inputStr!)
}
/* 추가로 구현 or 수정할 것들
 1. q or quit을 입력하면 종료 / ok
 2. 지원하지 않는단위를 받을경우 "지원하지 않는 단위입니다." 출력 / ok
 3. 옵셔널 처리할것들 처리
 4. ex) 182cm를 입력하면, m, inch, yard를 모두 출력 (case 1) /ok
 5. ex) 182cm m,inch 를 입력하면, m, inch를 출력 / ok
 옵셔널 처리를 어케해야되는지 헷갈림.
*/
