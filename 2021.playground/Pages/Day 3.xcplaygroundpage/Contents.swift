//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension Sequence where Element == Bool {
    var decimal: Int {
        var value = 0
        for b in self {
            value *= 2
            if b { value += 1 }
        }
        return value
    }
}

let bitLists = input
    .split(separator: "\n")
    .map { line in
        line.map { $0.wholeNumberValue == 1 }
    }

func partOne() -> String {
    var counts: [Int: (zero: Int, one: Int)] = [:]
    bitLists.forEach { bits in
        bits.enumerated().forEach { index, bit in
            if bit {
                counts[index, default: (zero: 0, one: 0)].one += 1
            } else {
                counts[index, default: (zero: 0, one: 0)].zero += 1
            }
        }
    }
    
    var gamma: [Bool] = []
    var epsilon: [Bool] = []
    for (_, value) in counts.sorted(by: { $0.key < $1.key }) {
        gamma.append(value.zero < value.one)
        epsilon.append(value.zero > value.one)
    }
    
    return (gamma.decimal * epsilon.decimal).description
}

func partTwo() -> String {
    var o2Lists = bitLists
    var index = 0
    while o2Lists.count != 1 {
        let counts = o2Lists.reduce(into: (zeroes: 0, ones: 0)) { counts, bits in
            if bits[index] {
                counts.ones += 1
            } else {
                counts.zeroes += 1
            }
        }
        
        o2Lists.removeAll { list in
            let mostCommon: Bool = {
                if counts.zeroes == counts.ones {
                    return true
                } else {
                    return counts.ones > counts.zeroes
                }
            }()
            return list[index] != mostCommon
        }
        index += 1
    }
    
    let o2 = o2Lists[0].decimal
    
    var co2Lists = bitLists
    index = 0
    while co2Lists.count != 1 {
        let counts = co2Lists.reduce(into: (zeroes: 0, ones: 0)) { counts, bits in
            if bits[index] {
                counts.ones += 1
            } else {
                counts.zeroes += 1
            }
        }
        
        co2Lists.removeAll { list in
            let leastCommon: Bool = {
                if counts.zeroes == counts.ones {
                    return false
                } else {
                    return counts.zeroes > counts.ones
                }
            }()
            return list[index] != leastCommon
        }
        index += 1
    }
    let co2 = co2Lists[0].decimal
    
    return (o2 * co2).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
