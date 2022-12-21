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

fileprivate enum Rock: String, CaseIterable, Hashable {
	case geode, clay, obsidian, ore
}

fileprivate struct RockQuantity: Hashable {
	var rock: Rock
	var quantity: Int
}

fileprivate struct Blueprint: Hashable {
	var index: Int
	var costs: [Rock: Set<RockQuantity>] = [:]
}

fileprivate struct Game: Hashable {
	var timestamp = 0
	var ores: [Rock: Int] = [:]
	var robots: [Rock: Int] = [.ore: 1]
	
	func clamped(to requirements: [Rock: Int]) -> Game {
		var copy = self
		ores.forEach { rock, quantity in
			copy.ores[rock] = min(quantity, requirements[rock]! + 1)
		}
		return copy
	}
}

struct Day19: Day {
	var input: String
	var debugMode = false
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n")
			.map(parseBlueprint)
			.map { $0.index * mostGeodes(from: $0, steps: 24) }
			.reduce(0, +)
			.description
	}
	
	func partTwo() -> String {
		input
			.split(separator: "\n")
			.map(parseBlueprint)
			.prefix(3)
			.map { mostGeodes(from: $0, steps: 32) }
			.reduce(1, *)
			.description
	}
	
	fileprivate func parseBlueprint(_ line: some StringProtocol) -> Blueprint {
		let index = line.integers.first!
		var blueprint = Blueprint(index: index)
		
		for term in line.components(separatedBy: "Each ").dropFirst() {
			let words = term.split(separator: " ")
			let rock = Rock(rawValue: String(words.first!))!
			
			var quantity: Int? = 0
			for word in words.dropFirst(3) {
				if let number = Int(word) {
					quantity = number
				} else if let q = quantity {
					blueprint.costs[rock, default: []].insert(
						RockQuantity(
							rock: Rock(rawValue: String(word.trimmingCharacters(in: .punctuationCharacters)))!,
							quantity: q
						)
					)
					quantity = nil
				}
			}
		}
		
		return blueprint
	}
	
	fileprivate func mostGeodes(from blueprint: Blueprint, steps: Int) -> Int {
		if debugMode {
			print("Blueprint", blueprint.index)
		}
		
		var maxNeeded = blueprint.costs.reduce(into: [Rock: Int]()) { dict, tuple in
			for needed in tuple.value {
				dict[needed.rock] = max(needed.quantity, dict[needed.rock, default: 0])
			}
		}
		maxNeeded[.geode] = 20000
		
		var maxGeodes = 0 {
			didSet {
				if debugMode, maxGeodes != oldValue {
					print("New max geodes:", maxGeodes)
				}
			}
		}
		
		var queue = Deque([Game()])
		var visited: Set<Game> = []
		
		while let game = queue.popFirst() {
			if visited.insert(game).inserted == false {
				continue
			}
			
			let remainingTime = steps - game.timestamp
			
			let maxPotential = game.ores[.geode, default: 0]
				+ game.robots[.ore, default: 0] * remainingTime
				+ ((remainingTime * remainingTime) / 2)
			if maxPotential < maxGeodes {
				continue
			}
			
			if let geodes = game.ores[.geode] {
				maxGeodes = max(maxGeodes, geodes)
			}
			
			if game.timestamp == steps {
				continue
			}
			
			for robotToBuild in Rock.allCases {
				let cost = blueprint.costs[robotToBuild]!
				
				let canBuild = cost.allSatisfy { rq in
					game.ores[rq.rock, default: 0] >= rq.quantity
				}
				
				let isNeeded = game.robots[robotToBuild, default: 0] < maxNeeded[robotToBuild]!
				
				guard canBuild, isNeeded else { continue }
				
				var newGame = game
				newGame.timestamp += 1
				for rq in cost {
					newGame.ores[rq.rock]! -= rq.quantity
				}
				newGame.robots.forEach { rock, quantity in
					newGame.ores[rock, default: 0] += quantity
				}
				newGame.robots[robotToBuild, default: 0] += 1
				queue.append(newGame)
			}
			
			var newGame = game
			newGame.timestamp += 1
			newGame.robots.forEach { rock, quantity in
				newGame.ores[rock, default: 0] += quantity
			}
			newGame = newGame.clamped(to: maxNeeded)
			queue.append(newGame)
		}
		
		return maxGeodes
	}
}
