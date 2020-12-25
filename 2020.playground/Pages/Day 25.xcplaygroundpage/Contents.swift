import Foundation

let input = """
18499292
8790390
"""

let subject = 7
let divisor = 20201227

let numbers = input
	.split(separator: "\n")
	.map { Int($0)! }
let publicKeys = (card: numbers[0], door: numbers[1])

var cardLoop = 0
var cardValue = 1
while cardValue != publicKeys.card {
	cardValue *= subject
	cardValue %= divisor
	cardLoop += 1
}

var encryptionKey = 1
for _ in 1 ... cardLoop {
	encryptionKey *= publicKeys.door
	encryptionKey %= divisor
}

print(encryptionKey)
