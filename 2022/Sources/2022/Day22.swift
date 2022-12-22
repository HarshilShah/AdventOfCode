import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate enum Tile: Character {
	case empty = "."
	case wall = "#"
}

fileprivate enum Direction: Character {
	case up = "U", down = "D", left = "L", right = "R"
	
	var intValue: Int {
		switch self {
		case .up: return 3
		case .down: return 1
		case .left: return 2
		case .right: return 0
		}
	}
	
	mutating func rotate(towards other: Direction) {
		switch other {
		case .up, .down: return
		case .left:
			switch self {
			case .up: self = .left
			case .down: self = .right
			case .left: self = .down
			case .right: self = .up
			}
			
		case .right:
			switch self {
			case .up: self = .right
			case .down: self = .left
			case .left: self = .up
			case .right: self = .down
			}
		}
	}
}

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	static let zero = Point(x: 0, y: 0)
	
	func moving(in direction: Direction, steps: Int) -> Point {
		switch direction {
		case .up: return Point(x: x, y: y - steps)
		case .down: return Point(x: x, y: y + steps)
		case .left: return Point(x: x - steps, y: y)
		case .right: return Point(x: x + steps, y: y)
		}
	}
	
	func isConnectedTo(_ other: Point) -> Bool {
		if self == other { return true }
		return abs(x - other.x) <= 1 && abs(y - other.y) <= 1
	}
	
	mutating func move(attachedTo head: Point) {
		if self.isConnectedTo(head) { return }
		
		let xMove = x < head.x ? 1 : -1
		let yMove = y < head.y ? 1 : -1
		
		if x == head.x {
			y += yMove
		} else if y == head.y {
			x += xMove
		} else {
			x += xMove
			y += yMove
		}
	}
}

