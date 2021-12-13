//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

struct Point: Hashable {
	var x: Int
	var y: Int
}

let components = input.components(separatedBy: "\n\n")
let pointLines = components[0]
let foldLines = components[1]

let initialPoints = pointLines
	.split(separator: "\n")
	.reduce(into: Set<Point>()) { points, line in
		guard line.starts(with: "fold along") == false else { return }
		let numbers = line.split(separator: ",").map { Int($0)! }
		points.insert(Point.init(x: numbers[0], y: numbers[1]))
	}

func applyFold(_ fold: Substring, to points: inout Set<Point>) {
	let components = fold.split(separator: "=")
	let axis = components[0].last == "x"
	let amount = Int(components[1])!
	
	if axis {
		points = Set(
			points.lazy.map { point in
				guard point.x > amount else { return point }
				let newX = (2 * amount) - point.x
				return Point(x: newX, y: point.y)
			}
		)
	} else {
		points = Set(
			points.lazy.map { point in
				guard point.y > amount else { return point }
				let newY = (2 * amount) - point.y
				return Point(x: point.x, y: newY)
			}
		)
	}
}

func partOne() -> String {
	var points = initialPoints
	applyFold(foldLines.split(separator: "\n")[0], to: &points)
	return points.count.description
}

func partTwo() -> String {
	var points = initialPoints
	
	for fold in foldLines.split(separator: "\n") {
		applyFold(fold, to: &points)
	}
	
	let xRange = points.map(\.x).min()! ... points.map(\.x).max()!
	let yRange = points.map(\.y).min()! ... points.map(\.y).max()!

	return yRange
		.map { y in
			xRange
				.map { points.contains(Point(x: $0, y: y)) ? "X" : "." }
				.joined()
		}
		.joined(separator: "\n")
}


print(partOne())
print(partTwo())

//: [Next](@next)
