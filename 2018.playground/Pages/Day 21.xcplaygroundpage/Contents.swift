//: [Previous](@previous)
import Foundation

let input = """
#ip 4
seti 123 0 3
bani 3 456 3
eqri 3 72 3
addr 3 4 4
seti 0 0 4
seti 0 5 3
bori 3 65536 5
seti 5557974 2 3
bani 5 255 2
addr 3 2 3
bani 3 16777215 3
muli 3 65899 3
bani 3 16777215 3
gtir 256 5 2
addr 2 4 4
addi 4 1 4
seti 27 9 4
seti 0 0 2
addi 2 1 1
muli 1 256 1
gtrr 1 5 1
addr 1 4 4
addi 4 1 4
seti 25 4 4
addi 2 1 2
seti 17 6 4
setr 2 2 5
seti 7 1 4
eqrr 3 0 2
addr 2 4 4
seti 5 7 4
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

let instructionPointerIndex = Int(parsedInput[0][1])!

let instructions = parsedInput.dropFirst().map { line in
    ParametrisedInstruction(
        instruction: Instruction(rawValue: line[0])!,
        a: Int(line[1])!,
        b: Int(line[2])!,
        c: Int(line[3])!
    )
}

func partOne() -> String {
    var registers = Array(repeating: 0, count: 6)
    
    var instructionPointerValue: Int {
        get { return registers[instructionPointerIndex] }
        set { registers[instructionPointerIndex] = newValue }
    }
    
    repeat {
        let instruction = instructions[instructionPointerValue]
        instruction.perform(on: &registers)
        
        if instructionPointerValue == 28 {
            return "\(registers[3])"
        }
        
        instructionPointerValue += 1
    } while true
    
    fatalError("This shouldn't happen")
}

func partTwo() -> String {
    var registers = Array(repeating: 0, count: 6)
    
    var instructionPointerValue: Int {
        get { return registers[instructionPointerIndex] }
        set { registers[instructionPointerIndex] = newValue }
    }
    
    var haltingValues = Set<Int>()
    var mostRecent = -1
    
    repeat {
        let instruction = instructions[instructionPointerValue]
        instruction.perform(on: &registers)
        
        if instructionPointerValue == 28 {
            let newHaltingValue = registers[3]
            
            guard haltingValues.contains(newHaltingValue) == false else {
                return "\(mostRecent)"
            }
            
            haltingValues.insert(newHaltingValue)
            mostRecent = newHaltingValue
        }
        
        instructionPointerValue += 1
    } while true
    
    fatalError("This shouldn't happen either")
}

print(partOne())
print(partTwo())

// The terminating condition is based on the last 3 lines alone.
// The programs goes out of bounds i.e. halts when r[0] == r[3].
//: [Next](@next)
