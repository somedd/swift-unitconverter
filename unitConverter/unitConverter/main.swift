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
func inputstrToArr (string : String) -> Array<String> {
    let arrOfStr = string.components(separatedBy: " ")
    return arrOfStr
}
//단위를 찾는 함수
func searchUnit (inputString : String) -> (key : String?, unitDic : String){
    for key in units.lengthDic.keys {
        if inputString.hasSuffix(key) {return (key, "lengthDic")}
    }
    for key in units.weightDic.keys {
        if inputString.hasSuffix(key) {return (key, "weightDic")}
    }
    for key in units.volumeDic.keys {
        if inputString.hasSuffix(key) {return (key, "volumeDic")}
    }
    return (nil, "")
}
//func checkBase (_ key : String,_ unitDic : String) -> (key : String, unitDic : String){
//    switch unitDic {
//    case "lengthDic": return key
//    case "weightDic": return key
//    case "volumeDic": return key
//    default : return
//    }
//}
//입력받은 문자열에서 계산하려는 숫자만 분리
func sliceString (str : String, unit : String) -> Double {
    let numbers =  str.components(separatedBy: "\(unit)")
    return Double(numbers[0])!
}
func unitConverter (inputString : String) {
    let strArr = inputstrToArr(string: inputString)
    switch strArr.count {
    case 0:
        return
    case 1:
        return
    case 2:
        let tempUnit = searchUnit(inputString: strArr[0])
        checkBase(tempUnit.key, tempUnit.unitDic)
    default:
        print("지원하지 않는 단위입니다.")
    }
}
var str = readLine()
unitConverter(inputString: str!)

