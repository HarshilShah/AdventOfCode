import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Day5: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let components = input.components(separatedBy: "\n\n")
		var stacks = parseStacks(from: components.first!)
		let instructions = parseInstructions(from: components.last!)
		
		for (count, from, to) in instructions {
			for _ in 1 ... count {
				let value = stacks[from]!.popLast()!
				stacks[to]?.append(value)
			}
		}
		
		return stacks.keys
			.sorted()
			.map { String(stacks[$0]!.last!) }
			.joined()
	}
	
	func partTwo() -> String {
		let components = input.components(separatedBy: "\n\n")
		var stacks = parseStacks(from: components.first!)
		let instructions = parseInstructions(from: components.last!)
		
		for (count, from, to) in instructions {
			let values = stacks[from]!.suffix(count)
			stacks[from]!.removeLast(count)
			stacks[to]!.append(contentsOf: values)
		}
		
		return stacks.keys
			.sorted()
			.map { String(stacks[$0]!.last!) }
			.joined()
	}
	
	func parseStacks(from input: String) -> [Int: [Character]] {
		input
			.split(separator: "\n")
			.reduce(into: [Int: [Character]]()) { stacks, line in
				for (i, c) in line.enumerated() {
					guard c.isLetter else { continue }
					let stackNumber = (i / 4) + 1
					stacks[stackNumber, default: []].insert(c, at: 0)
				}
			}
	}
	
	func parseInstructions(from input: String) -> [(count: Int, from: Int, to: Int)] {
		input
			.split(separator: "\n")
			.map { line in
				let numbers = Capture { OneOrMore(.digit) }
					transform: { Int($0)! }
				
				let lineParser = Regex {
					"move "
					numbers
					" from "
					numbers
					" to "
					numbers
				}
				
				let match = try! lineParser.wholeMatch(in: line)!.output
				return (match.1, match.2, match.3)
			}
	}
}
