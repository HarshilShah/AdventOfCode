//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension StringProtocol {
	var numbers: [Int] {
		split(whereSeparator: { "-0123456789".contains($0) == false })
			.map { Int($0)! }
	}
}

struct Point: Hashable {
	var x: Int
	var y: Int
	var z: Int
}

extension Point {
	static let zero = Point(x: 0, y: 0, z: 0)
	
	var magnitude: Int { abs(x) + abs(y) + abs(z) }
	
	func manhattanDistance(to other: Point) -> Point {
		return Point(
			x: x - other.x,
			y: y - other.y,
			z: z - other.z
		)
	}
}

extension Sequence where Element == Point {
	func sum() -> Point {
		reduce(into: .zero) { result, point in
			result.x += point.x
			result.y += point.y
			result.z += point.z
		}
	}
}

let rotations: [(Point) -> Point] = [
	{ Point(x: $0.x, y: $0.y, z: $0.z) },
	{ Point(x: $0.x, y: -$0.z, z: $0.y) },
	{ Point(x: $0.x, y: -$0.y, z: -$0.z) },
	{ Point(x: $0.x, y: $0.z, z: -$0.y) },
	
	{ Point(x: -$0.x, y: $0.y, z: -$0.z) },
	{ Point(x: -$0.x, y: -$0.z, z: -$0.y) },
	{ Point(x: -$0.x, y: -$0.y, z: $0.z) },
	{ Point(x: -$0.x, y: $0.z, z: $0.y) },
	
	{ Point(x: $0.y, y: $0.x, z: -$0.z) },
	{ Point(x: $0.y, y: -$0.z, z: -$0.x) },
	{ Point(x: $0.y, y: -$0.x, z: $0.z) },
	{ Point(x: $0.y, y: $0.z, z: $0.x) },
	
	{ Point(x: -$0.y, y: $0.x, z: $0.z) },
	{ Point(x: -$0.y, y: -$0.z, z: $0.x) },
	{ Point(x: -$0.y, y: -$0.x, z: -$0.z) },
	{ Point(x: -$0.y, y: $0.z, z: -$0.x) },
	
	{ Point(x: $0.z, y: $0.y, z: -$0.x) },
	{ Point(x: $0.z, y: $0.x, z: $0.y) },
	{ Point(x: $0.z, y: -$0.y, z: $0.x) },
	{ Point(x: $0.z, y: -$0.x, z: -$0.y) },
	
	{ Point(x: -$0.z, y: $0.y, z: $0.x) },
	{ Point(x: -$0.z, y: -$0.x, z: $0.y) },
	{ Point(x: -$0.z, y: -$0.y, z: -$0.x) },
	{ Point(x: -$0.z, y: $0.x, z: -$0.y) },
]

struct Scanner: Hashable {
	var number: Int
	var points: Set<Point>
	
	func permutations() -> [Scanner] {
		rotations.map { rotation in
			Scanner(number: number, points: Set(points.lazy.map(rotation)))
		}
	}
}

extension Scanner {
	var connections: [Point] {
		var distances: [Point] = []
		for point in points {
			for otherPoint in points {
				if otherPoint == point { continue }
				distances.append(point.manhattanDistance(to: otherPoint))
			}
		}
		return distances
	}
}

let currentInput = input
let scanners = currentInput.components(separatedBy: "\n\n")
	.enumerated()
	.map { number, lines -> Scanner in
		let pointLines = lines.split(separator: "\n").dropFirst()
		let points = pointLines.lazy
			.map { $0.numbers }
			.map { Point(x: $0[0], y: $0[1], z: $0[2]) }
		return Scanner(number: number, points: Set(points))
	}

var foundScanners: [Scanner] = [scanners[0]]
var foundScannerNumbers: Set<Int> = [0]
var foundCenters: Set<Point> = [.zero]

var current = scanners[0]

while foundScanners.count != scanners.count {
	
	for scanner in scanners where foundScannerNumbers.contains(scanner.number) == false {
		let currentConnections = current.connections
		let possibleOrientations = scanner.permutations()
		
		for orientation in possibleOrientations {
			let intersection = orientation.connections.filter(currentConnections.contains)
			
			guard intersection.count >= 132 else { continue }
			
			let currentIntersectingPoints = current.points.filter { point in
				current.points
					.map { $0.manhattanDistance(to: point) }
					.filter(intersection.contains)
					.count >= 11
			}
			
			let otherIntersectingPoints = orientation.points.filter { point in
				orientation.points
					.map { $0.manhattanDistance(to: point) }
					.filter(intersection.contains)
					.count >= 11
			}
			
			guard currentIntersectingPoints.count == otherIntersectingPoints.count else {
				continue
			}
			
			let count = otherIntersectingPoints.count
			let currentIntersectingTotalVector = currentIntersectingPoints.sum()
			let otherIntersectingTotalVector = otherIntersectingPoints.sum()
			
			let adjustment = Point(
				x: (currentIntersectingTotalVector.x - otherIntersectingTotalVector.x) / count,
				y: (currentIntersectingTotalVector.y - otherIntersectingTotalVector.y) / count,
				z: (currentIntersectingTotalVector.z - otherIntersectingTotalVector.z) / count
			)
			
			let adjusted = Scanner(
				number: orientation.number,
				points: Set(
					orientation.points.map { point in
						Point(
							x: point.x + adjustment.x,
							y: point.y + adjustment.y,
							z: point.z + adjustment.z
						)
					}
				)
			)
			
			guard adjusted.points.intersection(current.points).count == count else {
				continue
			}
			
			foundScanners.append(adjusted)
			foundScannerNumbers.insert(adjusted.number)
			foundCenters.insert(adjustment)
			break
		}
	}
	
	current = foundScanners.drop(while: { $0.number != current.number }).dropFirst().first!
}

func partOne() -> String {
	foundScanners
		.reduce(into: Set<Point>()) { total, scanner in
			total.formUnion(scanner.points)
		}
		.count
		.description
}

func partTwo() -> String {
	foundCenters
		.flatMap { center in
			foundCenters.map { $0.manhattanDistance(to: center).magnitude }
		}
		.max()!
		.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
