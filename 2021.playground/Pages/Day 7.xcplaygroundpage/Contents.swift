//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

let positions = input.split(separator: ",").map { Int($0)! }

func partOne() -> String {
	func cost(finalPosition: Int) -> Int {
		positions
			.map { abs($0 - finalPosition) }
			.reduce(0, +)
	}
	
	let range = positions.min()! ... positions.max()!
	return range.lazy
		.map(cost(finalPosition:))
		.min()!
		.description
}

func partTwo() -> String {
	func cost(finalPosition: Int) -> Int {
		positions
			.map { abs($0 - finalPosition) }
			.map { (1...$0).reduce(0, +) }
			.reduce(0, +)
	}
	
	let range = positions.min()! ... positions.max()!
	return range.lazy
		.map(cost(finalPosition:))
		.min()!
		.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
