//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

struct Point: Hashable {
	var x: Int
	var y: Int
	
	var neighbours: Set<Point> {
		var all = Set(
			((x - 1)...(x + 1)).flatMap { x in
				((y - 1)...(y + 1)).map { y in
					Point(x: x, y: y)
				}
			}
		)
		all.remove(self)
		return all
	}
}

let initialOctopuses = input
	.split(separator: "\n")
	.enumerated()
	.reduce(into: [Point: Int]()) { dict, tuple in
		let (y, line) = tuple
		line.enumerated().forEach { x, char in
			dict[Point(x: x, y: y)] = char.wholeNumberValue!
		}
	}

func advance(_ octopuses: inout [Point: Int]) {
	octopuses = octopuses.mapValues { $0 + 1 }
	
	var newlyFlashed = Set(octopuses.filter({ $0.value > 9 }).keys)
	var flashed = newlyFlashed
	
	while !newlyFlashed.isEmpty {
		newlyFlashed.forEach {
			$0.neighbours.forEach { octopuses[$0]? += 1 }
		}
		newlyFlashed = Set(octopuses.filter({ $0.value > 9 }).keys).subtracting(flashed)
		flashed.formUnion(newlyFlashed)
	}
	
	flashed.forEach { octopuses[$0] = 0 }
}

func partOne() -> String {
	var octopuses = initialOctopuses
	
	var score = 0
	for _ in 1 ... 100 {
		advance(&octopuses)
		score += octopuses.lazy.filter({ $0.value == 0 }).count
	}
	
	return score.description
}

func partTwo() -> String {
	var octopuses = initialOctopuses
	
	for step in 1... {
		advance(&octopuses)
		let score = octopuses.lazy.filter({ $0.value == 0 }).count
		if score == 100 {
			return step.description
		}
	}
	
	fatalError("This shouldn't happen")
}

print(partOne())
print(partTwo())

//: [Next](@next)
