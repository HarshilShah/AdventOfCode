import Algorithms
import Collections
import Foundation
import RegexBuilder

extension ComparisonResult {
	static func comparing<C: Comparable>(_ a: C, b: C) -> ComparisonResult {
		if a == b { return .orderedSame }
		return a < b ? .orderedAscending : .orderedDescending
	}
}

struct Packet: Hashable, CustomStringConvertible {
	var items: [PacketItem]
	
	func compared(with other: Packet) -> ComparisonResult {
		
		for (i1, i2) in zip(items, other.items) {
			let result = i1.compared(with: i2)
			if result != .orderedSame {
				return result
			}
		}
		
		return .comparing(items.count, b: other.items.count)
	}
	
	static func parse(_ line: Substring) -> Packet {
		var copy = line
		return Packet(items: Packet.parse(&copy))
	}
	
	static func parse(_ line: inout Substring) -> [PacketItem] {
		var current: Int?
		var items: [PacketItem] = []
		
		var offset = 0
		
		while true {
			defer { offset += 1 }
			
			let char = line.dropFirst(offset).first!
			
			if let wholeNumber = char.wholeNumberValue {
				if current == nil {
					current = 0
				} else {
					current! *= 10
				}
				current! += wholeNumber
			} else {
				if let c = current {
					items.append(.integer(c))
					current = nil
				}
				
				if char == "[" {
					if offset == 0 { continue }
					line = line.dropFirst(offset)
					items.append(.packet(Packet(items: parse(&line))))
					offset = 0
				} else if char == "]" {
					line = line.dropFirst(offset)
					return items
				}
			}
		}
	}
	
	var description: String {
		return "[" +  items.map(\.description).joined(separator: ",") + "]"
	}
}

enum PacketItem: Hashable, CustomStringConvertible {
	case integer(Int)
	case packet(Packet)
	
	func compared(with other: PacketItem) -> ComparisonResult {
		switch (self, other) {
		case let (.integer(i1), .integer(i2)):
			return .comparing(i1, b: i2)
			
		case let (.packet(p1), .packet(p2)):
			return p1.compared(with: p2)
			
		case let (.integer(i), .packet(p)):
			return Packet(items: [.integer(i)]).compared(with: p)
			
		case let (.packet(p), .integer(i)):
			return p.compared(with: Packet(items: [.integer(i)]))
		}
	}
	
	var description: String {
		switch self {
		case .integer(let int): return int.description
		case .packet(let packet): return packet.description
		}
	}
}

struct Day13: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		input
			.split(separator: "\n", omittingEmptySubsequences: true)
			.map(Packet.parse)
			.chunks(ofCount: 2)
			.enumerated()
			.filter { $0.element.first!.compared(with: $0.element.last!) != .orderedDescending }
			.map { $0.offset + 1 }
			.reduce(0, +)
			.description
	}
	
	func partTwo() -> String {
		let interlaced = [
			Packet.parse("[[2]]"),
			Packet.parse("[[6]]")
		]
		
		var all = input
			.split(separator: "\n", omittingEmptySubsequences: true)
			.map(Packet.parse)
		all.append(contentsOf: interlaced)
		
		all.sort(by: { $0.compared(with: $1) != .orderedDescending })
		
		let i1 = all.firstIndex(of: interlaced[0])! + 1
		let i2 = all.firstIndex(of: interlaced[1])! + 1
		
		return (i1 * i2).description
	}
}
