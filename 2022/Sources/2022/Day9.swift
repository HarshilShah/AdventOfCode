import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate enum Direction: Character {
	case up = "U", down = "D", left = "L", right = "R"
}

fileprivate struct Point: Hashable {
	var x: Int
	var y: Int
	
	static let zero = Point(x: 0, y: 0)
	
	func moving(in direction: Direction) -> Point {
		switch direction {
		case .up: return Point(x: x, y: y - 1)
		case .down: return Point(x: x, y: y + 1)
		case .left: return Point(x: x - 1, y: y)
		case .right: return Point(x: x + 1, y: y)
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

struct Day9: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		pointsVisitedByTailByMovingRope(ofLength: 2)
			.description
	}
	
	func partTwo() -> String {
		pointsVisitedByTailByMovingRope(ofLength: 10)
			.description
	}
	
	func pointsVisitedByTailByMovingRope(ofLength length: Int) -> Int {
		var points = Array(repeating: Point.zero, count: length)
		
		var tailPoints: Set<Point> = [.zero]
		
		for line in input.split(separator: "\n") {
			let direction = Direction(rawValue: line.first!)!
			let steps = Int(line.dropFirst(2))!
			
			for _ in 1 ... steps {
				points[0] = points[0].moving(in: direction)
				for (previousIndex, index) in points.indices.adjacentPairs() {
					points[index].move(attachedTo: points[previousIndex])
				}
				
				tailPoints.insert(points.last!)
			}
		}
		
		return tailPoints.count
	}
}
