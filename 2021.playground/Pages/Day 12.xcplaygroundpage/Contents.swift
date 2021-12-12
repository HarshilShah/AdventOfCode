//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

let connections = input
	.split(separator: "\n")
	.reduce(into: [Substring: Set<Substring>]()) { dict, line in
		let components = line.split(separator: "-")
		dict[components[0], default: []].insert(components[1])
		dict[components[1], default: []].insert(components[0])
	}

func partOne() -> String {
	var successfulPaths = 0
	var paths: [[Substring]] = [["start"]]
	
	while let path = paths.popLast() {
		let visitedSmallCaves = path.filter { $0.allSatisfy(\.isLowercase) }
		var nextDestinations = connections[path.last!]!
		nextDestinations.subtract(visitedSmallCaves)
		nextDestinations.remove("start")
		if nextDestinations.contains("end") {
			nextDestinations.remove("end")
			successfulPaths += 1
		}
		let newPaths = nextDestinations.map { path + [$0] }
		paths.append(contentsOf: newPaths)
	}
	
	return successfulPaths.description
}

func partTwo() -> String {
	struct Path {
		var caves: [Substring]
		var hasVisitedASmallCaveTwice: Bool
	}
	
	var successfulPaths = 0
	var paths: [Path] = [Path(caves: ["start"], hasVisitedASmallCaveTwice: false)]
	
	while let path = paths.popLast() {
		let visitedSmallCaves = path.caves.lazy.filter { $0.allSatisfy(\.isLowercase) }
		
		var nextDestinations = connections[path.caves.last!]!
		nextDestinations.remove(path.caves.last!)
		if path.hasVisitedASmallCaveTwice {
			nextDestinations.subtract(visitedSmallCaves)
		}
		nextDestinations.remove("start")
		if nextDestinations.contains("end") {
			nextDestinations.remove("end")
			successfulPaths += 1
		}
		let newPaths = nextDestinations.map {
			Path(
				caves: path.caves + [$0],
				hasVisitedASmallCaveTwice: path.hasVisitedASmallCaveTwice || visitedSmallCaves.contains($0)
			)
		}
		paths.append(contentsOf: newPaths)
	}
	
	return successfulPaths.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
