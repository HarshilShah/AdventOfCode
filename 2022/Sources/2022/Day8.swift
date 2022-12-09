import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	func scenicScore(height: Int, in grid: [Point: Int], xSize: Int, ySize: Int) -> Int {
		if x == 0 || y == 0 || y == ySize - 1 || x == xSize - 1 {
			return 0
		}
		
		func visibility(for points: some Collection<Point>) -> Int {
			var visibility = 0
			for point in points {
				visibility += 1
				if grid[point]! >= height {
					return visibility
				}
			}
			return visibility
		}
		
		let left = visibility(for: (0 ..< x).reversed().map { Point(x: $0, y: y) })
		let right = visibility(for: (x + 1 ..< xSize).map { Point(x: $0, y: y) })
		let up = visibility(for: (0 ..< y).reversed().map { Point(x: x, y: $0) })
		let down = visibility(for: (y + 1 ..< ySize).map { Point(x: x, y: $0) })
		return left * right * up * down
	}
	
	func isVisible(height: Int, in grid: [Point: Int], xSize: Int, ySize: Int) -> Bool {
		if x == 0 || y == 0 || y == ySize - 1 || x == xSize - 1 {
			return true
		}
		
		if (0 ..< x).allSatisfy({ grid[Point(x: $0, y: y)]! < height }) {
			return true
		}
		
		if (x + 1 ..< xSize).allSatisfy({ grid[Point(x: $0, y: y)]! < height }) {
			return true
		}
		
		if (0 ..< y).allSatisfy({ grid[Point(x: x, y: $0)]! < height }) {
			return true
		}
		
		if (y + 1 ..< ySize).allSatisfy({ grid[Point(x: x, y: $0)]! < height }) {
			return true
		}
		
		return false
	}
}

struct Day8: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let ySize = input.split(separator: "\n").count
		let xSize = input.split(separator: "\n").first!.count
		
		let trees = input
			.split(separator: "\n")
			.enumerated()
			.reduce(into: [Point: Int]()) { dict, tuple in
				let (y, line) = tuple
				line.enumerated().forEach { x, c in
					dict[Point(x: x, y: y)] = c.wholeNumberValue!
				}
			}
		
		return trees
			.lazy
			.filter { point, height in
				point.isVisible(height: height, in: trees, xSize: xSize, ySize: ySize)
			}
			.count
			.description
	}
	
	func partTwo() -> String {
		let ySize = input.split(separator: "\n").count
		let xSize = input.split(separator: "\n").first!.count
		
		let trees = input
			.split(separator: "\n")
			.enumerated()
			.reduce(into: [Point: Int]()) { dict, tuple in
				let (y, line) = tuple
				line.enumerated().forEach { x, c in
					dict[Point(x: x, y: y)] = c.wholeNumberValue!
				}
			}
		return trees
			.lazy
			.map { point, height in
				point.scenicScore(height: height, in: trees, xSize: xSize, ySize: ySize)
			}
			.max()!
			.description
	}
}
