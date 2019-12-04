//: [Previous](@previous)

import Foundation

let input = "372304-847060"

let limits = input.split(separator: "-").map { Int($0)! }
let range = limits[0] ... limits[1]

func decimalComponents(from number: Int) -> [Int] {
    var number = number
    var array: [Int] = []
    array.reserveCapacity(6)
    while number != 0 {
        array.append(number % 10)
        number /= 10
    }
    return array.reversed()
}

func partOne() -> String {
    range
        .lazy
        .filter { number in
            let components = decimalComponents(from: number)
            
            guard components.sorted() == components else { return false }
            
            for pair in zip(components, components.dropFirst()) {
                if pair.0 == pair.1 {
                    return true
                }
            }
            
            return false
        }
        .count
        .description
}

func partTwo() -> String {
    range
        .lazy
        .filter { number in
            let components = decimalComponents(from: number)
            
            guard components.sorted() == components else { return false }
            
            var hasDoubleDuplicate = false
            var repeatCount = 0
            
            for pair in zip(components, components.dropFirst()) {
                if pair.0 == pair.1 {
                    repeatCount += 1
                } else {
                    if repeatCount == 1 {
                        hasDoubleDuplicate = true
                        break
                    }
                    repeatCount = 0
                }
            }
            
            if repeatCount == 1 { hasDoubleDuplicate = true }
            return hasDoubleDuplicate
        }
        .count
        .description
}

print(partOne())
print(partTwo())

//: [Next](@next)
