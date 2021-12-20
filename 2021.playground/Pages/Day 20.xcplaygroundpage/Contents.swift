//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension Sequence where Element == Bool {
	var int: Int {
		var result = 0
		for element in self {
			result *= 2
			result += element ? 1 : 0
		}
		return result
	}
}

extension Sequence {
	func min<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> T? {
		return self.min(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })?[keyPath: keyPath]
	}
	
	func max<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> T? {
		return self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })?[keyPath: keyPath]
	}
	
	func range<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> ClosedRange<T>? {
		guard let minimum = min(keyPath), let maximum = max(keyPath) else {
			return nil
		}
		
		return minimum...maximum
	}
}

struct Point: Hashable {
	var x: Int
	var y: Int
	
	var neighbours: [Point] {
		((y - 1)...(y + 1)).flatMap { y in
			((x - 1)...(x + 1)).map { x in
				Point(x: x, y: y)
			}
		}
	}
}

let algorithm = input.components(separatedBy: "\n\n").first!
	.enumerated()
	.reduce(into: Set<Int>()) { ones, tuple in
		let (index, character) = tuple
		if character == "#" { ones.insert(index) }
	}

let initialGrid = input.components(separatedBy: "\n\n").last!
	.split(separator: "\n")
	.enumerated()
	.reduce(into: [Point: Bool]()) { grid, tuple in
		let (y, line) = tuple
		line.enumerated().forEach { x, character in
			grid[Point(x: x, y: y)] = (character == "#")
		}
	}

func advance(_ grid: [Point: Bool], outsideGridValue: Bool) -> [Point: Bool] {
	var xRange = grid.keys.range(\.x)!
	var yRange = grid.keys.range(\.y)!
	
	xRange = xRange.lowerBound - 1 ... xRange.upperBound + 1
	yRange = yRange.lowerBound - 1 ... yRange.upperBound + 1
	
	var newGrid: [Point: Bool] = [:]
	
	for y in yRange {
		for x in xRange {
			let point = Point(x: x, y: y)
			let bits = point.neighbours.map { grid[$0] ?? outsideGridValue }
			let int = bits.int
			let newValue = algorithm.contains(int)
			newGrid[point] = newValue
		}
	}
	
	return newGrid
}

func partOne() -> String {
	var grid = initialGrid
	var outsideGridValue = false
	for _ in 1 ... 2 {
		grid = advance(grid, outsideGridValue: outsideGridValue)
		outsideGridValue = algorithm.contains(outsideGridValue ? 511 : 0)
	}
	return grid.values.lazy.filter({ $0 }).count.description
}

func partTwo() -> String {
	var grid = initialGrid
	var outsideGridValue = false
	for _ in 1 ... 50 {
		grid = advance(grid, outsideGridValue: outsideGridValue)
		outsideGridValue = algorithm.contains(outsideGridValue ? 511 : 0)
	}
	return grid.values.lazy.filter({ $0 }).count.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
