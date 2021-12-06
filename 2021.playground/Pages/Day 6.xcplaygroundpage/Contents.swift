//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

let fishes = input.split(separator: ",").map { Int($0)! }

var childrenAtAgeZeroForDay: [Int: Int] = [:]

func children(age: Int, in days: Int) -> Int {
	guard days > age else { return 1 }
	guard age == 0 else { return children(age: 0, in: days - age) }
	
	if let existing = childrenAtAgeZeroForDay[days] { return existing }
	let count = children(age: 7, in: days) + children(age: 9, in: days)
	childrenAtAgeZeroForDay[days] = count
	return count
}

func partOne() -> String {
	fishes
		.lazy
		.map { children(age: $0, in: 80) }
		.reduce(0, +)
		.description
}

func partTwo() -> String {
	fishes
		.lazy
		.map { children(age: $0, in: 256) }
		.reduce(0, +)
		.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
