//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension Int {
	func binary(minLength: Int = 4) -> [Bool] {
		var result: [Bool] = []
		var copy = self
		while copy > 0 {
			result.append(copy % 2 == 1)
			copy /= 2
		}
		result.append(contentsOf: Array(repeating: false, count: 4 - result.count))
		return result.reversed()
	}
}

extension Sequence where Element == Bool {
	var int: Int {
		var result = 0
		for element in self {
			result *= 2
			result += element ? 1 : 0
		}
		return result
	}
}

extension ArraySlice {
	mutating func popFirst(_ count: Int) -> Self {
		let result = self.prefix(count)
		self = self.dropFirst(count)
		return result
	}
}

struct Packet {
	var version: Int
	var id: Int
	var result: Int
	var subpackets: [Packet] = []
	
	var versionTotal: Int {
		version + subpackets.map(\.versionTotal).reduce(0, +)
	}
}

let bits = input
	.map { $0.hexDigitValue! }
	.flatMap { $0.binary() }

func parse(bits: inout ArraySlice<Bool>) -> Packet {
	let version = bits.popFirst(3).int
	let id = bits.popFirst(3).int
	
	if id == 4 {
		var literalBits: [Bool] = []
		while bits.first != false {
			literalBits.append(contentsOf: bits.popFirst(5).dropFirst())
		}
		literalBits.append(contentsOf: bits.popFirst(5).dropFirst())
		return Packet(version: version, id: id, result: literalBits.int)
	}
	
	var subpackets: [Packet] = []
	
	let lengthId = bits.removeFirst()
	if lengthId {
		let numberOfSubpackets = bits.popFirst(11).int
		for _ in 0 ..< numberOfSubpackets {
			subpackets.append(parse(bits: &bits))
		}
	} else {
		let subpacketLength = bits.popFirst(15).int
		let targetCount = bits.count - subpacketLength
		while bits.count != targetCount {
			subpackets.append(parse(bits: &bits))
		}
	}
	
	let values = subpackets.lazy.map(\.result)
	
	let result: Int = {
		switch id {
		case 0: return values.reduce(0, +)
		case 1: return values.reduce(1, *)
		case 2: return values.min()!
		case 3: return values.max()!
		case 5: return values[0] > values[1] ? 1 : 0
		case 6: return values[0] < values[1] ? 1 : 0
		case 7: return values[0] == values[1] ? 1 : 0
		default: fatalError("Unexpected input")
		}
	}()
	
	return Packet(version: version, id: id, result: result, subpackets: subpackets)
}

var bitSlice = bits[...]
let packet = parse(bits: &bitSlice)

func partOne() -> String {
	packet.versionTotal.description
}

func partTwo() -> String {
	packet.result.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
