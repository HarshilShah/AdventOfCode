import Algorithms
import Foundation

struct Day1: Day {
	var input: String
	var totals: [Int]
	
	init(input: String) {
		self.input = input
		
		self.totals = input
			.components(separatedBy: "\n\n")
			.map { line in
				line
					.split(separator: "\n")
					.map { Int($0)! }
					.reduce(0, +)
			}
	}
	
	func partOne() -> String {
		totals
			.max()!
			.description
	}
	
	func partTwo() -> String {
		totals
			.max(count: 3)
			.reduce(0, +)
			.description
	}
}
