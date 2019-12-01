//: [Previous](@previous)
import Foundation

let input = """
#ip 3
addi 3 16 3
seti 1 8 4
seti 1 4 5
mulr 4 5 1
eqrr 1 2 1
addr 1 3 3
addi 3 1 3
addr 4 0 0
addi 5 1 5
gtrr 5 2 1
addr 3 1 3
seti 2 1 3
addi 4 1 4
gtrr 4 2 1
addr 1 3 3
seti 1 3 3
mulr 3 3 3
addi 2 2 2
mulr 2 2 2
mulr 3 2 2
muli 2 11 2
addi 1 3 1
mulr 1 3 1
addi 1 17 1
addr 2 1 2
addr 3 0 3
seti 0 3 3
setr 3 0 1
mulr 1 3 1
addr 3 1 1
mulr 3 1 1
muli 1 14 1
mulr 1 3 1
addr 2 1 2
seti 0 8 0
seti 0 9 3
"""

extension String {
    var integers: [Int] {
        return self
            .split{ "-0123456789".contains($0) == false }
            .map { Int($0)! }
    }
}

enum Instruction: String, RawRepresentable, CaseIterable {
    case addr, addi
    case mulr, muli
    case banr, bani
    case borr, bori
    case setr, seti
    case gtir, gtri, gtrr
    case eqir, eqri, eqrr
    
    func perform(on registers: inout [Int], a: Int, b: Int, c: Int) {
        let value: Int = {
            switch self {
            case .addr: return registers[a] + registers[b]
            case .addi: return registers[a] + b
            case .mulr: return registers[a] * registers[b]
            case .muli: return registers[a] * b
            case .banr: return registers[a] & registers[b]
            case .bani: return registers[a] & b
            case .borr: return registers[a] | registers[b]
            case .bori: return registers[a] | b
            case .setr: return registers[a]
            case .seti: return a
            case .gtir: return a > registers[b] ? 1 : 0
            case .gtri: return registers[a] > b ? 1 : 0
            case .gtrr: return registers[a] > registers[b] ? 1 : 0
            case .eqir: return a == registers[b] ? 1 : 0
            case .eqri: return registers[a] == b ? 1 : 0
            case .eqrr: return registers[a] == registers[b] ? 1 : 0
            }
        }()
        
        registers[c] = value
    }
}

struct ParametrisedInstruction {
    let instruction: Instruction
    let a: Int
    let b: Int
    let c: Int
    
    func perform(on registers: inout [Int]) {
        instruction.perform(on: &registers, a: a, b: b, c: c)
    }
}

let parsedInput = input
    .components(separatedBy: .newlines)
    .map { $0.components(separatedBy: .whitespaces) }

func partOne() -> String {
    var registers = Array(repeating: 0, count: 6)
    
    let instructions = parsedInput.dropFirst().map { line in
        ParametrisedInstruction(
            instruction: Instruction(rawValue: line[0])!,
            a: Int(line[1])!,
            b: Int(line[2])!,
            c: Int(line[3])!
        )
    }
    
    let instructionPointerIndex = Int(parsedInput[0][1])!
    var instructionPointerValue: Int {
        get { return registers[instructionPointerIndex] }
        set { registers[instructionPointerIndex] = newValue }
    }
    
    repeat {
        let instruction = instructions[instructionPointerValue]
        instruction.perform(on: &registers)
        instructionPointerValue += 1
    } while instructions.indices.contains(instructionPointerValue)

    let result = "\(registers[0])"
    return result
}

func partTwo() -> String {
    let r2 = 10551319
    let squareRoot = Int(Double(r2).squareRoot())
    let factors = (1 ... squareRoot).filter { r2 % $0 == 0 }
    let result = factors
        .flatMap { [$0, r2/$0] }
        .reduce(0, +)
    return "\(result)"
}

print(partOne())
print(partTwo())

// # Part 2 program flow:
//
// r = [1, 0, 0, 0, 0, 0]
// ic = r[3] = 0
// lineZero()
//
// lineZero {
//   r[2] = 2
//   r[2] = 4
//   r[2] = 76
//   r[2] = 836
//   r[1] = 3
//   r[1] = 66
//   r[1] = 83
//   r[2] = 919
//   r[1] = 27
//   r[1] = 756
//   r[1] = 785
//   r[1] = 23550
//   r[1] = 329700
//   r[1] = 10550400 // only really as a buffer for comparisons
//   r[2] = 10551319 // r[2] doesn't change after this
//   r[0] = 0
//
//   // r = [0, 10550400, 10551319, 0, 0, 0]
//
//   lineOne()
// }
//
// lineOne {
//   r[4] = 1 // reset r[4]
//   lineTwo()
// }
//
// lineTwo {
//   r[5] = 1 // reset r[5]
//   lineThree()
// }
//
// lineThree {
//   r[1] = r[4] * r[5]
//   r[1] = r[1] == r[2] ? 1 : 0
//
//   if r[1] == 1 { // r[4] * r[5] == r[2] i.e. if r[4] is a factor of r[2]
//     lineSeven()
//   } else {
//     lineEight()
//   }
// }
//
// lineSeven {
//   r[0] += r[4] // add factor of r[2] to r[0] i.e. our result
//   lineEight()
// }
//
// lineEight {
//   r[5] += 1 // increment r[5]
//   r[1] = r[5] > r[2] ? 1 : 0
//
//   if r[1] == 1 { // r[5] > r[2] i.e. if r[5] has overshot r[2]
//     lineTwelve()
//   } else {
//     lineThree()
//   }
// }
//
// lineTwelve {
//   r[4] += 1 // increment r[4]
//   r[1] = r[4] > r[2] ? 1 : 0
//
//   if r[1] == 1 { // r[4] > r[2] i.e. if r[4] has overshot r[2]
//     finished()
//   } else {
//     lineTwo()
//   }
// }
//: [Next](@next)
