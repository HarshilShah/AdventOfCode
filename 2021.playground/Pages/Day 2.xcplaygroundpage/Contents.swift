//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

func partOne() -> String {
    var x = 0
    var y = 0

    input.split(separator: "\n").forEach { line in
        let operation = line.split(separator: " ").first
        let number = Int(line.split(separator: " ").last!)!
        
        switch operation {
        case "forward": x += number
        case "down": y += number
        case "up": y -= number
        default:
            print("UNEXPECTED LINE \(line)")
            fatalError()
        }
    }
    
    return (x * y).description
}

func partTwo() -> String {
    var aim = 0
    var x = 0
    var y = 0
    
    input.split(separator: "\n").forEach { line in
        let operation = line.split(separator: " ").first
        let number = Int(line.split(separator: " ").last!)!
        
        switch operation {
        case "forward":
            x += number
            y += aim * number
        case "down": aim += number
        case "up": aim -= number
        default:
            print("UNEXPECTED LINE \(line)")
            fatalError()
        }
    }
    
    return (x * y).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
