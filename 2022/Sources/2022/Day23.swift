import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate enum Direction: CaseIterable {
	case north, east, west, south
	case northEast, northWest, southEast, southWest
}

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	static let zero = Point(x: 0, y: 0)
	
	func moving(in direction: Direction) -> Point {
		switch direction {
		case .north: return Point(x: x, y: y - 1)
		case .south: return Point(x: x, y: y + 1)
		case .west: return Point(x: x - 1, y: y)
		case .east: return Point(x: x + 1, y: y)
		case .northEast: return Point(x: x + 1, y: y - 1)
		case .northWest: return Point(x: x - 1, y: y - 1)
		case .southEast: return Point(x: x + 1, y: y + 1)
		case .southWest: return Point(x: x - 1, y: y + 1)
		}
	}
	
	var neighbours: Set<Point> {
		Set(
			Direction.allCases.map {
				self.moving(in: $0)
			}
		)
	}
}

struct Day23: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		var elves = parseElves()
		
		var directions: Deque<Direction> = [.north, .south, .west, .east]
		
		for _ in 1 ... 10 {
			elves = iterate(elves, directions: directions)
			directions.append(directions.popFirst()!)
		}
		
		let xRange = elves.range(\.x)!
		let yRange = elves.range(\.y)!
		
		let emptySpaces = xRange.count * yRange.count - elves.count
		return emptySpaces.description
	}
	
	func partTwo() -> String {
		var elves = parseElves()
		
		var directions: Deque<Direction> = [.north, .south, .west, .east]
		
		for step in 1... {
			let next = iterate(elves, directions: directions)
			
			if next == elves {
				return step.description
			}
			
			elves = next
			directions.append(directions.popFirst()!)
		}
		
		fatalError("Invalid state")
	}
	
	fileprivate func parseElves() -> Set<Point> {
		input
			.split(separator: "\n")
			.enumerated()
			.reduce(into: Set<Point>()) { points, tuple in
				let (y, line) = tuple
				line.enumerated().forEach { x, char in
					if char == "#" {
						points.insert(Point(x: x, y: y))
					}
				}
			}
	}
	
	fileprivate func iterate(_ elves: Set<Point>, directions: some Collection<Direction>) -> Set<Point> {
		let pointsThatCanMove = elves.filter { elf in
			elf.neighbours.contains(where: elves.contains)
		}
		
		guard pointsThatCanMove.isEmpty == false else {
			return elves
		}
		
		var newPoints: [Point: Point] = [:]
		
		for point in pointsThatCanMove {
			for direction in directions {
				guard newPoints[point] == nil else {
					break
				}
				
				let directionsToCheck: [Direction] = {
					switch direction {
					case .north: return [.northWest, .north, .northEast]
					case .south: return [.southWest, .south, .southEast]
					case .east: return [.northEast, .east, .southEast]
					case .west: return [.northWest, .west, .southWest]
					default: fatalError("Unexpected direction to move in")
					}
				}()
				
				if directionsToCheck.allSatisfy({ elves.contains(point.moving(in: $0)) == false }) {
					newPoints[point] = point.moving(in: direction)
				}
			}
		}
		
		var result = elves
		for (original, new) in newPoints {
			guard newPoints.values.lazy.filter({ $0 == new }).count == 1 else {
				continue
			}
			
			result.remove(original)
			result.insert(new)
		}
		return result
	}
	
	fileprivate func displayElves(_ elves: Set<Point>) {
		let xRange = elves.range(\.x)!.expanded(by: 1)
		let yRange = elves.range(\.y)!.expanded(by: 1)
		
		let grid = yRange
			.map { y in
				xRange
					.map { x in
						elves.contains(Point(x: x, y: y)) ? "#" : "."
					}
					.joined()
			}
			.joined(separator: "\n")
		
		print(grid)
	}
}
