import Foundation
typealias UnitsDic = [String : Double] //하나의 단위범주 형태
//단위의 집합 구조체
struct Units {
    static let lengthDictionary : UnitsDic = ["cm" : 1, "m" : 100, "inch" : 2.54, "yard" : 91.44]
    static let weightDictionary : UnitsDic = ["g" : 1, "kg" : 1000, "oz" : 28.3495, "lb" : 453.592 ]
    static let volumeDictionary : UnitsDic = ["l" : 1, "pt" :0.473176, "qt" : 0.946353, "gal" : 3.78541]
    static let error : UnitsDic = ["error" : 0]
}
//입력받은 문자열을 배열로 분리하는 함수
func seperateInputstr (_ inputString : String) -> Array<String> {
    var seperatedInputArr = inputString.components(separatedBy: " ") //1. " "를 기준으로 분리
    if seperatedInputArr.count == 1{                                 //분리되지 않았을 경우, 그냥 return
        return seperatedInputArr
    }
    let tempArr = seperatedInputArr[1].components(separatedBy: ",")  //2. 1번에서 분리될 경우, outputUnit 부분을 ","기준으로 다시 분리
    if tempArr.count == 2 {                                 //2번에서 분리될 경우, 3개의 원소를 가진 배열로 분리
        seperatedInputArr[1] = tempArr[0]
        seperatedInputArr.append(tempArr[1])
    }
    return seperatedInputArr
}
//입력받은 숫자값을 from단위에서 to단위로 변환하는 함수
//입력 : 숫자값, from단위(inputUnit), to단위(outputUnit)
//출력 : 바뀐숫자값과 to단위를 포함한 문자열
func convertInputUnit (numVal : Double, fromUnit : (name : String?, category : UnitsDic), toUnit : (name : String?, category : UnitsDic)) -> String {
    var result : Double = 0.0                                                                  //*(단위범주)[단위이름] : 단위값
    result =  numVal * (fromUnit.category)[fromUnit.name!]! / (toUnit.category)[toUnit.name!]! //계산식 : 숫자 * from(inputUnit)단위값 / to(outputUnit)단위값
    return String(result) + toUnit.name! + " "
}
//단위를 찾는 함수(찾으면 해당 단위이름과 단위범주를 반환)
func searchUnit (_ inputString : String) -> (name : String?, category : UnitsDic){
    for key in Units.lengthDictionary.keys {
        if inputString.hasSuffix(key) {return (key, Units.lengthDictionary)}
    }
    for key in Units.weightDictionary.keys {
        if inputString.hasSuffix(key) {return (key, Units.weightDictionary)}
    }
    for key in Units.volumeDictionary.keys {
        if inputString.hasSuffix(key) {return (key, Units.volumeDictionary)}
    }
    return (nil, Units.error)
}
//입력받은 문자열(inputstring)에서 숫자만 남겨서 반환하는 함수
func sliceString (_ inputStr : String, _ unitName : String) -> Double {
    let numbers =  inputStr.components(separatedBy: "\(unitName)")
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
func printMessage () {
    print("==== 지원가능한 단위 ====")
    var lenghtUnit : String = "길이 : "
    var weightUnit : String = "무게 : "
    var volumeUnit : String = "부피 : "
    for key in Units.lengthDictionary.keys {
        lenghtUnit += "\(key)" + " "
    }
    for key in Units.weightDictionary.keys {
        weightUnit += "\(key)" + " "
    }
    for key in Units.volumeDictionary.keys {
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
func convertUnit (_ inputString : String) {
    let strArr = seperateInputstr(inputString)
    let inputUnit = searchUnit(strArr[0])
    if checkUnit(inputUnit.name) == false { //inputUnit이 지원하는 단위인지 아닌지 체크
        return
    }
    let inputNum = sliceString(strArr[0], inputUnit.name!)
    switch strArr.count {
    case 0,1: //inputUnit만 입력했을 경우 ex) "180cm"
        var resultArr : [String] = []
        for unit in inputUnit.category {
            if unit.key != inputUnit.name { //입력된 inputUnit을 제외한 같은 범주 내 모든 단위 출력
                resultArr.append(convertInputUnit(numVal : inputNum, fromUnit : inputUnit, toUnit : (unit.key, inputUnit.category)))
            }
        }
        printResult(resultArr[0],resultArr[1],resultArr[2])
        return
    case 2:  //inputUnit + ouputUnit을 입력했을 경우 ex) "180cm inch"
        let outputUnit = searchUnit(strArr[1])
        if checkUnit(outputUnit.name) == false {
            return
        }
        let resultNum = convertInputUnit(numVal : inputNum, fromUnit : inputUnit, toUnit : outputUnit)
        printResult(resultNum)
        return
    case 3: //inputUnit + outputUnit1,outputUnit2을 입력했을 경우 ex) "180cm inch,m"
        let outputUnit1 = searchUnit(strArr[1])
        let outputUnit2 = searchUnit(strArr[2])
        if checkUnit(outputUnit1.name) == false || checkUnit(outputUnit2.name) == false {
            return
        }
        let resultNum1 = convertInputUnit(numVal : inputNum, fromUnit : inputUnit, toUnit : outputUnit1)
        let resultNum2 = convertInputUnit(numVal : inputNum, fromUnit : inputUnit, toUnit : outputUnit2)
        printResult(resultNum1, resultNum2)
        return
    default:
        print("다시 입력해주세요.")
    }
}
var runConverter : Bool = true
mainLoop: while runConverter {
    printMessage()
    let inputstring = readLine()
    if inputstring == "q" || inputstring == "quit" {
        break;
    }
    if let input = inputstring {
        convertUnit(input)
    }
}
