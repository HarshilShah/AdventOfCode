import Foundation

let input = """
Player 1:
24
22
26
6
14
19
27
17
39
34
40
41
23
30
36
11
28
3
10
21
9
50
32
25
8

Player 2:
48
49
47
15
42
44
5
4
13
7
20
43
12
37
29
18
45
16
1
46
38
35
2
33
31
"""

let lines = input.split(separator: "\n")

let pOne = lines
	.dropFirst()
	.prefix(while: { $0.first?.isNumber == true })
	.map { Int($0)! }

let pTwo = lines
	.dropFirst()
	.drop(while: { $0.first?.isNumber == true })
	.dropFirst()
	.map { Int($0)! }

func score(for player: [Int]) -> Int {
	player
		.reversed()
		.enumerated()
		.lazy
		.map { ($0 + 1) * $1 }
		.reduce(0, +)
}

func partOne() -> String {
	var playerOne = pOne
	var playerTwo = pTwo
	
	while playerOne.isEmpty == false, playerTwo.isEmpty == false {
		let one = playerOne.removeFirst()
		let two = playerTwo.removeFirst()
		
		if one > two {
			playerOne.append(one)
			playerOne.append(two)
		} else {
			playerTwo.append(two)
			playerTwo.append(one)
		}
	}
	
	let winner = playerOne.isEmpty ? playerTwo : playerOne
	return score(for: winner).description
}

func partTwo() -> String {
	struct Round: Hashable {
		var playerOne: [Int]
		var playerTwo: [Int]
		
		var canContinue: Bool {
			(playerOne.isEmpty || playerTwo.isEmpty) == false
		}
	}
	
	func recurse(_ round: Round) -> (playerOneWon: Bool, winner: [Int]) {
		var seenRounds: Set<Round> = []
		var round = round
		
		while round.canContinue {
			if seenRounds.contains(round) {
				return (true, round.playerOne)
			}
			
			seenRounds.insert(round)
			
			let one = round.playerOne.removeFirst()
			let two = round.playerTwo.removeFirst()
			
			let playerOneWin: Bool = {
				if one <= round.playerOne.count, two <= round.playerTwo.count {
					let recursiveRound = Round(
						playerOne: Array(round.playerOne.prefix(one)),
						playerTwo: Array(round.playerTwo.prefix(two))
					)
					return recurse(recursiveRound).playerOneWon
				} else {
					return one > two
				}
			}()
			
			if playerOneWin {
				round.playerOne.append(one)
				round.playerOne.append(two)
			} else {
				round.playerTwo.append(two)
				round.playerTwo.append(one)
			}
		}
		
		let playerOneWon = round.playerOne.isEmpty == false
		let winner = playerOneWon ? round.playerOne : round.playerTwo
		return (playerOneWon, winner)
	}
	
	let winner = recurse(Round(playerOne: pOne, playerTwo: pTwo)).winner
	return score(for: winner).description
}

print(partOne())
print(partTwo())
