import Algorithms
import Collections
import Foundation
import RegexBuilder

fileprivate enum Direction: Character {
	case up = "U", down = "D", left = "<", right = ">"
}

fileprivate struct Point: Hashable, CustomStringConvertible {
	var x: Int
	var y: Int
	
	static let zero = Point(x: 0, y: 0)
	
	func moving(in direction: Direction, count: Int) -> Point {
		switch direction {
		case .up: return Point(x: x, y: y + count)
		case .down: return Point(x: x, y: y - count)
		case .left: return Point(x: x - count, y: y)
		case .right: return Point(x: x + count, y: y)
		}
	}
	
	var description: String {
		"(x: \(x), y: \(y))"
	}
}

fileprivate struct Rock: Hashable, CustomStringConvertible {
	var points: Set<Point>
	
	func moving(in direction: Direction, count: Int) -> Rock {
		Rock(points: Set(points.map({ $0.moving(in: direction, count: count) })))
	}
	
	var description: String {
		points.map(\.description).joined(separator: "\n")
	}
}

fileprivate struct CaveInfo: Hashable {
	var rockCount: Int
	var height: Int
	var caps: [Int]
}

struct Day17: Day {
	var input: String
	
	let rocks = """
	####

	.#.
	###
	.#.

	..#
	..#
	###

	#
	#
	#
	#

	##
	##
	"""
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let parsedRocks = rocks
			.components(separatedBy: "\n\n")
			.map(parseRock)
		
		let gas = input.compactMap(Direction.init(rawValue:))
		var gasQueue = Deque(gas)
		
		var grid: [Set<Int>] = []
		var count = 0
		
		for rock in parsedRocks.cycled() {
			drop(rock: rock, in: &grid, withGases: &gasQueue)
			
			count += 1
			
			if count == 2022 {
				break
			}
		}
		
		return grid.count.description
	}
	
	func partTwo() -> String {
		var parsedRocks = Deque(
			rocks
				.components(separatedBy: "\n\n")
				.map(parseRock)
		)
		
		let gas = input.compactMap(Direction.init(rawValue:))
		var gasQueue = Deque(gas)
		
		var grid: [Set<Int>] = []
		var visited: [Int: [Int: [CaveInfo]]] = [:]
		
		var rockCount = 0
		var gasCount = 0
		
		let target = 1_000_000_000_000
		
		while let rock = parsedRocks.popFirst() {
			parsedRocks.append(rock)
			
			rockCount += 1
			gasCount += drop(rock: rock, in: &grid, withGases: &gasQueue)
			
			let rockIndex = (rockCount - 1).quotientAndRemainder(dividingBy: parsedRocks.count).remainder
			let (gasLoop, gasIndex) = gasCount.quotientAndRemainder(dividingBy: gas.count)
			
			/// Ignore the first gas loop since it starts with  a flat floor, which isn't repeated
			if gasLoop == 0 { continue}
			
			let gridCaps = (0 ... 6).map { index in
				grid.firstIndex(where: { $0.contains(index) }) ?? 0
			}
			
			guard let match = visited[gasIndex]?[rockIndex]?.first(where: { $0.caps == gridCaps }) else {
				visited[gasIndex, default: [:]][rockIndex, default: []].append(CaveInfo(rockCount: rockCount, height: grid.count, caps: gridCaps))
				continue
			}
			
			let cycleSize = rockCount - match.rockCount
			let (numberOfCycles, numberOfExtras) = (target - match.rockCount).quotientAndRemainder(dividingBy: cycleSize)
			let cycleHeight = grid.count - match.height
			let totalCycleHeight = numberOfCycles * cycleHeight
			let total = match.height + totalCycleHeight
			
			let extrasTotal: Int = {
				guard numberOfExtras > 1 else { return 0 }
				
				let initialGridHeight = grid.count
				for _  in 1 ... numberOfExtras {
					let rock = parsedRocks.popFirst()!
					parsedRocks.append(rock)
					drop(rock: rock, in: &grid, withGases: &gasQueue)
				}
				return grid.count - initialGridHeight
			}()
			
			return (total + extrasTotal).description
		}
		
		fatalError("Unexpected input")
	}
	
	fileprivate func parseRock(_ lines: some StringProtocol) -> Rock {
		var points: Set<Point> = []
		for (y, line) in lines.split(separator: "\n").reversed().enumerated() {
			for (x, c) in line.enumerated() {
				if c == "#" {
					points.insert(Point(x: x, y: y))
				}
			}
		}
		return Rock(points: points)
	}
	
	@discardableResult
	fileprivate func drop(
		rock: Rock,
		in grid: inout [Set<Int>],
		withGases gasQueue: inout Deque<Direction>
	) -> Int {
		let height = grid.count + 3
		var rock = rock.moving(in: .right, count: 2).moving(in: .up, count: height)
		
		var isSettled: Bool {
			let shiftingDown = rock.moving(in: .down, count: 1)
			let canShiftLower = shiftingDown.points.allSatisfy { stone in
				if stone.y < 0 { return false }
				guard grid.indices.contains(stone.y) else { return true }
				return grid[stone.y].contains(stone.x) == false
			}
			return canShiftLower == false
		}
		
		func isValid(_ rock: Rock) -> Bool {
			rock.points.allSatisfy { stone in
				let isHorizontallyValid = (0 ... 6).contains(stone.x)
				let isVerticallyValid: Bool = {
					if stone.y < 0 { return false }
					guard grid.indices.contains(stone.y) else { return true }
					return grid[stone.y].contains(stone.x) == false
				}()
				return isHorizontallyValid && isVerticallyValid
			}
		}
		
		var gasCount = 0
		
		while true {
			let gas = gasQueue.popFirst()!
			gasCount += 1
			gasQueue.append(gas)
			
			let movingTowardsGas = rock.moving(in: gas, count: 1)
			if isValid(movingTowardsGas) {
				rock = movingTowardsGas
			}
			
			if isSettled == false {
				rock = rock.moving(in: .down, count: 1)
			} else {
				break
			}
		}
		
		for point in rock.points {
			while grid.indices.contains(point.y) == false {
				grid.append([])
			}
			
			grid[point.y].insert(point.x)
		}
		
		return gasCount
	}
}
