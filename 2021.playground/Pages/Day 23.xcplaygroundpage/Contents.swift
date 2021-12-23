//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

let input2 = """
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

enum Amphipod: Character, CaseIterable {
	case a = "A", b = "B", c = "C", d = "D"
	
	var energyLevel: Int {
		switch self {
		case .a: return 1
		case .b: return 10
		case .c: return 100
		case .d: return 1000
		}
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
func partOne() -> String {
	func homes(for amphipod: Amphipod) -> [Point] {
		switch amphipod {
		case .a: return (2 ... 3).map { Point(x: 3, y: $0) }
		case .b: return (2 ... 3).map { Point(x: 5, y: $0) }
		case .c: return (2 ... 3).map { Point(x: 7, y: $0) }
		case .d: return (2 ... 3).map { Point(x: 9, y: $0) }
		}
	}
	
	let finalPositions = Amphipod.allCases.reduce(into: [Point: Amphipod]()) { dict, amphipod in
		homes(for: amphipod).forEach { dict[$0] = amphipod }
	}
	
	struct Board: Hashable {
		var allPoints: Set<Point>
		var occupiablePositions: Set<Point>
		var amphipodPositions: [Point: Amphipod]
		
		func reachablePoints(from initialPosition: Point) -> [Point: Int] {
			var steps = 0
			var reachable: [Point: Int] = [:]
			var current: Set<Point> = [initialPosition]
			while current.isEmpty == false {
				steps += 1
				
				var potential = current.map(\.neighbours).union()
				potential.remove(initialPosition)
				potential.formIntersection(allPoints)
				potential.subtract(amphipodPositions.keys)
				potential.subtract(reachable.keys)
				
				for point in potential {
					reachable[point] = steps
				}
				current = potential
			}
			return reachable
		}
		
		func next() -> [Board: Int] {
			amphipodPositions.reduce(into: [Board: Int]()) { dict, tuple in
				let (position, amphipod) = tuple
				let homes = homes(for: amphipod)
				
				if let index = homes.firstIndex(of: position), homes.dropFirst(index + 1).allSatisfy({ amphipodPositions[$0] == amphipod }) {
					return
				}
				
				for (reachablePosition, steps) in reachablePoints(from: position) {
					if homes.contains(reachablePosition) {
						let lowerHomes = homes.drop(while: { $0 != reachablePosition }).dropFirst()
						guard
							lowerHomes.allSatisfy({ self.amphipodPositions[$0] == amphipod })
						else  { continue }
					} else if occupiablePositions.contains(reachablePosition) {
						if position.y == 1 {
							continue
						}
					} else {
						continue
					}
					
					var amphipodPositions = amphipodPositions
					amphipodPositions.removeValue(forKey: position)
					amphipodPositions[reachablePosition] = amphipod
					
					let cost = steps * amphipod.energyLevel
					let newBoard = Board(
						allPoints: allPoints,
						occupiablePositions: occupiablePositions,
						amphipodPositions: amphipodPositions
					)
					dict[newBoard] = cost
				}
			}
		}
		
		var minimumEstimatedCost: Int {
			var cost = 0
			for amphipod in Amphipod.allCases {
				var homes = homes(for: amphipod)
				var locations = Set(amphipodPositions.filter({ $0.value == amphipod }).keys)
				
				let overlap = homes.reversed().prefix(while: locations.contains)
				homes.removeAll(where: overlap.contains)
				overlap.forEach { locations.remove($0) }
				
				for (location, home) in zip(locations, homes) {
					let distance: Int
					if location.y == 1 {
						distance = home.y - 1
						+ abs(location.x - home.x)
					} else {
						if location.x == home.x {
							distance = home.y + 2
						} else {
							distance = home.y + location.y - 2
							+ abs(location.x - home.x)
						}
					}
					cost += distance * amphipod.energyLevel
				}
			}
			
			return cost
		}
		
	}
	
	var allPoints: Set<Point> = []
	var occupiablePositions: Set<Point> = []
	var currentPods: [Point: Amphipod] = [:]
	
	input
		.split(separator: "\n")
		.enumerated()
		.forEach { y, line in
			for (x, char) in line.enumerated() {
				if char == " " || char == "#" { continue }
				
				let point = Point(x: x, y: y)
				allPoints.insert(point)
				
				if char == "." {
					occupiablePositions.insert(point)
				} else if let amphipod = Amphipod(rawValue: char) {
					currentPods[point] = amphipod
				}
			}
		}
	
	occupiablePositions.remove(Point(x: 3, y: 1))
	occupiablePositions.remove(Point(x: 5, y: 1))
	occupiablePositions.remove(Point(x: 7, y: 1))
	occupiablePositions.remove(Point(x: 9, y: 1))
	
	var minCost = Int.max
	let initialBoard = Board(
		allPoints: allPoints,
		occupiablePositions: occupiablePositions,
		amphipodPositions: currentPods
	)
	var seenBoards = [initialBoard.amphipodPositions: 0]
	var currentBoards = [
		initialBoard: (0, initialBoard.minimumEstimatedCost)
	]
	
	while let (board, costs) = currentBoards.min(by: { ($0.value.1, $0.value.0) < ($1.value.1, $1.value.0) }) {
		currentBoards.removeValue(forKey: board)
		let cost = costs.0
		
		if let existing = seenBoards[board.amphipodPositions], existing < cost { continue }
		
		guard cost + costs.1 < minCost else { continue }
		
		for (nextBoard, newCost) in board.next() {
			let nextCost = cost + newCost
			
			guard nextCost < minCost else { continue }
			
			if nextBoard.amphipodPositions == finalPositions {
				minCost = min(minCost, nextCost)
				continue
			}
			
			if let existing = seenBoards[nextBoard.amphipodPositions], existing <= nextCost { continue }
			seenBoards[nextBoard.amphipodPositions] = nextCost
			currentBoards[nextBoard] = (nextCost, nextBoard.minimumEstimatedCost)
		}
	}
	
	return minCost.description
}

func partTwo() -> String {
	func homes(for amphipod: Amphipod) -> [Point] {
		switch amphipod {
		case .a: return (2 ... 5).map { Point(x: 3, y: $0) }
		case .b: return (2 ... 5).map { Point(x: 5, y: $0) }
		case .c: return (2 ... 5).map { Point(x: 7, y: $0) }
		case .d: return (2 ... 5).map { Point(x: 9, y: $0) }
		}
	}

	let finalPositions = Amphipod.allCases.reduce(into: [Point: Amphipod]()) { dict, amphipod in
		homes(for: amphipod).forEach { dict[$0] = amphipod }
	}

	struct Board: Hashable {
		var allPoints: Set<Point>
		var occupiablePositions: Set<Point>
		var amphipodPositions: [Point: Amphipod]
		
		func reachablePoints(from initialPosition: Point) -> [Point: Int] {
			var steps = 0
			var reachable: [Point: Int] = [:]
			var current: Set<Point> = [initialPosition]
			while current.isEmpty == false {
				steps += 1
				
				var potential = current.map(\.neighbours).union()
				potential.remove(initialPosition)
				potential.formIntersection(allPoints)
				potential.subtract(amphipodPositions.keys)
				potential.subtract(reachable.keys)
				
				for point in potential {
					reachable[point] = steps
				}
				current = potential
			}
			return reachable
		}
		
		func next() -> [Board: Int] {
			amphipodPositions.reduce(into: [Board: Int]()) { dict, tuple in
				let (position, amphipod) = tuple
				let homes = homes(for: amphipod)
				
				if let index = homes.firstIndex(of: position), homes.dropFirst(index + 1).allSatisfy({ amphipodPositions[$0] == amphipod }) {
					return
				}
				
				for (reachablePosition, steps) in reachablePoints(from: position) {
					if homes.contains(reachablePosition) {
						let lowerHomes = homes.drop(while: { $0 != reachablePosition }).dropFirst()
						guard
							lowerHomes.allSatisfy({ self.amphipodPositions[$0] == amphipod })
							else  { continue }
					} else if occupiablePositions.contains(reachablePosition) {
						if position.y == 1 {
							continue
						}
					} else {
						continue
					}
					
					var amphipodPositions = amphipodPositions
					amphipodPositions.removeValue(forKey: position)
					amphipodPositions[reachablePosition] = amphipod
					
					let cost = steps * amphipod.energyLevel
					let newBoard = Board(
						allPoints: allPoints,
						occupiablePositions: occupiablePositions,
						amphipodPositions: amphipodPositions
					)
					dict[newBoard] = cost
				}
			}
		}
		
		var minimumEstimatedCost: Int {
			var cost = 0
			for amphipod in Amphipod.allCases {
				var homes = homes(for: amphipod)
				var locations = Set(amphipodPositions.filter({ $0.value == amphipod }).keys)
				
				let overlap = homes.reversed().prefix(while: locations.contains)
				homes.removeAll(where: overlap.contains)
				overlap.forEach { locations.remove($0) }
				
				for (location, home) in zip(locations, homes) {
					let distance: Int
					if location.y == 1 {
						distance = home.y - 1
							+ abs(location.x - home.x)
					} else {
						if location.x == home.x {
							distance = home.y + 2
						} else {
							distance = home.y + location.y - 2
								+ abs(location.x - home.x)
						}
					}
					cost += distance * amphipod.energyLevel
				}
			}
			
			return cost
		}

	}
	
	var allPoints: Set<Point> = []
	var occupiablePositions: Set<Point> = []
	var currentPods: [Point: Amphipod] = [:]

	input2
		.split(separator: "\n")
		.enumerated()
		.forEach { y, line in
			for (x, char) in line.enumerated() {
				if char == " " || char == "#" { continue }
				
				let point = Point(x: x, y: y)
				allPoints.insert(point)
				
				if char == "." {
					occupiablePositions.insert(point)
				} else if let amphipod = Amphipod(rawValue: char) {
					currentPods[point] = amphipod
				}
			}
		}

	occupiablePositions.remove(Point(x: 3, y: 1))
	occupiablePositions.remove(Point(x: 5, y: 1))
	occupiablePositions.remove(Point(x: 7, y: 1))
	occupiablePositions.remove(Point(x: 9, y: 1))

	var minCost = Int.max
	let initialBoard = Board(
		allPoints: allPoints,
		occupiablePositions: occupiablePositions,
		amphipodPositions: currentPods
	)
	var seenBoards = [initialBoard.amphipodPositions: 0]
	var currentBoards = [
		initialBoard: (0, initialBoard.minimumEstimatedCost)
	]
	
	while let (board, costs) = currentBoards.min(by: { ($0.value.1, $0.value.0) < ($1.value.1, $1.value.0) }) {
		currentBoards.removeValue(forKey: board)
		let cost = costs.0
		
		if let existing = seenBoards[board.amphipodPositions], existing < cost { continue }
		
		guard cost + costs.1 < minCost else { continue }
		
		for (nextBoard, newCost) in board.next() {
			let nextCost = cost + newCost
			
			guard nextCost < minCost else { continue }
			
			if nextBoard.amphipodPositions == finalPositions {
				minCost = min(minCost, nextCost)
				continue
			}
			
			if let existing = seenBoards[nextBoard.amphipodPositions], existing <= nextCost { continue }
			seenBoards[nextBoard.amphipodPositions] = nextCost
			currentBoards[nextBoard] = (nextCost, nextBoard.minimumEstimatedCost)
		}
	}

	return minCost.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
