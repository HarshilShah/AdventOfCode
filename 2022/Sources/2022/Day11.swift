import Algorithms
import Collections
import Foundation

struct Monkey: Hashable {
	var index: Int
	var items: [Int]
	
	var operationIsAdd: Bool
	var operatorIsOld: Bool
	var operatorLiteral: Int
	
	var test: Int
	var testTrue: Int
	var testFalse: Int
}

struct Day11: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		solve(rounds: 20, shouldReduceWorries: true)
			.description
	}
	
	func partTwo() -> String {
		solve(rounds: 10_000, shouldReduceWorries: false)
			.description
	}
	
	func solve(rounds: Int, shouldReduceWorries: Bool) -> Int {
		var monkeys = input
			.components(separatedBy: "\n\n")
			.map { parseMonkey($0) }
		
		let divisor = monkeys.map(\.test).reduce(1, *)
		
		var inspections: [Int: Int] = [:]
		
		for _ in 1 ... rounds {
			for i in monkeys.indices {
				while var item = monkeys[i].items.first {
					let c = monkeys[i]
					monkeys[i].items.removeFirst()
					
					item = {
						let operand = c.operatorIsOld ? item : c.operatorLiteral
						return c.operationIsAdd ? item + operand : item * operand
					}()
					
					if shouldReduceWorries {
						item = item / 3
					} else {
						item = item % divisor
					}
					
					if item.isMultiple(of: c.test) {
						monkeys[c.testTrue].items.append(item)
					} else {
						monkeys[c.testFalse].items.append(item)
					}
					
					inspections[i, default: 0] += 1
				}
			}
		}
		
		return inspections.values.max(count: 2).reduce(1, *)
	}
	
	func parseMonkey(_ text: String) -> Monkey {
		let lines = text.split(separator: "\n")
		return Monkey(
			index: Int(lines[0].split(separator: " ").last!.dropLast(1))!,
			items: lines[1].split(whereSeparator: { $0.isNumber == false }).map { Int($0)! },
			operationIsAdd: lines[2].contains("+"),
			operatorIsOld: lines[2].hasSuffix("old"),
			operatorLiteral: lines[2].hasSuffix("old") ? 1 : Int(lines[2].split(separator: " ").last!)!,
			test: Int(lines[3].split(separator: " ").last!)!,
			testTrue: Int(lines[4].split(separator: " ").last!)!,
			testFalse: Int(lines[5].split(separator: " ").last!)!
		)
	}
}
