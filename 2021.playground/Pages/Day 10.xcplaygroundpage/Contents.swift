//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

var opening: Set<Character> = ["(", "{", "[", "<"]
var dual: [Character: Character] = [
	"(": ")",
	"[": "]",
	"{": "}",
	"<": ">"
]

func partOne() -> String {
	let errorScore: [Character: Int] = [
		")": 3,
		"]": 57,
		"}": 1197,
		">": 25137
	]

	return input
		.split(separator: "\n")
		.map { line in
			var stack: [Character] = []
			
			for char in line {
				if opening.contains(char) {
					stack.append(char)
				} else {
					if dual[stack.removeLast()]! != char {
						return errorScore[char]!
					}
				}
			}
			
			return 0
		}
		.reduce(0, +)
		.description
}

func partTwo() -> String {
	let fixScore: [Character: Int] = [
		")": 1,
		"]": 2,
		"}": 3,
		">": 4
	]

	let scores = input
		.split(separator: "\n")
		.compactMap { line -> Int? in
			var stack: [Character] = []
			
			for char in line {
				if opening.contains(char) {
					stack.append(char)
				} else {
					if dual[stack.removeLast()]! != char {
						return nil
					}
				}
			}
			
			return stack
				.reversed()
				.lazy
				.map { dual[$0]! }
				.map { fixScore[$0]! }
				.reduce(0, { $0 * 5 + $1 })
		}
		.sorted()
	
	let middle = scores.count / 2
	return scores[middle].description
}

print(partOne())
print(partTwo())

//: [Next](@next)
