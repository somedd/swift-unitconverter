import Foundation
import Swift
//길이 : cm(센치), m(미터), inch(인치), yard(야드)
func centiToMeter (centi : Double) -> Double {
    return centi * 0.01
}
func meterTocenti (m : Double) -> Int{
    return Int(m * 100)
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
func lengthConvert (input : String, unit : String ) {
    var temp = sliceString(str: input, unit: unit)
    
}
func converter (input : String, output : String) {
    if output.hasSuffix("cm") {
        if input.hasSuffix("m") {
            print(String(meterTocenti(m: sliceString(str: input, unit: "m"))) + output)
        } else if input.hasSuffix("inch") {
            print(String(inchToCenti(inch: sliceString(str: input, unit: "inch"))) + output)
        } else if input.hasSuffix("yard") {
            
        }
    } else if output.hasSuffix("m") {
        if input.hasSuffix("cm") {
            print(String(centiToMeter(centi: sliceString(str: input, unit: "cm"))) + output)
        } else if input.hasSuffix("inch") {
            print(String(centiToMeter(centi : inchToCenti(inch: sliceString(str: input, unit:"inch")))) + output)
        }
    } else if output.hasSuffix("inch") {
        if input.hasSuffix("cm") {
            print(String(centiToInch(centi: sliceString(str: input, unit: "cm"))) + output)
        } else if input.hasSuffix("m") {
            print(String(centiToInch(centi: Double(meterTocenti(m: sliceString(str: input, unit: "m"))))) + output)
        }
    }
}
var length : Array = ["cm", "m", "inch", "yard"]
var weight : Array = ["kg","g","oz","lb"]
var volume : Array = ["l","pt","qt","gal"]
func unitCheck (input : String, output : String) {
    switch output {
    case length[0]...length[3]: //length
        if output == length[0] { //output : cm
           //m or inch or yard -> cm
            //input : 입력받은 값, length
        }  else if output == length[1] { //output : m
           
        }  else if output == length[2] { //output : inch
            
        }  else if output == length[3] { //output : yard
            
        }
    case weight[0]...weight[3]:
        return
    case volume[0]...volume[3]:
        return
    default:
        print("지원하지 않는 단위입니다.")
    }
}
var str  = readLine()
let arrOfstr = str!.components(separatedBy: " ")
unitCheck(input : arrOfstr[0], output: arrOfstr[1])
converter(input: arrOfstr[0], output: arrOfstr[1])

