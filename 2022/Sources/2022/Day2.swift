import Algorithms
import Collections
import Foundation

fileprivate enum Move: Int {
	case rock = 1
	case paper = 2
	case scissor = 3
	
	init(_ c: Character) {
		switch c {
		case "A", "X": self = .rock
		case "B", "Y": self = .paper
		case "C", "Z": self = .scissor
		default: fatalError("Unexpected input")
		}
	}
	
	func winningMove() -> Move {
		Move(rawValue: rawValue == 3 ? 1 : rawValue + 1)!
	}
	
	func result(with other: Move) -> Winner {
		if self == other { return .draw }
		if self == other.winningMove() { return .you }
		return .other
	}
}

fileprivate enum Winner: Int {
	case you = 6
	case draw = 3
	case other = 0
	
	init(_ c: Character) {
		switch c {
		case "Z": self = .you
		case "Y": self = .draw
		case "X": self = .other
		default: fatalError("Unexpected input")
		}
	}
}

struct Day2: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n")
			.map { scorePart1(for: $0) }
			.reduce(0, +)
			.description
	}
	
	func scorePart1(for line: Substring) -> Int {
		let other = Move(line.first!)
		let you = Move(line.dropFirst(2).first!)
		return you.result(with: other).rawValue + you.rawValue
	}
	
	func partTwo() -> String {
		input
			.split(separator: "\n")
			.map { scorePart2(for: $0) }
			.reduce(0, +)
			.description
	}
	
	func scorePart2(for line: Substring) -> Int {
		let other = Move(line.first!)
		let result = Winner(line.dropFirst(2).first!)
		
		let yourScore: Int = {
			switch result {
			case .draw: return other.rawValue
			case .other: return other.winningMove().winningMove().rawValue
			case .you: return other.winningMove().rawValue
			}
		}()
		
		return yourScore + result.rawValue
	}
}
