//: [Previous](@previous)

import Foundation

let input = """
3,8,1001,8,10,8,105,1,0,0,21,38,59,84,93,110,191,272,353,434,99999,3,9,101,5,9,9,1002,9,5,9,101,5,9,9,4,9,99,3,9,1001,9,3,9,1002,9,2,9,101,4,9,9,1002,9,4,9,4,9,99,3,9,102,5,9,9,1001,9,4,9,1002,9,2,9,1001,9,5,9,102,4,9,9,4,9,99,3,9,1002,9,2,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99
"""

extension Int {
    var decimalComponents: [Int] {
        String(self).map { $0.wholeNumberValue! }
    }
}

extension Array {
    var permutations: [[Element]] {
        guard count > 0 else {
            return [[]]
        }
        
        return indices
            .flatMap { index -> [[Element]] in
                let first = self[index]
                var rest = self
                rest.remove(at: index)
                return rest.permutations.map { [first] + $0 }
            }
    }
}

enum Operation { case read, write }

class Amp {
    
    var numbers: [Int]
    var phase: Int
    
    var currentPosition = 0
    var output: Int!
    
    var isPhaseUsed = false
    var hasFinished = false
    
    init(numbers: [Int], phase: Int) {
        self.numbers = numbers
        self.phase = phase
    }
    
    func execute(withInput input: Int) -> Int {
        
        guard hasFinished == false else { return output }
        
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
                numbers[pZero] = isPhaseUsed ? input : phase
                isPhaseUsed = true
                currentPosition += 2
                
            case 4:
                let pZero = parameter(atIndex: 0, operation: .write)
                output = numbers[pZero]
                currentPosition += 2
                return output
                
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
                
            case 99: hasFinished = true; return output
            default: fatalError("Unexpected opCode")
            }
        }
    }
}

let initialNumbers = input
    .split(separator: ",")
    .map { Int($0)! }

func partOne() -> String {
    Array(0...4)
        .permutations
        .map { phases -> Int in
            let op1 = Amp(numbers: initialNumbers, phase: phases[0]).execute(withInput: 0)
            let op2 = Amp(numbers: initialNumbers, phase: phases[1]).execute(withInput: op1)
            let op3 = Amp(numbers: initialNumbers, phase: phases[2]).execute(withInput: op2)
            let op4 = Amp(numbers: initialNumbers, phase: phases[3]).execute(withInput: op3)
            return Amp(numbers: initialNumbers, phase: phases[4]).execute(withInput: op4)
        }
        .max()!
        .description
}

func partTwo() -> String {
    Array(5...9)
        .permutations
        .map { phases -> Int in
            let engines = phases.map { Amp(numbers: initialNumbers, phase: $0) }
            var output: Int!
            
            var isFirstInput = true
            
            while engines[4].hasFinished == false {
                let op1 = engines[0].execute(withInput: isFirstInput ? 0 : output)
                let op2 = engines[1].execute(withInput: op1)
                let op3 = engines[2].execute(withInput: op2)
                let op4 = engines[3].execute(withInput: op3)
                output = engines[4].execute(withInput: op4)
                isFirstInput = false
            }
            
            return output
        }
        .max()!
        .description
}

print(partOne())
print(partTwo())

//: [Next](@next)
