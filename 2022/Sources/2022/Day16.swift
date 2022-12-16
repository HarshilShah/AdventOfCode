import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate extension StringProtocol {
	var integers: [Int] {
		return self
			.split{ "-0123456789".contains($0) == false }
			.map { Int($0)! }
	}
}

func + <T>(el: T, arr: [T]) -> [T] {
	var ret = arr
	ret.insert(el, at: 0)
	return ret
}

func cartesianProduct<T>(_ arrays: [[T]]) -> [[T]] {
	guard let head = arrays.first else {
		return []
	}
	let first = Array(head)
	func pel(
		_ el: T,
		_ ll: [[T]],
		_ a: [[T]] = []
		) -> [[T]] {
		switch ll.count {
		case 0:
			return a.reversed()
		case _:
			let tail = Array(ll.dropFirst())
			let head = ll.first!

			return pel(el, tail, el + head + a)
		}
	}
	return arrays.reversed()
		.reduce([first], {res, el in el.flatMap({ pel($0, res) }) })
		.map({ $0.dropLast(first.count) })
}


struct Valve: Hashable {
	var name: String
	var flowRate: Int
	var destinations: [String]
}

struct Path: Hashable {
	var currentPosition: Valve
	var timestamp: Int
	var valves: [Valve: Int]
	
	var score: Int {
		valves.reduce(into: 0) { score, tuple in
			score += tuple.key.flowRate * (30 - tuple.value)
		}
	}
}

struct Route: Hashable {
	var valve: Valve
	var timestamp: Int
}

struct Path2: Hashable {
	var currentPositions: [Route]
	var valves: [Valve: Int]
	
	var score: Int {
		valves.reduce(into: 0) { score, tuple in
			score += tuple.key.flowRate * (26 - tuple.value)
		}
	}
}

struct Day16: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let valves = input
			.split(separator: "\n")
			.map { parseLine(String($0)) }
			.reduce(into: [String: Valve]()) { dict, tuple in
				dict[tuple.0] = tuple.1
			}
		
		let shortestPaths = generateShortestPaths(from: valves)
		
		let starting = Path(
			currentPosition: valves["AA"]!,
			timestamp: 0,
			valves: [:]
		)
		
		struct Visit: Hashable {
			var current: String
			var valves: Set<String>
		}
		
		var visited: [Visit: (score: Int, timestamp: Int)] = [:]
		var paths: [Int: Set<Path>] = [0 : [starting]]
		var maxScore = 0
		
		while let score = paths.keys.max() {
			guard let path = paths[score]?.popFirst() else {
				paths.removeValue(forKey: score)
				continue
			}
			
			paths[score]?.remove(path)
			
			let visit = Visit(
				current: path.currentPosition.name,
				valves: Set(path.valves.keys.map(\.name))
			)
			
			if let existing = visited[visit] {
				if existing.score > path.score {
					continue
				} else if existing.score == path.score {
					if existing.timestamp < path.timestamp {
						continue
					}
				}
			}
			visited[visit] = (path.score, path.timestamp)
			
			for (nextValve, steps) in shortestPaths[path.currentPosition]! {
				if path.valves.keys.contains(nextValve) { continue }
				if nextValve.flowRate == 0 { continue }
				if path.timestamp + steps + 1 > 30 { continue }
				
				var newPath = path
				newPath.currentPosition = nextValve
				newPath.timestamp += steps + 1
				newPath.valves[nextValve] = newPath.timestamp
				
				maxScore = max(maxScore, newPath.score)
				paths[newPath.score, default: []].insert(newPath)
			}
		}
		
		return maxScore.description
	}
	
	func partTwo() -> String {
		let valves = input
			.split(separator: "\n")
			.map { parseLine(String($0)) }
			.reduce(into: [String: Valve]()) { dict, tuple in
				dict[tuple.0] = tuple.1
			}
		
		let shortestPaths = generateShortestPaths(from: valves)
		
		let starting = Path2(
			currentPositions: [
				Route(valve: valves["AA"]!, timestamp: 0),
				Route(valve: valves["AA"]!, timestamp: 0)
			],
			valves: [:]
		)
		
		struct Visit: Hashable {
			var current: Set<Route>
			var valves: Set<String>
		}
		
		var visited: [Visit: Int] = [:]
		
		var paths: [Int: Set<Path2>] = [0 : [starting]]
		var maxScore = 0 {
			didSet {
				if maxScore > oldValue {
					print("New Max Score:", maxScore)
				}
			}
		}
		
		let timeLimit = 26
		
		while let projectedScore = paths.keys.max() {
			guard let path = paths[projectedScore]?.popFirst() else {
				paths.removeValue(forKey: projectedScore)
				continue
			}
			
			paths[projectedScore]?.remove(path)
			
			let visit = Visit(
				current: Set(path.currentPositions),
				valves: Set(path.valves.keys.map(\.name))
			)

			if let existingScore = visited[visit], existingScore >= path.score {
				continue
			}

			visited[visit] = path.score
			
			let nextRoutesPerPosition = path.currentPositions
				.map { route -> [Route] in
					let next = shortestPaths[route.valve]!
						.filter { nextValve, steps in
							if path.valves.keys.contains(nextValve) { return false }
							if nextValve.flowRate == 0 { return false }
							if route.timestamp + steps + 1 > timeLimit { return false }
							return true
						}
						.map { Route(valve: $0.key, timestamp: route.timestamp + $0.value + 1) }
					
					return next.isEmpty ? [route] : next
				}
			
			for nextRoutes in cartesianProduct(nextRoutesPerPosition) {
				if Set(nextRoutes.map(\.valve).map(\.name)).count != nextRoutes.count {
					continue
				}
				
				if nextRoutes == path.currentPositions {
					continue
				}
				
				var newPath = path
				newPath.currentPositions = nextRoutes
				nextRoutes.forEach { route in
					newPath.valves[route.valve] = route.timestamp
				}
				
				maxScore = max(maxScore, newPath.score)
				paths[newPath.score, default: []].insert(newPath)
			}
		}
		
		return maxScore.description
	}
	
	func parseLine(_ line: String) -> (String, Valve) {
		let name = String(line.dropFirst(6).prefix(2))
		let flowRate = line.integers.first!
		let destinations = line
			.suffix(while: { $0.isLowercase == false })
			.dropFirst()
			.components(separatedBy: ", ")
		return (name, Valve(name: name, flowRate: flowRate, destinations: destinations))
	}
	
	func generateShortestPaths(from valves: [String: Valve]) -> [Valve: [Valve: Int]] {
		var shortestPaths: [Valve: [Valve: Int]] = [:]
		for (_, valve) in valves {
			var localShortestPaths: [Valve: Int] = [:]
			var queue = Deque(valve.destinations.map { (valve: valves[$0]!, steps: 1) })
			while let destination = queue.popFirst() {
				if localShortestPaths.keys.contains(destination.valve) {
					continue
				}
				
				localShortestPaths[destination.valve] = destination.steps
				
				if localShortestPaths.count == valves.count {
					break
				}
				
				for next in destination.valve.destinations.map({ valves[$0]! }) {
					queue.append((next, destination.steps + 1))
				}
			}
			shortestPaths[valve] = localShortestPaths
		}
		return shortestPaths
	}
}
