//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

struct Pairing: Hashable {
	let first: Character
	let second: Character
	let isStarting: Bool
	let isEnding: Bool
	
	var isTerminal: Bool { isStarting || isEnding }
	
	var ruleText: [Character] { [first, second] }
}

let template = String(input.split(separator: "\n").first!)
let rules = input
	.split(separator: "\n")
	.dropFirst()
	.reduce(into: [[Character]: Character]()) { dict, line in
		let components = line.components(separatedBy: " -> ")
		dict[Array(components[0])] = components[1].first!
	}

let characterPairs = Array(zip(template, template.dropFirst()).enumerated())
let initialPairings = characterPairs.reduce(into: [Pairing: Int]()) { dict, tuple in
	let (index, (first, second)) = tuple
	let string = Pairing(
		first: first,
		second: second,
		isStarting: index == 0,
		isEnding: index == characterPairs.count - 1
	)
	dict[string, default: 0] += 1
}

func advance(pairings: inout [Pairing: Int]) {
	var newPairings: [Pairing: Int] = [:]
	
	pairings.forEach { pairing, count in
		guard let evaluated = rules[pairing.ruleText] else {
			newPairings[pairing, default: 0] += count
			return
		}
		
		let new = [
			Pairing(first: pairing.first, second: evaluated, isStarting: pairing.isStarting, isEnding: false),
			Pairing(first: evaluated, second: pairing.second, isStarting: false, isEnding: pairing.isEnding)
		]
		new.forEach { newPairings[$0, default: 0] += count }
	}
	
	pairings = newPairings
}

func score(for pairings: [Pairing: Int]) -> Int {
	var counts = pairings.reduce(into: [Character: Int]()) { dict, tuple in
		let (key, value) = tuple
		guard key.isTerminal == false else { return }
		dict[key.first, default: 0] += value
		dict[key.second, default: 0] += value
	}
	
	/// Non-terminal values are counted twice, as part of two pariings
	counts = counts.mapValues { $0 / 2 }
	
	pairings.forEach { key, value in
		guard key.isTerminal else { return }
		counts[key.first, default: 0] += value
		counts[key.second, default: 0] += value
	}
	
	return counts.values.max()! - counts.values.min()!
}

func partOne() -> String {
	var pairings = initialPairings
	for _ in (1 ... 10) { advance(pairings: &pairings) }
	return score(for: pairings).description
}

func partTwo() -> String {
	var pairings = initialPairings
	for _ in (1 ... 40) { advance(pairings: &pairings) }
	return score(for: pairings).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
