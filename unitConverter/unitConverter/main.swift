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
    if arrOfStr.count == 1{
        return arrOfStr
    }
    let tempArr = arrOfStr[1].components(separatedBy: ",")// 출력단위에 ","가 포함되어 있을 경우
    if tempArr.count == 2 {
        arrOfStr[1] = tempArr[0]
        arrOfStr.append(tempArr[1])
    }
    return arrOfStr
}
//계산하는 함수
func calculNum (_ inputnum : Double, _ inputunit : (String?,[String:Double]), _ outputunit :(String?,[String:Double])) -> String {
    var result : Double = 0.0
        result =  inputnum * (inputunit.1)[inputunit.0!]! / (outputunit.1)[outputunit.0!]!
    return String(result) + outputunit.0! + " "
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
//inputstring에서 숫자를 리턴하는 함수
func sliceString (_ str : String, _ unit : String) -> Double {
    let numbers =  str.components(separatedBy: "\(unit)")
    return Double(numbers[0]) ?? 0
}
//지원하는 단위인지 확인하는 함수
func checkUnit (_ str : String?) -> Bool {
    if str == nil {
        print("지원하지 않는 단위가 포함되어 있습니다. 다시 입력해주세요.")
        return false
    }
    return true
}
//안내문 출력 함수
func printMsg () {
    print("==== 지원가능한 단위 ====")
    var lenghtUnit : String = "길이 : "
    var weightUnit : String = "무게 : "
    var volumeUnit : String = "부피 : "
    for key in units.lengthDic.keys {
        lenghtUnit += "\(key)" + " "
    }
    for key in units.weightDic.keys {
        weightUnit += "\(key)" + " "
    }
    for key in units.volumeDic.keys {
        volumeUnit += "\(key)" + " "
    }
    print(lenghtUnit + "\n" + weightUnit + "\n" + volumeUnit)
    print("=====================")
}
//결과값을 출력해주는 함수
func printResult (_ input : String...) {
    var resultStr : String = "반환값 : "
    for str in input {
        resultStr += "\(str)" + " "
    }
    print(resultStr)
}
//단위변환 함수
func unitConverter (_ inputString : String) {
    let strArr = inputstrToArr(inputString)
    let inputUnit = searchUnit(strArr[0])
    if checkUnit(inputUnit.key) == false { //inputUnit이 지원하는 단위인지 아닌지 체크
        return
    }
    let inputNum = sliceString(strArr[0], inputUnit.key!)
    switch strArr.count {
    case 0...1: //inputUnit만 입력했을 경우 ex) "180cm"
        var resultArr : [String] = []
        for unit in inputUnit.unitDic {
            if unit.key != inputUnit.key { //입력된 inputUnit을 제외한 같은 범주 내 모든 단위 출력
                resultArr.append(calculNum(inputNum, inputUnit, (unit.key, inputUnit.unitDic)))
            }
        }
        printResult(resultArr[0],resultArr[1],resultArr[2])
        return
    case 2:  //inputUnit + ouputUnit을 입력했을 경우 ex) "180cm inch"
        let outputUnit = searchUnit(strArr[1])
        if checkUnit(outputUnit.key) == false {
            return
        }
        let resultNum = calculNum(inputNum, inputUnit, outputUnit)
        printResult(resultNum)
        return
    case 3: //inputUnit + outputUnit1,outputUnit2을 입력했을 경우 ex) "180cm inch,m"
        let outputUnit1 = searchUnit(strArr[1])
        let outputUnit2 = searchUnit(strArr[2])
        if checkUnit(outputUnit1.key) == false || checkUnit(outputUnit2.key) == false {
            return
        }
        let resultNum1 = calculNum(inputNum, inputUnit, outputUnit1)
        let resultNum2 = calculNum(inputNum, inputUnit, outputUnit2)
        printResult(resultNum1, resultNum2)
        return
    default:
        print("다시 입력해주세요.")
    }
}
var boolVal : Bool = true
mainLoop: while boolVal {
    printMsg()
    let inputStr = readLine()
    if inputStr == "q" || inputStr == "quit" {
        break;
    }
    unitConverter(inputStr!)
}
