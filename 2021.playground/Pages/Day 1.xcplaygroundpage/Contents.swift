import Foundation

let input = """
<Insert your input here>
"""

let numbers = input.split(separator: "\n").map { Int($0)! }

func partOne() -> String {
    zip(numbers, numbers.dropFirst())
        .lazy
        .filter { $0 < $1 }
        .count
        .description
}

func partTwo() -> String {
    zip(numbers, numbers.dropFirst(3))
        .lazy
        .filter { $0 < $1 }
        .count
        .description
}

print(partOne())
print(partTwo())
