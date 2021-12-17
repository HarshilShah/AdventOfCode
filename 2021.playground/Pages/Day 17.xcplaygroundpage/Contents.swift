//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

extension String {
	var numbers: [Int] {
		split(whereSeparator: { "-0123456789".contains($0) == false })
			.map { Int($0)! }
	}
}

struct Point: Hashable {
	var x: Int
	var y: Int
	
	static var zero = Point(x: 0, y: 0)
}

let numbers = input.numbers
let xRange = numbers[0] ... numbers[1]
let yRange = numbers[2] ... numbers[3]

var maxY = Int.min
var count = 0

for xVelocity in 1 ... xRange.upperBound {
	for yVelocity in yRange.lowerBound ... 1000 {
		var position = Point.zero
		var velocity = Point(x: xVelocity, y: yVelocity)
		
		var localMaxY = Int.min
		
		while position.x <= xRange.upperBound, position.y >= yRange.lowerBound {
			position.x += velocity.x
			position.y += velocity.y
			
			velocity.x -= velocity.x.signum()
			velocity.y -= 1
			
			localMaxY = max(localMaxY, position.y)
			
			if xRange.contains(position.x) && yRange.contains(position.y) {
				maxY = max(maxY, localMaxY)
				count += 1
				break
			}
		}
	}
}

func partOne() -> String { maxY.description }
func partTwo() -> String { count.description }

print(partOne())
print(partTwo())

//: [Next](@next)
