//: [Previous](@previous)

import Foundation

let input = "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,6,23,2,13,23,27,1,27,13,31,1,9,31,35,1,35,9,39,1,39,5,43,2,6,43,47,1,47,6,51,2,51,9,55,2,55,13,59,1,59,6,63,1,10,63,67,2,67,9,71,2,6,71,75,1,75,5,79,2,79,10,83,1,5,83,87,2,9,87,91,1,5,91,95,2,13,95,99,1,99,10,103,1,103,2,107,1,107,6,0,99,2,14,0,0"

let initialNumbers = input
    .split(separator: ",")
    .map { Int($0)! }

func execute(_ numbers: inout [Int]) {
    var currentPosition = 0
    
    while true {
        let opCode = numbers[currentPosition]
        let pOne = numbers[currentPosition + 1]
        let pTwo = numbers[currentPosition + 2]
        let pThree = numbers[currentPosition + 3]
        
        switch opCode {
        case 1: numbers[pThree] = numbers[pOne] + numbers[pTwo]
        case 2: numbers[pThree] = numbers[pOne] * numbers[pTwo]
        case 99: return
        default: fatalError("Unexpected opCode")
        }
        
        currentPosition += 4
    }
}

func partOne() -> String {
    var numbers = initialNumbers
    numbers[1] = 12
    numbers[2] = 2
    execute(&numbers)
    return "\(numbers[0])"
}

func partTwo() -> String {
    let expectedResult = 19690720
    var noun = 0
    var verb = 0

    while true {
        var numbers = initialNumbers
        numbers[1] = noun
        numbers[2] = verb
        execute(&numbers)
        
        if numbers[0] == expectedResult {
            return "\((noun * 100) + verb)"
        } else {
            if verb == 99 {
                verb = 0
                noun += 1
            } else {
                verb += 1
            }
        }
    }

}

print(partOne())
print(partTwo())

//: [Next](@next)
