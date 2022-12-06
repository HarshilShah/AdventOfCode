import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Day6: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		findMarker(ofSize: 4)
			.description
	}
	
	func partTwo() -> String {
		findMarker(ofSize: 14)
			.description
	}
	
	func findMarker(ofSize windowSize: Int) -> Int {
		Array(input)
			.indexed()
			.windows(ofCount: windowSize)
			.first(where: { Set($0.map(\.element)).count == windowSize })!
			.last!
			.index + 1 // + 1 because the input isn't zero indexed
	}
}
