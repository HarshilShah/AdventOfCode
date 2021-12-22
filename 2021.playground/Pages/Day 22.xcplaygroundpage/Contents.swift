//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension StringProtocol {
	var numbers: [Int] {
		split(whereSeparator: { "-0123456789".contains($0) == false })
			.map { Int($0)! }
	}
}

extension ClosedRange {
	func isSuperset(of other: Self) -> Bool {
		return lowerBound <= other.lowerBound && upperBound >= other.upperBound
	}
}

extension ClosedRange where Bound == Int {
	func split(over other: Self) -> Set<Self> {
		if other.isSuperset(of: self) {
			return [self]
		} else if lowerBound < other.lowerBound, upperBound > other.upperBound {
			return [
				(lowerBound ... other.lowerBound - 1),
				other,
				(other.upperBound + 1 ... upperBound)
			]
		} else if other.lowerBound <= lowerBound {
			return [(lowerBound ... other.upperBound), (other.upperBound + 1 ... upperBound)]
		} else {
			return [(lowerBound ... other.lowerBound - 1), (other.lowerBound ... upperBound)]
		}
	}
	
	var magnitude: Int { abs(upperBound - lowerBound + 1) }
}

struct Cuboid: Hashable {
	var x: ClosedRange<Int>
	var y: ClosedRange<Int>
	var z: ClosedRange<Int>
}

extension Cuboid {
	init(line: Substring) {
		let numbers = line.numbers
		x = numbers[0] ... numbers[1]
		y = numbers[2] ... numbers[3]
		z = numbers[4] ... numbers[5]
	}
	
	var points: Int { x.magnitude * y.magnitude * z.magnitude }
	
	static let small = Cuboid(x: -50 ... 50, y: -50 ... 50, z: -50 ... 50)
	var isSmall: Bool { Cuboid.small.isSuperset(of: self) }
	
	func isSuperset(of other: Cuboid) -> Bool {
		x.isSuperset(of: other.x)
		&& y.isSuperset(of: other.y)
		&& z.isSuperset(of: other.z)
	}
	
	func intersects(with other: Cuboid) -> Bool {
		x.overlaps(other.x)
		&& y.overlaps(other.y)
		&& z.overlaps(other.z)
	}
	
	func union(with other: Cuboid) -> Set<Cuboid> {
		guard intersects(with: other) else { return [self, other] }
		
		if other.isSuperset(of: self) { return [other] }
		
		var sets: Set<Cuboid> = []
		sets.insert(other)
		
		let xRanges = x.split(over: other.x)
		let yRanges = y.split(over: other.y)
		let zRanges = z.split(over: other.z)
		
		xRanges.forEach { xRange in
			yRanges.forEach { yRange in
				zRanges.forEach { zRange in
					let new = Cuboid(x: xRange, y: yRange, z: zRange)
					if other.isSuperset(of: new) { return }
					sets.insert(new)
				}
			}
		}
		
		return sets
	}
}

func partOne() -> String {
	var cuboids: Set<Cuboid> = []
	
	for line in input.split(separator: "\n") {
		let on = line.starts(with: "on")
		let new = Cuboid(line: line)
		
		guard new.isSmall else { continue }
		
		if on {
			if cuboids.isEmpty {
				cuboids = [new]
			} else {
				cuboids = Set(cuboids.lazy.flatMap { $0.union(with: new) })
			}
		} else {
			cuboids = Set(cuboids.lazy.flatMap { $0.union(with: new) })
			cuboids.remove(new)
		}
	}

	return cuboids.map(\.points).reduce(0, +).description
}

func partTwo() -> String {
	var cuboids: Set<Cuboid> = []
	
	for line in input.split(separator: "\n") {
		let on = line.starts(with: "on")
		let new = Cuboid(line: line)
		
		if on {
			if cuboids.isEmpty {
				cuboids = [new]
			} else {
				cuboids = Set(cuboids.lazy.flatMap { $0.union(with: new) })
			}
		} else {
			cuboids = Set(cuboids.lazy.flatMap { $0.union(with: new) })
			cuboids.remove(new)
		}
	}

	return cuboids.map(\.points).reduce(0, +).description
}

print(partOne())
print(partTwo())

//: [Next](@next)
