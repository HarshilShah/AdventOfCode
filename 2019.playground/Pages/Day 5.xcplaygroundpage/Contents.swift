//: [Previous](@previous)

import Foundation

let input = """
3,225,1,225,6,6,1100,1,238,225,104,0,1102,88,66,225,101,8,125,224,101,-88,224,224,4,224,1002,223,8,223,101,2,224,224,1,224,223,223,1101,87,23,225,1102,17,10,224,101,-170,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1101,9,65,225,1101,57,74,225,1101,66,73,225,1101,22,37,224,101,-59,224,224,4,224,102,8,223,223,1001,224,1,224,1,223,224,223,1102,79,64,225,1001,130,82,224,101,-113,224,224,4,224,102,8,223,223,1001,224,7,224,1,223,224,223,1102,80,17,225,1101,32,31,225,1,65,40,224,1001,224,-32,224,4,224,102,8,223,223,1001,224,4,224,1,224,223,223,2,99,69,224,1001,224,-4503,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,1002,14,92,224,1001,224,-6072,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,102,33,74,224,1001,224,-2409,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,107,677,677,224,1002,223,2,223,1006,224,329,101,1,223,223,108,677,677,224,1002,223,2,223,1005,224,344,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,359,101,1,223,223,1107,226,677,224,1002,223,2,223,1006,224,374,1001,223,1,223,8,677,226,224,1002,223,2,223,1006,224,389,101,1,223,223,1108,677,677,224,1002,223,2,223,1005,224,404,1001,223,1,223,7,226,226,224,1002,223,2,223,1006,224,419,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,434,101,1,223,223,107,226,226,224,102,2,223,223,1005,224,449,101,1,223,223,107,677,226,224,1002,223,2,223,1006,224,464,1001,223,1,223,8,226,677,224,102,2,223,223,1006,224,479,1001,223,1,223,108,677,226,224,102,2,223,223,1005,224,494,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,509,1001,223,1,223,1107,677,226,224,1002,223,2,223,1005,224,524,101,1,223,223,1008,226,226,224,1002,223,2,223,1006,224,539,101,1,223,223,1008,226,677,224,1002,223,2,223,1005,224,554,1001,223,1,223,7,226,677,224,1002,223,2,223,1005,224,569,101,1,223,223,1007,677,226,224,1002,223,2,223,1006,224,584,1001,223,1,223,7,677,226,224,102,2,223,223,1006,224,599,101,1,223,223,1007,226,226,224,102,2,223,223,1006,224,614,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,629,101,1,223,223,108,226,226,224,102,2,223,223,1006,224,644,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,659,101,1,223,223,8,226,226,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226
"""

extension Int {
    var decimalComponents: [Int] {
        String(self).map { $0.wholeNumberValue! }
    }
}

enum Operation { case read, write }

func execute(_ numbers: [Int], input: Int) -> Int {
    var numbers = numbers
    var currentPosition = 0
    var output: Int!
    
    while true {
        let opCodeComponents = numbers[currentPosition].decimalComponents
        let opCode = ((opCodeComponents.dropLast().last ?? 0) * 10) + opCodeComponents.last!
        
        func parameter(atIndex index: Int, operation: Operation = .read) -> Int {
            let rawPosition = currentPosition + 1 + index
            
            switch operation {
            case .read: return opCodeComponents.dropLast(2 + index).last == 1
                ? numbers[rawPosition]
                : numbers[numbers[rawPosition]]
            case .write: return numbers[rawPosition]
            }
        }
        
        switch opCode {
        case 1:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            let pTwo = parameter(atIndex: 2, operation: .write)
            numbers[pTwo] = pZero + pOne
            currentPosition += 4
            
        case 2:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            let pTwo = parameter(atIndex: 2, operation: .write)
            numbers[pTwo] = pZero * pOne
            currentPosition += 4
            
        case 3:
            let pZero = parameter(atIndex: 0, operation: .write)
            numbers[pZero] = input
            currentPosition += 2
            
        case 4:
            let pZero = parameter(atIndex: 0, operation: .write)
            output = numbers[pZero]
            currentPosition += 2
            
        case 5:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            
            if pZero != 0 {
                currentPosition = pOne
            } else {
                currentPosition += 3
            }
            
        case 6:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            
            if pZero == 0 {
                currentPosition = pOne
            } else {
                currentPosition += 3
            }
            
        case 7:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            let pTwo = parameter(atIndex: 2, operation: .write)
            numbers[pTwo] = pZero < pOne ? 1 : 0
            currentPosition += 4
            
        case 8:
            let pZero = parameter(atIndex: 0)
            let pOne = parameter(atIndex: 1)
            let pTwo = parameter(atIndex: 2, operation: .write)
            numbers[pTwo] = pZero == pOne ? 1 : 0
            currentPosition += 4
            
        case 99: return output
        default: fatalError("Unexpected opCode")
        }
    }
}

let initialNumbers = input
    .split(separator: ",")
    .map { Int($0)! }

func partOne() -> String {
    execute(initialNumbers, input: 1).description
}

func partTwo() -> String {
    execute(initialNumbers, input: 5).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
