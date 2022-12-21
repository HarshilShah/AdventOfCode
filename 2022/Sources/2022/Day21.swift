import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate extension StringProtocol {
	var integers: [Int] {
		return self
			.split{ "-0123456789".contains($0) == false }
			.compactMap { Int($0) }
	}
}

fileprivate enum Yell: Hashable {
	case int(Int)
	case operation(String, String, String)
}

fileprivate struct Monkey: Hashable {
	var name: String
	var yell: Yell
	
	var int: Int? {
		switch yell {
		case .int(let int): return int
		case .operation: return nil
		}
	}
}

struct Day21: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let monkeys = input
			.split(separator: "\n")
			.map(parseMonkey)
		
		let solved = monkeys.reduce(into: [String: Int]()) { dict,  monkey in
			switch monkey.yell {
			case .int(let int): dict[monkey.name] = int
			case .operation: return
			}
		}
		
		return rootValue(
			monkeys: monkeys,
			solved: solved,
			shouldReturnRootDifference: false
		)
		.description
	}
	
	func partTwo() -> String {
		let monkeys = input
			.split(separator: "\n")
			.map(parseMonkey)
		
		var bounds = 0 ... 13429411069028
		
		var solved = monkeys.reduce(into: [String: Int]()) { dict,  monkey in
			switch monkey.yell {
			case .int(let int): dict[monkey.name] = int
			case .operation: return
			}
		}
		
		while bounds.lowerBound != bounds.upperBound {
			let candidate = bounds.lowerBound + bounds.count/2
			solved["humn"] = candidate
			let delta = rootValue(
				monkeys: monkeys,
				solved: solved,
				shouldReturnRootDifference: true
			)
			
			if delta == 0 {
				return candidate.description
			} else if delta > 1 {
				bounds = bounds.lowerBound ... candidate
			} else {
				bounds = candidate ... bounds.upperBound
			}
		}
		
		return bounds.lowerBound.description
	}
	
	fileprivate func parseMonkey(_ line: some StringProtocol) -> Monkey {
		let name = String(line.prefix(4))
		let yell: Yell = {
			if let number = line.integers.first {
				return .int(number)
			} else {
				let values = line.dropFirst(6).components(separatedBy: " ")
				return .operation(values[0], values[1], values[2])
			}
		}()
		return Monkey(name: name, yell: yell)
	}
	
	fileprivate func rootValue(
		monkeys: [Monkey],
		solved: [String: Int],
		shouldReturnRootDifference: Bool
	) -> Int {
		var solved = solved
		
		while solved.count != monkeys.count {
			for monkey in monkeys {
				if solved[monkey.name] != nil {
					continue
				}
				
				switch monkey.yell {
				case .int: continue
				case .operation(let a, let op, let b):
					guard let first = solved[a], let second = solved[b] else {
						continue
					}
					
					if shouldReturnRootDifference, monkey.name == "root" {
						return first - second
					}
					
					solved[monkey.name] = {
						switch op {
						case "+": return first + second
						case "-": return first - second
						case "*": return first * second
						case "/": return first / second
						default: fatalError("Unexpected input")
						}
					}()
				}
			}
		}
		
		return solved["root"]!
	}
}
