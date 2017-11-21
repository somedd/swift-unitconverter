import Foundation
import Swift
//길이 : cm(센치), m(미터), inch(인치), yard(야드)
func centiToMeter (centi : Double) -> Double {
    return centi * 0.01
}
func meterTocenti (m : Double) -> Double{
    return m * 100
}
func centiToInch (centi : Double)-> Double{
    return centi / 2.54
}
func inchToCenti (inch : Double) -> Double{
    return inch * 2.54
}
func centiToYard (centi : Double) -> Double {
    return centi * 0.010936
}
func yardToCenti (yard : Double) -> Double {
    return yard * 91.44
}
//무게 : kg(키로그램), g(그램), oz(오운스), lb(파운드),
func gramToKg (g : Double) -> Double{
    return g * 0.001
}
func kgToGram (kg : Double) -> Double {
    return kg * 1000
}
func ozToKg (oz : Double) -> Double {
    return oz * 0.0283495
}
func kgToOz (kg : Double) -> Double {
    return kg / 0.0283495
}
func lbToKg (lb : Double) -> Double {
    return lb * 0.453592
}
func kgToLb (kg : Double) -> Double {
    return kg / 0.453592
}
//부피 : l(리터), pt(파인트), qt(쿼터), gal(갤런)
func ptToL (pt : Double) -> Double {
    return pt * 0.473176
}
func lToPt (l : Double) -> Double {
    return l / 0.473176
}
func qtToL (qt : Double) -> Double {
    return qt * 0.946353
}
func lToQt (l : Double) -> Double {
    return l / 0.946353
}
func galToL (gal : Double) -> Double {
    return gal * 3.78541
}
func lToGal (l : Double) -> Double {
    return l / 3.78541
}
//입력받은 문자열에서 계산하려는 숫자만 분리
//입력 : 입력받은 문자열, 단위
//출력 : Double타입의 숫자
func sliceString (str : String, unit : String) -> Double {
    let numbers =  str.components(separatedBy: "\(unit)")
    return Double(numbers[0])!
}
//단위변환기
//입력 : 입력받은 문자열, 바꾸려는 단위
//출력 : 바뀐 숫자 + 바뀐 단위
func converter (input : String, output : String) {
    var inputValue : Double = 0.0
    var result : Double = 0.0
    if output.hasSuffix(length[0]) {           //output : cm
        if input.hasSuffix(length[1]) {        //m -> cm
            inputValue = sliceString(str: input, unit: length[1])
            result = meterTocenti(m: inputValue)
        } else if input.hasSuffix(length[2]) { //inch -> cm
            inputValue = sliceString(str: input, unit: length[2])
            result = inchToCenti(inch: inputValue)
        } else if input.hasSuffix(length[3]) { //yard -> cm
            inputValue = sliceString(str: input, unit: length[3])
            result = yardToCenti(yard: inputValue)
        }
    } else if output.hasSuffix(length[1]) { //output : m
        if input.hasSuffix(length[0]) { //cm -> m
            inputValue = sliceString(str: input, unit: length[0])
            result = centiToMeter(centi: inputValue)
        } else if input.hasSuffix(length[2]) { //inch -> centi -> m
            inputValue = sliceString(str: input, unit: length[2])
            result = centiToMeter(centi: inchToCenti(inch: inputValue))
        } else if input.hasSuffix(length[3]) { //yard -> cm -> m
            inputValue = sliceString(str: input, unit: length[3])
            result = centiToMeter(centi: yardToCenti(yard: inputValue))
        }
    } else if output.hasSuffix(length[2]) {
        if input.hasSuffix(length[0]) {
            inputValue = sliceString(str: input, unit: length[0])
            result = centiToInch(centi: inputValue)
        } else if input.hasSuffix(length[1]) {
            inputValue = sliceString(str: input, unit: length[1])
            result = centiToInch(centi: meterTocenti(m: inputValue))
        } else if input.hasSuffix(length[3]) { //yard -> centi -> inch
            inputValue = sliceString(str: input, unit: length[3])
            result = centiToInch(centi: yardToCenti(yard: inputValue))
        }
    }
    print(String(result) + output)
}
var length : Array = ["cm", "m", "inch", "yard"]
var weight : Array = ["kg","g","oz","lb"]
var volume : Array = ["l","pt","qt","gal"]
func unitCheck (value : Double, inputString : String, outputString : String) {
    switch outputString {
    case length[0]...length[3]: //length
        converter(input: inputString, output: outputString)
    case weight[0]...weight[3]:
        return
    case volume[0]...volume[3]:
        return
    default:
        print("지원하지 않는 단위입니다.")
    }
}
func unitChange (value : Double, inputUnit : String, outputUnit : String) {
    
}
var str  = readLine()
var arrOfstr = str!.components(separatedBy: " ")
var inputu = arrOfstr[0]
print(inputu)

//unitCheck(inputString : arrOfstr[0], outputString : arrOfstr[1])
//converter(input: arrOfstr[0], output: arrOfstr[1])

