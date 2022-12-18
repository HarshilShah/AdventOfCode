import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate extension StringProtocol {
	var integers: [Int] {
		return self
			.split{ "-0123456789".contains($0) == false }
			.map { Int($0)! }
	}
}

extension ClosedRange where Bound: AdditiveArithmetic {
	func expanded(by delta: Bound) -> ClosedRange {
		lowerBound - delta ... upperBound + delta
	}
}

enum Axis3D: CaseIterable, Hashable {
	case x, y, z
}

struct Point3D: Hashable {
	var x: Int
	var y: Int
	var z: Int
	
	static let zero = Point3D(x: 0, y: 0, z: 0)
	
	static func parsing(_ droplet: some StringProtocol) -> Point3D {
		let ints = droplet.integers
		return Point3D(x: ints[0], y: ints[1], z: ints[2])
	}
	
	func moving(along axis: Axis3D, distance: Int = 1) -> Point3D {
		Point3D(
			x: x + (axis == .x ? distance : 0),
			y: y + (axis == .y ? distance : 0),
			z: z + (axis == .z ? distance : 0)
		)
	}
	
	func neighbours() -> [Point3D] {
		Axis3D.allCases.flatMap { axis in
			[-1, 1].map { distance in
				self.moving(along: axis, distance: distance)
			}
		}
	}
}

struct Day18: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let cubes = Set(
			input
				.split(separator: "\n")
				.map(Point3D.parsing)
		)
		
		return cubes
			.lazy
			.flatMap { $0.neighbours() }
			.filter { cubes.contains($0) == false }
			.count
			.description
	}
	
	func partTwo() -> String {
		let cubes = Set(
			input
				.split(separator: "\n")
				.map(Point3D.parsing)
		)
		
		let xRange = cubes.range(\.x)!.expanded(by: 2)
		let yRange = cubes.range(\.y)!.expanded(by: 2)
		let zRange = cubes.range(\.z)!.expanded(by: 2)
		
		var emptySpace: Set<Point3D> = []
		
		var queue =  Deque([Point3D.zero])
		while let point = queue.popFirst() {
			guard xRange.contains(point.x) else { continue }
			guard yRange.contains(point.y) else { continue }
			guard zRange.contains(point.z) else { continue }
			
			for neighbour in point.neighbours() {
				guard
					cubes.contains(neighbour) == false,
					emptySpace.contains(neighbour) == false
					else { continue }
				queue.append(neighbour)
				emptySpace.insert(neighbour)
			}
		}
		
		return cubes
			.lazy
			.flatMap { $0.neighbours() }
			.filter(emptySpace.contains)
			.count
			.description
	}
}
