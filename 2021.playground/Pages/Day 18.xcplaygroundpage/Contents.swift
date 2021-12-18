//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension Substring {
	mutating func popFirst(_ count: Int) -> Self {
		let result = self.prefix(count)
		self = self.dropFirst(count)
		return result
	}
}

indirect enum Snailfish: Equatable {
	case value(Int)
	case snailfish(SnailfishPair)
	
	var description: String {
		switch self {
		case .value(let value): return value.description
		case .snailfish(let snailfish): return snailfish.description
		}
	}
	
	var magnitude: Int {
		switch self {
		case .value(let value): return value
		case .snailfish(let snailfish): return snailfish.magnitude
		}
	}
	
	var copy: Self {
		switch self {
		case .value: return self
		case .snailfish(let snailfish): return .snailfish(snailfish.copy)
		}
	}
}

final class SnailfishPair: NSObject {
	var left: Snailfish {
		didSet {
			if case .snailfish(let nestedPair) = left {
				nestedPair.parent = self
			}
		}
	}
	var right: Snailfish {
		didSet {
			if case .snailfish(let nestedPair) = right {
				nestedPair.parent = self
			}
		}
	}
	
	weak var parent: SnailfishPair?
	
	var level: Int {
		guard let parent = parent else { return 0 }
		return parent.level + 1
	}
	
	init(left: Snailfish, right: Snailfish) {
		self.left = left
		self.right = right
		
		super.init()
		
		if case .snailfish(let nestedPair) = left {
			nestedPair.parent = self
		}
		if case .snailfish(let nestedPair) = right {
			nestedPair.parent = self
		}
	}
	
	override var description: String {
		return "[\(left.description),\(right.description)]"
	}
	
	var copy: SnailfishPair {
		SnailfishPair(left: left.copy, right: right.copy)
	}
	
	var magnitude: Int {
		3 * left.magnitude + 2 * right.magnitude
	}
	
	var hasLiteralValue: Bool {
		if case .value = left {
			return true
		}
		if case .value = right {
			return true
		}
		return false
	}
	
	var inorder: [SnailfishPair] {
		var leftInOrder: [SnailfishPair] {
			if case .snailfish(let pair) = left {
				return pair.inorder
			}
			return []
		}
		
		var rightInOrder: [SnailfishPair] {
			if case .snailfish(let pair) = right {
				return pair.inorder
			}
			
			return []
		}
		
		return leftInOrder + [self] + rightInOrder
	}
}

func parse(_ input: inout Substring) -> SnailfishPair {
	input.removeFirst()
	
	var left: Snailfish
	if input.first == "[" {
		left = .snailfish(parse(&input))
	} else {
		var number = 0
		while input.first!.isWholeNumber {
			number *= 10
			number += input.removeFirst().wholeNumberValue!
		}
		left = .value(number)
	}
	
	input.removeFirst()
	
	var right: Snailfish
	if input.first == "[" {
		right = .snailfish(parse(&input))
	} else {
		var number = 0
		while input.first!.isWholeNumber {
			number *= 10
			number += input.removeFirst().wholeNumberValue!
		}
		right = .value(number)
	}
	
	input.removeFirst()
	
	return SnailfishPair(left: left, right: right)
}

func explode(_ pair: SnailfishPair, in root: SnailfishPair) -> Bool {
	guard
		pair.level >= 4,
		case .value(let leftValue) = pair.left,
		case .value(let rightValue) = pair.right
		else { return false }
	
	let allNodes = root.inorder
	if let next = allNodes.drop(while: { $0 != pair }).dropFirst().first(where: { $0.hasLiteralValue }) {
		if case .value(let value) = next.left { next.left = .value(value + rightValue) }
		else if case .value(let value) = next.right { next.right = .value(value + rightValue) }
	}
	if let previous = allNodes.reversed().drop(while: { $0 != pair }).dropFirst().first(where: { $0.hasLiteralValue }) {
		if case .value(let value) = previous.right { previous.right = .value(value + leftValue) }
		else if case .value(let value) = previous.left { previous.left = .value(value + leftValue) }
	}
	
	if case .snailfish(pair) = pair.parent?.left {
		pair.parent?.left = .value(0)
	} else {
		pair.parent?.right = .value(0)
	}
	return true
}

func split(_ pair: SnailfishPair) -> Bool {
	if case .value(let value) = pair.left, value >= 10 {
		pair.left = .snailfish(
			SnailfishPair(
				left: .value(Int((Double(value) / 2).rounded(.down))),
				right: .value(Int((Double(value) / 2).rounded(.up)))
			)
		)
		return true
	} else if case .value(let value) = pair.right, value >= 10 {
		pair.right = .snailfish(
			SnailfishPair(
				left: .value(Int((Double(value) / 2).rounded(.down))),
				right: .value(Int((Double(value) / 2).rounded(.up)))
			)
		)
		return true
	}
	return false
}

func reduce(_ root: SnailfishPair) -> Bool {
	for pair in root.inorder {
		if explode(pair, in: root) {
			return true
		}
	}
	
	for pair in root.inorder {
		if split(pair) {
			return true
		}
	}
	
	return false
}

func fullyReduce(_ root: SnailfishPair) {
	while(reduce(root)) {}
}

func partOne() -> String {
	var inputSubstring = input.split(separator: "\n")[0]
	var root = parse(&inputSubstring)
	fullyReduce(root)
	
	for line in input.split(separator: "\n").dropFirst() {
		var copy = line
		let newRule = parse(&copy)
		root = SnailfishPair(left: .snailfish(root), right: .snailfish(newRule))
		fullyReduce(root)
	}
	
	return root.magnitude.description
}

func partTwo() -> String {
	let snailfishes = input
		.split(separator: "\n")
		.map { line -> SnailfishPair in
			var copy = line
			return parse(&copy)
		}
	
	var maxMagnitude = Int.min
	
	for snailfish in snailfishes {
		for other in snailfishes {
			guard snailfish != other else { continue }
			let root = SnailfishPair(left: .snailfish(snailfish.copy), right: .snailfish(other.copy))
			fullyReduce(root)
			maxMagnitude = max(maxMagnitude, root.magnitude)
		}
	}
	
	return maxMagnitude.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
