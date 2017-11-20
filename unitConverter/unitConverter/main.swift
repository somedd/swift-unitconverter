import Foundation

func centiToMeter (centi : Double) -> Double {
    return centi * 0.01
}
func meterTocenti (m : Double) -> Int{
    return Int(m * 100)
}
func centiToInch (centi : Double) {
    print("\(centi / 2.54)inch")
}
func inchToCenti (inch : Double) {
    print("\(inch * 2.54)cm")
}
func sliceString (str : String, unit : String) -> Double {
    let numbers =  str.components(separatedBy: "\(unit)")
    return Double(numbers[0])!
}

func converter (input : String, output : String) {
    if output.hasSuffix("cm") {
        if input.hasSuffix("m") {
            print(String(meterTocenti(m: sliceString(str: input, unit: "m"))) + "cm")
        }
        else if input.hasSuffix("inch") {
            inchToCenti(inch: sliceString(str: input, unit: "inch"))
        }
    }
    else if output.hasSuffix("m") {
        if input.hasSuffix("cm") {
            print(String(centiToMeter(centi: sliceString(str: input, unit: "cm"))) + "m")
        }
        else if input.hasSuffix("inch") {
            //inch -> centi -> meter
        }
    }
    else if output.hasSuffix("inch") {
        if input.hasSuffix("cm") {
            //cm -> inch
        }
        else if input.hasSuffix("m") {
            //m -> inch
        }
    }
}


var str  = readLine()
let arrOfstr = str!.components(separatedBy: " ")
converter(input: arrOfstr[0], output: arrOfstr[1])

