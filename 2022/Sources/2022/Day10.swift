import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Day10: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		var deltas = parseDeltas()
		
		var x = 1
		var result = 0
		
		for step in 0... {
			if deltas.isEmpty { break }
			
			if (step - 20).quotientAndRemainder(dividingBy: 40).remainder == 0 {
				result += x * step
			}
			
			if let delta = deltas.removeValue(forKey: step) {
				x += delta
			}
		}
		
		return result.description
	}
	
	func partTwo() -> String {
		let deltas = parseDeltas()
		
		var x = 1
		var result = ""
		
		for step in 0 ..< 240 {
			if step.isMultiple(of: 40) {
				result.append("\n")
			}
			
			if let delta = deltas[step] {
				x += delta
			}
			
			let xValue = step.quotientAndRemainder(dividingBy: 40).remainder
			
			if abs(x - xValue) <= 1 {
				result.append("⬛️")
			} else {
				result.append("⬜️")
			}
		}
		
		return result
	}
	
	func parseDeltas() -> [Int: Int] {
		var deltas: [Int: Int] = [:]
		
		var cycle = 0
		
		for line in input.split(separator: "\n") {
			guard line.starts(with: "addx") else {
				cycle += 1
				continue
			}
			
			cycle += 2
			deltas[cycle] = Int(line.split(separator: " ").last!)
		}
		
		return deltas
	}
}
