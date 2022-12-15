import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate extension StringProtocol {
	var integers: [Int] {
		return self
			.split{ "-0123456789".contains($0) == false }
			.map { Int($0)! }
	}
}

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	func manhattanDistance(to other: Point) -> Int {
		abs(x - other.x) + abs(y - other.y)
	}
}

extension ClosedRange<Int> {
	func clamped(to other: ClosedRange) -> ClosedRange? {
		guard overlaps(other) else { return nil }
		return Swift.max(lowerBound, other.lowerBound) ... Swift.min(upperBound, other.upperBound)
	}
	
	func union(with other: ClosedRange<Int>) -> ClosedRange<Int>? {
		if self.overlaps(other) || self.upperBound == other.lowerBound - 1 || self.lowerBound == other.upperBound + 1 {
			return Swift.min(lowerBound, other.lowerBound) ... Swift.max(upperBound, other.upperBound)
		}
		return nil
	}
}

extension Set where Element == ClosedRange<Int> {
	func fused() -> Self {
		for e1 in self {
			for e2 in self {
				if e1 == e2 { continue }
				if let union = e1.union(with: e2) {
					var copy = self
					copy.remove(e1)
					copy.remove(e2)
					copy.insert(union)
					return copy.fused()
				}
			}
		}
		
		return self
	}
}

struct Day15: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let pairings = input
			.split(separator: "\n")
			.map(\.integers)
			.map { ints in
				(Point(x: ints[0], y: ints[1]), Point(x: ints[2], y: ints[3]))
			}
		
		let manhattanDistances = pairings
			.reduce(into: [Point: Int]()) { dict, tuple in
				let (sensor, beacon) = tuple
				dict[sensor] = sensor.manhattanDistance(to: beacon)
			}
		
		let y = 2000000
		let xRanges = Set(
			manhattanDistances
				.compactMap { sensor, max -> ClosedRange<Int>? in
					let xRange = max - abs(sensor.y - y)
					guard xRange > 0 else { return nil }
					return sensor.x - xRange ... sensor.x + xRange
				}
		)
		
		let fusedRanges = xRanges.fused()
		return fusedRanges
			.map(\.count)
			.reduce(0, +)
			.description
	}
	
	func partTwo() -> String {
		let pairings = input
			.split(separator: "\n")
			.map(\.integers)
			.map { ints in
				(Point(x: ints[0], y: ints[1]), Point(x: ints[2], y: ints[3]))
			}
		
		let manhattanDistances = pairings
			.reduce(into: [Point: Int]()) { dict, tuple in
				let (sensor, beacon) = tuple
				dict[sensor] = sensor.manhattanDistance(to: beacon)
			}
		
		let limit = 0 ... 4000000
		
		for y in limit {
			let xRanges = Set(
				manhattanDistances
					.compactMap { sensor, max -> ClosedRange<Int>? in
						let xRange = max - abs(sensor.y - y)
						guard xRange > 0 else { return nil }
						return sensor.x - xRange ... sensor.x + xRange
					}
					.compactMap { $0.clamped(to: limit) }
			)
			
			let fusedRanges = xRanges.fused()
			
			guard fusedRanges != [limit] else { continue }
			
			let x = fusedRanges.map(\.upperBound).sorted().first! + 1
			print(x, y)
			let result = x * 4000000 + y
			return result.description
		}
		
		fatalError("Unexpected input")
	}
}
