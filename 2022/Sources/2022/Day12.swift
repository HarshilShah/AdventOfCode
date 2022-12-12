import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	func neighbours() -> [Point] {
		return [
			Point(x: x + 1, y: y),
			Point(x: x - 1, y: y),
			Point(x: x, y: y + 1),
			Point(x: x, y: y - 1),
		]
	}
}

struct Day12: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let (grid, start, end) = parseGrid()
		return findPathLength(from: start, to: { $0 == end }, movingUpwards: true, in: grid).description
	}
	
	func partTwo() -> String {
		let (grid, start, end) = parseGrid()
		return findPathLength(from: end, to: { grid[$0] == grid[start] }, movingUpwards: false, in: grid).description
	}
	
	fileprivate func parseGrid() -> ([Point: Int], S: Point, E: Point) {
		var start: Point!
		var end: Point!
		var grid: [Point: Int] = [:]
		
		input
			.split(separator: "\n")
			.indexed()
			.forEach { tuple in
				let (y, line) = tuple
				line.enumerated().forEach { x, char in
					let point = Point(x: x, y: y)
					if char.isLowercase {
						grid[point] = Int(char.asciiValue!)
					} else if char == "S" {
						grid[point] = Int(Character("a").asciiValue!)
						start = point
					} else if char == "E" {
						grid[point] = Int(Character("z").asciiValue!)
						end = point
					} else {
						fatalError("Unexpected input")
					}
				}
			}
		
		return (grid, start, end)
	}
	
	fileprivate func findPathLength(
		from start: Point,
		to finishingCondition: (Point) -> Bool,
		movingUpwards: Bool,
		in grid: [Point: Int]
	) -> Int {
		var positions: [Int: Set<Point>] = [0: [start]]
		var visited: Set<Point> = []
		
		while let score = positions.keys.min() {
			let position = positions[score, default: []].removeFirst()
			
			if positions[score]!.isEmpty {
				positions.removeValue(forKey: score)
			}
			
			for next in position.neighbours() {
				if visited.contains(next) { continue }
				if grid[next] == nil { continue }
				
				let heightDifference = grid[next]! - grid[position]!
				
				if movingUpwards {
					if heightDifference > 1 { continue }
				} else {
					if heightDifference < -1 { continue }
				}
				
				visited.insert(next)
				
				positions[score + 1, default: []].insert(next)
				
				if finishingCondition(next) {
					return score + 1
				}
			}
		}
		
		return -1
	}
}
