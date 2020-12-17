import Foundation

let input = """
#....#.#
..##.##.
#..#..#.
.#..#..#
.#..#...
##.#####
#..#..#.
##.##..#
"""

extension Sequence {
	func union<T>() -> Set<T> where Element == Set<T> {
		var sum = Set<T>()
		for item in self {
			sum.formUnion(item)
		}
		return sum
	}
}

func partOne() -> String {
	struct Point3D: Hashable {
		var x: Int
		var y: Int
		var z: Int
		
		var neighbours: Set<Point3D> {
			var neighbours: Set<Point3D> = []
			(x - 1 ... x + 1).forEach { x in
				(y - 1 ... y + 1).forEach { y in
					(z - 1 ... z + 1).forEach { z in
						neighbours.insert(Point3D(x: x, y: y, z: z))
					}
				}
			}
			neighbours.remove(self)
			return neighbours
		}
	}
	
	var activePoints = input
		.split(separator: "\n")
		.enumerated()
		.reduce(into: Set<Point3D>()) { activePoints, yAndLine in
			let (y, line) = yAndLine
			line.enumerated().forEach { x, char in
				guard char == "#" else { return }
				activePoints.insert(Point3D(x: x, y: y, z: 0))
			}
		}
	
	for _ in 1 ... 6 {
		let pointsToConsider = activePoints.union(activePoints.map(\.neighbours).union())
		let newActivePoints = pointsToConsider
			.filter { point in
				let activeNeighbours = point.neighbours.lazy.filter(activePoints.contains).count
				if activePoints.contains(point) {
					return activeNeighbours == 2 || activeNeighbours == 3
				} else {
					return activeNeighbours == 3
				}
			}
		activePoints = newActivePoints
	}
	
	return activePoints.count.description
}

func partTwo() -> String {
	struct Point4D: Hashable {
		var x: Int
		var y: Int
		var z: Int
		var w: Int
		
		var neighbours: Set<Point4D> {
			var neighbours: Set<Point4D> = []
			(x - 1 ... x + 1).forEach { x in
				(y - 1 ... y + 1).forEach { y in
					(z - 1 ... z + 1).forEach { z in
						(w - 1 ... w + 1).forEach { w in
							neighbours.insert(Point4D(x: x, y: y, z: z, w: w))
						}
					}
				}
			}
			neighbours.remove(self)
			return neighbours
		}
	}
	
	var activePoints = input
		.split(separator: "\n")
		.enumerated()
		.reduce(into: Set<Point4D>()) { activePoints, yAndLine in
			let (y, line) = yAndLine
			line.enumerated().forEach { x, char in
				guard char == "#" else { return }
				activePoints.insert(Point4D(x: x, y: y, z: 0, w: 0))
			}
		}
	
	for _ in 1 ... 6 {
		let pointsToConsider = activePoints.union(activePoints.map(\.neighbours).union())
		let newActivePoints = pointsToConsider
			.filter { point in
				let activeNeighbours = point.neighbours.lazy.filter(activePoints.contains).count
				if activePoints.contains(point) {
					return activeNeighbours == 2 || activeNeighbours == 3
				} else {
					return activeNeighbours == 3
				}
			}
		activePoints = newActivePoints
	}

	return activePoints.count.description
}

print(partOne())
print(partTwo())
