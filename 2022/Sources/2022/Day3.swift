import Algorithms
import Collections
import Foundation

extension Character {
	var priority: Int {
		Int(asciiValue! - (isUppercase ? 38 : 96))
	}
}

struct Day3: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n")
			.map { priority(forRucksack: $0) }
			.reduce(0, +)
			.description
	}
	
	func priority(forRucksack rucksack: Substring) -> Int {
		let length = rucksack.count / 2
		let first = rucksack.prefix(length)
		let second = rucksack.suffix(length)
		let shared = Set(first).intersection(second)
		return shared.map(\.priority).reduce(0, +)
	}
	
	func partTwo() -> String {
		input
			.split(separator: "\n")
			.chunks(ofCount: 3)
			.map { badge(forRucksacks: $0) }
			.reduce(0, +)
			.description
	}
	
	func badge(forRucksacks rucksacks: some Collection<Substring>) -> Int {
		rucksacks
			.dropFirst()
			.reduce(into: Set(rucksacks.first!)) { chars, rucksack in
				chars.formIntersection(rucksack)
			}
			.map(\.priority)
			.reduce(0, +)
	}
}
