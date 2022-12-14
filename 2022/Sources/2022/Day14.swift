import Algorithms
import Collections
import Foundation
import RegexBuilder

extension StringProtocol {
	var integers: [Int] {
		return self
			.split{ "0123456789".contains($0) == false }
			.map { Int($0)! }
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

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
}

fileprivate enum Tile: Hashable {
	case rock
	case sand
	
	var description: String {
		switch self {
		case .rock: return "#"
		case .sand: return "o"
		}
	}
}

struct Day14: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		var grid = parseGrid()
		let yRange = grid.keys.range(\.y)!
		
		var count = 0
		while let sand = sandPosition(in: grid, limit: yRange.upperBound + 2) {
			if sand.y == yRange.upperBound + 2 {
				break
			}
			
			grid[sand] = .sand
			count += 1
		}
		
		return count.description
	}
	
	func partTwo() -> String {
		var grid = parseGrid()
		let xRange = grid.keys.range(\.x)!
		let yRange = grid.keys.range(\.y)!
		
		(xRange.lowerBound - 100000 ..< xRange.upperBound + 100000).forEach {
			grid[Point(x: $0, y: yRange.upperBound + 2)] = .rock
		}
		
		var count = 0
		while let sand = sandPosition(in: grid, limit: yRange.upperBound + 3) {
			grid[sand] = .sand
			count += 1
			
			if sand.y == 0 {
				break
			}
		}

		return count.description
	}
	
	fileprivate func parseGrid() -> [Point: Tile] {
		input
			.split(separator: "\n")
			.reduce(into: [Point: Tile]()) { grid, line in
				let points = line.integers
					.chunks(ofCount: 2)
					.map { Point(x: $0.first!, y: $0.dropFirst().first!) }
				
				var current = points.first!
				for point in points.dropFirst() {
					if point.x == current.x {
						let range = point.y < current.y
							? point.y ... current.y
							: current.y ... point.y
						
						for y in range {
							grid[Point(x: current.x, y: y)] = .rock
						}
					} else {
						let range = point.x < current.x
							? point.x ... current.x
							: current.x ... point.x
						
						for x in range {
							grid[Point(x: x, y: current.y)] = .rock
						}
					}
					
					current = point
				}
			}
	}
	
	fileprivate func displayGrid(_ grid: [Point: Tile]) {
		let xRange = grid.keys.range(\.x)!
		let yRange = grid.keys.range(\.y)!
		
		for y in yRange {
			let line = xRange
				.map { grid[Point(x: $0, y: y)]?.description ?? " " }
				.joined()
			print(line)
		}
	}
	
	fileprivate func sandPosition(
		droppingFrom start: Point = Point(x: 500, y: 0),
		in grid: [Point: Tile],
		limit: Int
	) -> Point? {
		var origin = start
		
		while grid[origin] == nil {
			origin.y += 1
			
			if origin.y == limit {
				return origin
			}
		}
		
		origin.y -= 1
		
		let bottomLeft = Point(x: origin.x - 1, y: origin.y + 1)
		let bottomRight = Point(x: origin.x + 1, y: origin.y + 1)
		if grid[bottomLeft] == nil {
			return sandPosition(droppingFrom: bottomLeft, in: grid, limit: limit)
		} else if grid[bottomRight] == nil {
			return sandPosition(droppingFrom: bottomRight, in: grid, limit: limit)
		}
		
		return origin
	}
}