struct Day22: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let grid = input
			.components(separatedBy: "\n\n")
			.first!
			.split(separator: "\n")
			.enumerated()
			.reduce(into: [Point: Tile]()) { grid, tuple in
				let (y, line) = tuple
				for (x, char) in line.enumerated() {
					if let tile = Tile(rawValue: char) {
						grid[Point(x: x, y: y)] = tile
					}
				}
			}

		let startingY = grid.keys.min(\.y)!
		let startingX = grid.keys.filter({ $0.y == startingY }).min(\.x)!

		var position = Point(x: startingX, y: startingY)
		var direction = Direction.right

		let instructions = input
			.components(separatedBy: "\n\n")
			.last!
			.chunked(on: \.isWholeNumber)

		for (_, instruction) in instructions {
			if let number = Int(instruction) {
				for _ in 1 ... number {
					var newPosition = position.moving(in: direction, steps: 1)

					switch grid[newPosition] {
					case .empty:
						position = newPosition

					case .wall:
						continue

					case nil:
						lazy var xRange: ClosedRange<Int> = grid.keys.filter({ $0.y == newPosition.y }).range(\.x)!
						lazy var yRange: ClosedRange<Int> = grid.keys.filter({ $0.x == newPosition.x }).range(\.y)!

						switch direction {
						case .up: newPosition.y = yRange.upperBound
						case .down: newPosition.y = yRange.lowerBound
						case .left: newPosition.x = xRange.upperBound
						case .right: newPosition.x = xRange.lowerBound
						}

						if grid[newPosition] == .empty {
							position = newPosition
						} else {
							continue
						}
					}
				}
			} else if let d = Direction(rawValue: instruction.first!) {
				direction.rotate(towards: d)
			} else {
				fatalError("Unexpected input \(instruction)")
			}
		}

		let score = (position.y + 1) * 1000 + (position.x + 1) * 4 + direction.intValue
		return score.description
	}
	
	func partTwo() -> String {
		let grid = input
			.components(separatedBy: "\n\n")
			.first!
			.split(separator: "\n")
			.enumerated()
			.reduce(into: [Point: Tile]()) { grid, tuple in
				let (y, line) = tuple
				for (x, char) in line.enumerated() {
					if let tile = Tile(rawValue: char) {
						grid[Point(x: x + 1, y: y + 1)] = tile
					}
				}
			}
		
		let startingY = grid.keys.min(\.y)!
		let startingX = grid.keys.filter({ $0.y == startingY }).min(\.x)!
		
		var position = Point(x: startingX, y: startingY)
		var direction = Direction.right
		
		let instructions = input
			.components(separatedBy: "\n\n")
			.last!
			.chunked(on: \.isWholeNumber)
		
		for (_, instruction) in instructions {
			if let number = Int(instruction) {
				for _ in 1 ... number {
					var newPosition = position.moving(in: direction, steps: 1)
					
					switch grid[newPosition] {
					case .empty:
						position = newPosition
						
					case .wall:
						continue
						
					case nil:
						var newDirection: Direction
						(newPosition, newDirection) = transitionCube(from: position, in: direction)
						
						if grid[newPosition] == .empty {
							position = newPosition
							direction = newDirection
						} else {
							continue
						}
					}
				}
			} else if let d = Direction(rawValue: instruction.first!) {
				direction.rotate(towards: d)
			} else {
				fatalError("Unexpected input \"\(instruction)\"")
			}
		}
		
		let score = (position.y) * 1000 + (position.x) * 4 + direction.intValue
		return score.description
	}
	
	fileprivate func transitionCube(from position: Point, in direction: Direction) -> (Point, Direction) {
		var newPosition = position
		var newDirection: Direction
		
		if position.x > 100 {
			/// CUBE 2
			
			switch direction {
			case .right:
				newPosition.x = 100
				newPosition.y = 151 - newPosition.y
				newDirection = .left
			case .down:
				newPosition.y = newPosition.x - 50
				newPosition.x = 100
				newDirection = .left
			case .up:
				newPosition.x = newPosition.x - 100
				newPosition.y = 200
				newDirection = .up
			case .left:
				fatalError("Illegal move")
			}
		} else if position.y <= 50 {
			// CUBE 1
			
			switch direction {
			case .up:
				newPosition.y = newPosition.x + 100
				newPosition.x = 1
				newDirection = .right
			case .left:
				newPosition.y = 151 - newPosition.y
				newPosition.x = 1
				newDirection = .right
			case .down, .right:
				fatalError("Illegal move")
			}
			
		} else if position.y <= 100 {
			// CUBE 3
			
			switch direction {
			case .left:
				newPosition.x = newPosition.y - 50
				newPosition.y = 101
				newDirection = .down
			case .right:
				newPosition.x = newPosition.y + 50
				newPosition.y = 50
				newDirection = .up
			case .up, .down:
				fatalError("Illegal move")
			}
		} else if position.x > 50 {
			// CUBE 4
			
			switch direction {
			case .right:
				newPosition.x = 150
				newPosition.y = 151 - newPosition.y
				newDirection = .left
			case .down:
				newPosition.y = newPosition.x + 100
				newPosition.x = 50
				newDirection = .left
			case .up, .left:
				fatalError("Illegal move")
			}
		} else if position.y <= 150 {
			// CUBE 5
			
			switch direction {
			case .up:
				newPosition.y = newPosition.x + 50
				newPosition.x = 51
				newDirection = .right
			case .left:
				newPosition.x = 51
				newPosition.y = 151 - newPosition.y
				newDirection = .right
			case .right, .down:
				fatalError("Illegal move")
			}
		} else {
			// CUBE 6
			
			switch direction {
			case .left:
				newPosition.x = newPosition.y - 100
				newPosition.y = 1
				newDirection = .down
			case .right:
				newPosition.x = newPosition.y - 100
				newPosition.y = 150
				newDirection = .up
			case .down:
				newPosition.x += 100
				newPosition.y = 1
				newDirection = .down
			case .up:
				fatalError("Illegal move")
			}
		}
		
		return (newPosition, newDirection)
	}
}
