import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate enum Direction: Character, CaseIterable, CustomStringConvertible {
	case north = "^", east = ">", west = "<", south = "v"
	
	var description: String {
		"\(rawValue)"
	}
}

fileprivate struct Point: Hashable, CustomStringConvertible {
	var x: Int
	var y: Int
	
	static let zero = Point(x: 0, y: 0)
	
	func moving(in direction: Direction) -> Point {
		switch direction {
		case .north: return Point(x: x, y: y - 1)
		case .south: return Point(x: x, y: y + 1)
		case .west: return Point(x: x - 1, y: y)
		case .east: return Point(x: x + 1, y: y)
		}
	}
	
	var neighbours: Set<Point> {
		Set(
			Direction.allCases.map {
				self.moving(in: $0)
			}
		)
	}
	
	var description: String {
		"(x: \(x), y: \(y))"
	}
}

fileprivate typealias Blizzards = [Point: Set<Direction>]

fileprivate extension Blizzards {
	mutating func iterate(in board: Board) {
		var newBlizzards: [Point: Set<Direction>] = [:]
		
		for (blizzardPosition, directions) in self {
			for direction in directions {
				var newPosition = blizzardPosition.moving(in: direction)
				switch direction {
				case .north: newPosition.y = board.yRange.contains(newPosition.y) ? newPosition.y :board.yRange.upperBound
				case .south: newPosition.y = board.yRange.contains(newPosition.y) ? newPosition.y :board.yRange.lowerBound
				case .east: newPosition.x = board.xRange.contains(newPosition.x) ? newPosition.x :board.xRange.lowerBound
				case .west: newPosition.x = board.xRange.contains(newPosition.x) ? newPosition.x :board.xRange.upperBound
				}
				
				newBlizzards[newPosition, default: []].insert(direction)
			}
		}
		
		self = newBlizzards
	}
}

fileprivate struct Board: Hashable {
	var initial: Point
	var final: Point
	var xRange: ClosedRange<Int>
	var yRange: ClosedRange<Int>
}

struct Day24: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		var (board, blizzards) = parse()
		return solve(board, blizzards: &blizzards).description
	}
	
	func partTwo() -> String {
		var (board, blizzards) = parse()
		let flippedBoard = Board(initial: board.final, final: board.initial, xRange: board.xRange, yRange: board.yRange)
		
		let down = solve(board, blizzards: &blizzards)
		let up = solve(flippedBoard, blizzards: &blizzards)
		let backDown = solve(board, blizzards: &blizzards)
		return (down + up + backDown).description
	}
	
	fileprivate func parse() -> (board: Board, blizzards: Blizzards) {
		let initial = Point(x: 1, y: 0)
		var final: Point!
		var blizzards = Blizzards()
		
		for (y, line) in input.split(separator: "\n").enumerated() {
			for (x, char) in line.enumerated() {
				let point = Point(x: x, y: y)
				if let wind = Direction(rawValue: char) {
					blizzards[point, default: []].insert(wind)
				} else if char == "." {
					final = point
				}
			}
		}
		
		let board = Board(
			initial: initial,
			final: final,
			xRange: 1 ... input.split(separator: "\n").first!.count - 2,
			yRange: 1 ... input.split(separator: "\n").count - 2
		)
		
		return (board, blizzards)
	}
	
	fileprivate func solve(
		_ board: Board,
		blizzards: inout Blizzards
	) -> Int {
		var points = Set([board.initial])
		var steps = 0
		
		while points.contains(board.final) == false {
			steps += 1
			
			blizzards.iterate(in: board)
			
			let newPoints = Set(points.lazy.flatMap(\.neighbours)).union(points)
				.filter { newPosition in
					(board.xRange.contains(newPosition.x) && board.yRange.contains(newPosition.y))
					|| newPosition == board.final
					|| newPosition == board.initial
				}
				.filter { blizzards.keys.contains($0) == false }
			
			points = newPoints
		}
		
		return steps
	}
}
