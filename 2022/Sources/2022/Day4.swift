import Algorithms
import Collections
import Foundation

extension ClosedRange {
	func contains(_ other: ClosedRange) -> Bool {
		other.clamped(to: self) == other
	}
}

struct Day4: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n")
			.lazy
			.map(parse)
			.filter { $0.0.contains($0.1) || $0.1.contains($0.0) }
			.count
			.description
	}
	
	func partTwo() -> String {
		input
			.split(separator: "\n")
			.lazy
			.map(parse)
			.filter { $0.0.overlaps($0.1) }
			.count
			.description
	}
	
	func parse(_ line: Substring) -> (ClosedRange<Int>, ClosedRange<Int>) {
		let numbers = line.split(whereSeparator: { $0.isNumber == false }).map { Int($0)! }
		return (numbers[0] ... numbers[1], numbers[2] ... numbers[3])
	}
}
