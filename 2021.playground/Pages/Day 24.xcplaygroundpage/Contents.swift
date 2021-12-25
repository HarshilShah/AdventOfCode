//: [Previous](@previous)

import Foundation

func solve(input: [Int]) -> Int {
	let z0 = input[0] + 15
	let z1 = 26 * z0 + input[1] + 10
	let z2 = 26 * z1 + input[2] + 2
	let z3 = 26 * z2 + input[3] + 16
	
	let m4 = (input[3] + 4 == input[4]) ? 1 : 26
	let c4 = (input[3] + 4 == input[4]) ? 0 : input[4] + 12
	let z4 = m4 * (z3/26) + c4
	
	let z5 = (26 * z4) + input[5] + 11
	
	let m6 = input[5] + 2 == input[6] ? 1 : 26
	let c6 = input[5] + 2 == input[6] ? 0 : input[6] + 5
	let z6 = m6 * (z5/26) + c6
	if z6 >= 27*26*26 { return 6 }
	
	let z7 = 26 * z6 + input[7] + 16
	let z8 = 26 * z7 + input[8] + 6
	if z8 >= 27*26*26*26*26 { return 8 }
	
	let m9 = (z8 % 26) - 14 == input[9] ? 1 : 26
	let c9 = (z8 % 26) - 14 == input[9] ? 0 : input[9] + 15
	let z9 = m9 * (z8/26) + c9
	if z9 >= 27*26*26*26 { return 9 }
	
	let m10 = (z9 % 26) - 11 == input[10] ? 1 : 26
	let c10 = (z9 % 26) - 11 == input[10] ? 0 : input[10] + 3
	let z10 = m10 * (z9/26) + c10
	if z10 >= 27*26*26 { return 10 }
	
	let m11 = (z10 % 26) - 2 == input[11] ? 1 : 26
	let c11 = (z10 % 26) - 2 == input[11] ? 0 : input[11] + 12
	let z11 = m11 * (z10/26) + c11
	
	if z11 >= 27*26 { return 11 }
	
	let m12 = (z11 % 26) - 16 == input[12] ? 1 : 26
	let c12 = (z11 % 26) - 16 == input[12] ? 0 : input[12] + 10
	let z12 = m12 * (z11/26) + c12
	if z12 >= 27 { return 12 }
	
	let m13 = (z12 % 26) - 14 == input[13] ? 1 : 26
	let c13 = (z12 % 26) - 14 == input[13] ? 0 : input[13] + 13
	let z13 = m13 * (z12/26) + c13
	
	if z13 == 0 { return 0 }
	
	return 13
}

func partOne() -> String {
	var input = Array(repeating: 9, count: 14)
	
	while true {
		let failingIndex = solve(input: input)
		
		if failingIndex == 0 {
			break
		}
		
		var index = 13
		while index != failingIndex {
			input[index] = 9
			index -= 1
		}
		
		while true {
			input[index] -= 1
			if input[index] == 0 {
				input[index] = 9
				index -= 1
			} else {
				break
			}
		}
	}
	
	return input.map(\.description).joined()
}

func partTwo() -> String {
	var input = Array(repeating: 1, count: 14)
	
	while true {
		let failingIndex = solve(input: input)
		
		if failingIndex == 0 {
			break
		}
		
		var index = 13
		while index != failingIndex {
			input[index] = 1
			index -= 1
		}
		
		while true {
			input[index] += 1
			if input[index] == 10 {
				input[index] = 1
				index -= 1
			} else {
				break
			}
		}
	}
	
	return input.map(\.description).joined()
}

print(partOne())
print(partTwo())

//: [Next](@next)
