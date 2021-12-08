//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

func partOne() -> String {
	let uniques: Set<Int> = [2, 3, 4, 7]
	return input
		.split(separator: "\n")
		.map { line in
			line.split(separator: "|")[1]
				.dropFirst()
				.split(separator: " ")
				.lazy
				.map(\.count)
				.filter(uniques.contains)
				.count
		}
		.reduce(0, +)
		.description
}

func partTwo() -> String {
	enum Segment: String, Hashable {
		case a, b, c, d, e, f, g
	}
	
	let segmentsAndDisplays = input
		.split(separator: "\n")
		.map { line -> ([Set<Character>], [Set<Character>]) in
			let components = line.split(separator: "|")
			let segments = components[0].dropLast().split(separator: " ").map { Set($0) }
			let displays = components[1].dropFirst().split(separator: " ").map { Set($0) }
			return (segments, displays)
		}
	
	return segmentsAndDisplays
		.lazy
		.map { segments, displays in
			let one = segments.first(where: { $0.count == 2 })!
			let four = segments.first(where: { $0.count == 4 })!
			let seven = segments.first(where: { $0.count == 3 })!
			let eight = segments.first(where: { $0.count == 7 })!
			
			let bd = four.subtracting(one)
			let five = segments.first(where: { $0.count == 5 && $0.isSuperset(of: bd) })!
			let three = segments.first(where: { $0.count == 5 && $0.isSuperset(of: one) })!
			let two = segments.first(where: { $0.count == 5 && $0 != five && $0 != three })!
			
			let abcdf = seven.union(four)
			let nine = segments.first(where: { $0.count == 6 && $0.intersection(abcdf).count == 5 })!
			
			let c = nine.subtracting(five)
			let six = segments.first(where: { $0.count == 6 && $0.isDisjoint(with: c) })!
			let zero = segments.first(where: { $0.count == 6 && $0 != six && $0 != nine })!
			
			let values = [
				zero: 0,
				one: 1,
				two: 2,
				three: 3,
				four: 4,
				five: 5,
				six: 6,
				seven: 7,
				eight: 8,
				nine: 9
			]
			
			return displays
				.map { values[$0]! }
				.reduce(into: 0) { $0 *= 10; $0 += $1 }
		}
		.reduce(0, +)
		.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
