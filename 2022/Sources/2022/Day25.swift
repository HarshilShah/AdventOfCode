import Algorithms
import Collections
import Foundation
import RegexBuilder

enum Snafu: Character {
	case minusTwo = "="
	case minusOne = "-"
	case zero = "0"
	case one = "1"
	case two = "2"
	
	var decimal: Int {
		switch self {
		case .minusTwo: return -2
		case .minusOne: return -1
		case .zero: return 0
		case .one: return 1
		case .two: return 2
		}
	}
	
	init?(decimal: Int) {
		switch decimal {
		case -2: self = .minusTwo
		case -1: self = .minusOne
		case 0: self = .zero
		case 1: self = .one
		case 2: self = .two
		default: return nil
		}
	}
}

extension Int {
	func snafu() -> [Snafu] {
		var places: [Int: Int] = [:]
		var place = 0
		var copy = self
		while copy != 0 {
			places[place] = copy.quotientAndRemainder(dividingBy: 5).remainder
			copy /= 5
			place += 1
		}
		
		let validDigits = -2 ... 2
		while places.values.contains(where: { validDigits.contains($0) == false }) {
			for (place, value) in places.sorted(by: { $0.key > $1.key }) {
				if validDigits.contains(value) {
					continue
				}
				
				if value == 3 {
					places[place] = -2
					places[place + 1, default: 0] += 1
				} else if value == 4 {
					places[place] = -1
					places[place + 1, default: 0] += 1
				} else {
					fatalError("Unexpected value, \(value)")
				}
			}
		}
		
		return places
			.sorted(by: { $0.key > $1.key })
			.map(\.value)
			.map { Snafu(decimal: $0)! }
	}
}

struct Day25: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n")
			.map(parseLine)
			.reduce(0, +)
			.snafu()
			.map(\.rawValue)
			.map(String.init)
			.joined()
			.description
	}
	
	func partTwo() -> String {
		"And We’re Done"
	}
	
	func parseLine(_ line: some StringProtocol) -> Int {
		var result = 0
		var multiplier = 1
		for snafu in line.map({ Snafu(rawValue: $0)! }).reversed() {
			result += multiplier * snafu.decimal
			multiplier *= 5
		}
		return result
	}
}
