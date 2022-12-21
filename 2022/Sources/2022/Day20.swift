import Algorithms
import Collections
import Foundation
import RegexBuilder

class Node: NSObject {
	var value = 0
	var next: Node?
	var previous: Node?
	
	func shiftForwards() {
		let initialNext = next!
		let initialPrevious = previous!
		
		next = initialNext.next
		initialNext.next!.previous = self
		initialNext.next = self
		
		previous = initialNext
		initialPrevious.next = initialNext
		initialNext.previous = initialPrevious
	}
	
	func shiftBackwards() {
		let initialNext = next!
		let initialPrevious = previous!
		
		previous = initialPrevious.previous
		initialPrevious.previous!.next = self
		initialPrevious.previous = self
		
		next = initialPrevious
		initialNext.previous = initialPrevious
		initialPrevious.next = initialNext
	}
}

struct Day20: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		let head = nodes(areDecrypted: false)
		
		var queue = Deque([head])
		var count = 1
		var runner = head.next!
		while runner != head {
			count += 1
			queue.append(runner)
			runner = runner.next!
		}
		
		mix(nodes: queue, count: count)
		return result(from: head).description
	}
	
	func partTwo() -> String {
		let head = nodes(areDecrypted: true)
		
		var queue = Deque([head])
		var count = 1
		var runner = head.next!
		while runner != head {
			count += 1
			queue.append(runner)
			runner = runner.next!
		}
		
		for _ in 1 ... 10 {
			mix(nodes: queue, count: count)
		}
		
		return result(from: head).description
	}
	
	func nodes(areDecrypted: Bool) -> Node {
		var head: Node?
		var current: Node?
		
		for int in input.split(separator: "\n").map({ Int($0)! }) {
			let int = int * (areDecrypted ? 811589153 : 1)
			
			if let c = current {
				let new = Node()
				new.value = int
				current!.next = new
				new.previous = c
				current = new
			} else {
				let initial = Node()
				initial.value = int
				current = initial
				head = initial
			}
		}
		
		current!.next = head
		head!.previous = current
		
		return head!
	}
	
	func mix(nodes queue: Deque<Node>, count: Int) {
		var queue = queue
		
		while let current = queue.popFirst() {
			if current.value == 0 {
				continue
			} else if current.value < 0 {
				let moves = (-current.value).quotientAndRemainder(dividingBy: count - 1).remainder
				if moves == 0 { continue }
				
				for _ in 1 ... moves {
					current.shiftBackwards()
				}
			} else {
				let moves = (current.value).quotientAndRemainder(dividingBy: count - 1).remainder
				if moves == 0 { continue }
				
				for _ in 1 ... moves {
					current.shiftForwards()
				}
			}
		}
	}
	
	func result(from head: Node) -> Int {
		var result = 0
		
		var count = 0
		var hasSeenZero = false
		var current = head
		
		while count <= 3000 {
			current = current.next!
			
			if hasSeenZero {
				count += 1
			}
			
			if hasSeenZero, count.quotientAndRemainder(dividingBy: 1000).remainder == 0 {
				result += current.value
			}
			
			if hasSeenZero == false, current.value == 0 {
				hasSeenZero = true
			}
		}
		
		return result
	}
}
