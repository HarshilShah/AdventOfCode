import Foundation

let input = """
<Insert your input here>
"""

let totals = input
	.components(separatedBy: "\n\n")
	.map { line in
		line
			.split(separator: "\n")
			.map { Int($0)! }
			.reduce(0, +)
	}

func partOne() -> String {
	totals
		.max()!
		.description
}

func partTwo() -> String {
	totals
		.sorted(by: >)
		.prefix(3)
		.reduce(0, +)
		.description
}

print(partOne())
print(partTwo())
