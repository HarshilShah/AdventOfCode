//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

struct Point: Hashable {
	var x: Int
	var y: Int
	
	var neighbours: [Point] {
		[
			Point(x: x + 1, y: y),
			Point(x: x, y: y + 1),
			Point(x: x - 1, y: y),
			Point(x: x, y: y - 1),
		]
	}
}

let grid = input
	.split(separator: "\n")
	.enumerated()
	.reduce(into: [Point: Int]()) { dict, tuple in
		let (y, line) = tuple
		line.enumerated().forEach { x, char in
			dict[Point(x: x, y: y)] = char.wholeNumberValue!
		}
	}

func cost(from initialPosition: Point, to finalPosition: Point, in grid: [Point: Int]) -> Int {
	var minCosts: [Point: Int] = [:]
	var minCost: Int { minCosts[finalPosition] ?? .max }
	
	var currentPositions: [Point: Int] = [initialPosition: 0]
	
	while let (position, cost) = currentPositions.min(by: { $0.value < $1.value }) {
		currentPositions.removeValue(forKey: position)
		
		guard cost < minCost else { continue }
		
		var nextPositions = position.neighbours
		if nextPositions.contains(finalPosition) {
			nextPositions.removeAll(where: { $0 == finalPosition })
			minCosts[finalPosition] = min(minCost, cost + grid[finalPosition]!)
		}
		
		nextPositions.forEach { nextPosition in
			guard let nextPositionCost = grid[nextPosition] else { return }
			let totalCost = cost + nextPositionCost
			if let previousCost = minCosts[nextPosition], previousCost <= totalCost { return }
			minCosts[nextPosition] = totalCost
			currentPositions[nextPosition] = totalCost
		}
	}
	
	return minCost
}

func partOne() -> String {
	let initialPosition = Point(x: 0, y: 0)
	let finalPosition = Point(
		x: input.split(separator: "\n")[0].count - 1,
		y: input.split(separator: "\n").count - 1
	)
	
	return cost(from: initialPosition, to: finalPosition, in: grid).description
}

func partTwo() -> String {
	let width = input.split(separator: "\n")[0].count
	let height = input.split(separator: "\n").count
	
	let modifiedGrid = (0 ..< 5).reduce(into: [Point: Int]()) { newGrid, x in
		(0 ..< 5).forEach { y in
			grid.forEach { point, cost in
				let newPoint = Point(
					x: (width * x) + point.x,
					y: (height * y) + point.y
				)
				let rawCost = cost + x + y
				let newCost = rawCost > 9 ? rawCost % 9 : rawCost
				newGrid[newPoint] = newCost
			}
		}
	}
	
	let initialPosition = Point(x: 0, y: 0)
	let finalPosition = Point(
		x: input.split(separator: "\n")[0].count * 5 - 1,
		y: input.split(separator: "\n").count * 5 - 1
	)
	
	return cost(from: initialPosition, to: finalPosition, in: modifiedGrid).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
