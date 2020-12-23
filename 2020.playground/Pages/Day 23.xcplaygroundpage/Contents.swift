import Foundation

let input = """
952316487
"""

func partOne() -> String {
	var cups = input.map { $0.wholeNumberValue! }
	var currentCup = cups[0]
	
	for _ in 1 ... 100 {
		
		let extracted: [Int] = {
			var cupsToRemove = cups
				.drop { $0 != currentCup }
				.dropFirst()
				.prefix(3)
			cupsToRemove.append(contentsOf: cups.prefix(3 - cupsToRemove.count))
			cups.removeAll(where: cupsToRemove.contains)
			return Array(cupsToRemove)
		}()
		
		var destination = currentCup - 1
		while cups.contains(destination) == false {
			destination -= 1
			if destination < cups.min()! {
				destination = cups.max()!
			}
		}
		
		let destinationIndex = cups.firstIndex(of: destination)!
		cups.insert(contentsOf: extracted, at: destinationIndex + 1)
		
		let currentCupIndex = cups.firstIndex(of: currentCup)!
		let nextCupIndex = cups.indices.contains(currentCupIndex + 1)  ? currentCupIndex + 1 : 0
		currentCup = cups[nextCupIndex]
	}

	return (cups + cups)
		.drop { $0 != 1 }
		.dropFirst()
		.prefix { $0 != 1 }
		.map(\.description)
		.joined()
}

func partTwo() -> String {
	final class Node {
		let value: Int
		var next: Node?
		
		init(value: Int) {
			self.value = value
		}
	}
	
	let cupCount = 1_000_000
	let iterations = 10_000_000
	
	let initialCups = input.map { Node(value: $0.wholeNumberValue!) }
	var map = initialCups.reduce(into: [Int: Node]()) { dict, node in
		dict[node.value] = node
	}
	
	initialCups.enumerated().forEach { index, node in
		node.next = initialCups[(index + 1) % initialCups.count]
	}
	
	var current = initialCups.last!
	
	(initialCups.count + 1 ... cupCount).forEach {
		let node = Node(value: $0)
		current.next = node
		current = node
		map[$0] = node
	}
	
	current.next = initialCups[0]
	current = initialCups[0]
	
	for _ in 1 ... iterations {
		let a = current.next!
		let b = a.next!
		let c = b.next!
		
		current.next = c.next
		
		var destinationValue = current.value - 1
		let removedValues = [a, b, c].map(\.value)
		while destinationValue < 1 || removedValues.contains(destinationValue) {
			destinationValue -= 1
			if destinationValue < 1 {
				destinationValue = cupCount
			}
		}
		
		let destination = map[destinationValue]!
		c.next = destination.next
		destination.next = a
		
		current = current.next!
	}
	
	let one = map[1]!
	return (one.next!.value * one.next!.next!.value).description
}

print(partOne())
print(partTwo())
