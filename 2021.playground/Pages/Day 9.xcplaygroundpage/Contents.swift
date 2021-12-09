//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension Sequence {
	func union<T>() -> Set<T> where Element == Set<T> {
		var sum = Set<T>()
		for item in self {
			sum.formUnion(item)
		}
		return sum
	}
}

struct Point: Hashable {
	var x: Int
	var y: Int
	
	var neighbours: Set<Point> {
		[
			Point(x: x, y: y + 1),
			Point(x: x, y: y - 1),
			Point(x: x + 1, y: y),
			Point(x: x - 1, y: y)
		]
	}
}

let points = input
	.split(separator: "\n")
	.enumerated()
	.reduce(into: [Point: Int]()) { dict, tuple in
		let (y, line) = tuple
		line.enumerated().forEach { (x, height) in
			dict[Point(x: x, y: y)] = height.wholeNumberValue!
		}
	}

let lowPoints = points.filter { point, height in
	point.neighbours.allSatisfy {
		guard let neighbour = points[$0] else { return true }
		return neighbour > height
	}
}

func partOne() -> String {
	lowPoints
		.map { $0.value + 1 }
		.reduce(0, +)
		.description
}

func partTwo() -> String {
	let basinSizes = lowPoints.map { point, height -> Int in
		var basin: Set<Point> = [point]
		var pointsToExplore: Set<Point> = [point]
		
		while pointsToExplore.isEmpty == false {
			pointsToExplore = pointsToExplore
				.lazy
				.map { point in
					point.neighbours.filter { neighbour in
						guard let height = points[neighbour] else { return false }
						guard !basin.contains(neighbour) else { return false }
						return height != 9
					}
				}
				.union()
			
			basin.formUnion(pointsToExplore)
		}
		
		return basin.count
	}
	
	return basinSizes
		.sorted(by: >)
		.prefix(3)
		.reduce(1, *)
		.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
