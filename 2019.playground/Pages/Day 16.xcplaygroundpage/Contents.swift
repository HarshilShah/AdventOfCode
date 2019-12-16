//: [Previous](@previous)

import Foundation

let input = """
59740570066545297251154825435366340213217767560317431249230856126186684853914890740372813900333546650470120212696679073532070321905251098818938842748495771795700430939051767095353191994848143745556802800558539768000823464027739836197374419471170658410058272015907933865039230664448382679990256536462904281204159189130560932257840180904440715926277456416159792346144565015659158009309198333360851441615766440174908079262585930515201551023564548297813812053697661866316093326224437533276374827798775284521047531812721015476676752881281681617831848489744836944748112121951295833143568224473778646284752636203058705797036682752546769318376384677548240590
"""

extension Int {
    var decimalComponents: [Int] {
        String(self).compactMap { $0.wholeNumberValue }
    }
}


func partOne() -> String {
    func phase(forIndex index: Int, offset: Int) -> Int {
        let basePhase = [0, 1, 0, -1]
        let adjustedIndex = ((offset + 1) % ((index + 1) * 4)) / (index + 1)
        return basePhase[adjustedIndex]
    }
    
    var signal = input.map { $0.wholeNumberValue! }
    
    for _ in 1 ... 100 {
        signal = signal
            .indices
            .map { index -> Int in
                signal
                    .enumerated()
                    .lazy
                    .map { $0.element * phase(forIndex: index, offset: $0.offset) }
                    .reduce(0, +)
                    .decimalComponents
                    .last!
            }
    }
    
    return signal[0 ..< 8]
        .map { $0.description }
        .joined()
}

func partTwo() ->String {
    let parsedInput = input.map { $0.wholeNumberValue! }
    let offset = parsedInput[0 ..< 7].reduce(0) { $0 * 10 + $1 }
    
    var signal = Array(
        (1...10_000)
            .lazy
            .flatMap { _ in parsedInput }
            .dropFirst(offset)
    )
    
    for _ in 1 ... 100 {
        var sum = signal.reduce(0, +) % 10
        
        signal = signal
            .map { digit -> Int in
                defer {
                    sum -= digit
                    sum += 10
                    sum %= 10
                }
                return sum
            }
    }
    
    return signal[0 ..< 8]
        .map { $0.description }
        .joined()
}

print(partOne())
print(partTwo())

//: [Next](@next)
