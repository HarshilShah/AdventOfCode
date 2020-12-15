import Foundation

let input = """
0,12,6,13,20,1,17
"""

struct Times {
	let penultimate: Int?
	let last: Int
}

func number(at lastTurn: Int) -> String {
	var turn = 0
	var nextNumber = 0
	var spokenNumbers: [Int: (Times)] = [:]
	
	input
		.split(separator: ",")
		.lazy
		.map { Int($0)! }
		.forEach { value in
			if let newPenultimate = spokenNumbers[value]?.last {
				nextNumber = turn - newPenultimate
				spokenNumbers[value] = Times(penultimate: newPenultimate, last: turn)
			} else {
				nextNumber = 0
				spokenNumbers[value] = Times(penultimate: nil, last: turn)
			}
			turn += 1
		}
	
	while turn != lastTurn - 1 {
		if let newPenultimate = spokenNumbers[nextNumber]?.last {
			spokenNumbers[nextNumber] = Times(penultimate: newPenultimate, last: turn)
			nextNumber = turn - newPenultimate
		} else {
			spokenNumbers[nextNumber] = Times(penultimate: nil, last: turn)
			nextNumber = 0
		}
		
		turn += 1
	}

	return nextNumber.description
}

func partOne() -> String {
	number(at: 2020)
}

func partTwo() -> String {
	number(at: 30_000_000)
}

print(partOne())
print(partTwo())
