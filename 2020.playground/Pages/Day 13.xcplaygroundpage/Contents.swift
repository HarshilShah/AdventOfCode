import Foundation

let input = """
1009310
19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,599,x,29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17,x,x,x,x,x,23,x,x,x,x,x,x,x,761,x,x,x,x,x,x,x,x,x,41,x,x,13
"""

func partOne() -> String {
	let timestamp = Int(input.split(separator: "\n").first!)!
	let buses = input.split(separator: "\n")[1]
		.split(separator: ",")
		.compactMap { Int($0) }
	
	var earliestBus = 0
	var earliestDeparture = Int.max
	
	for bus in buses {
		let divisor = timestamp / bus
		let departure = (divisor + 1) * bus

		if departure < earliestDeparture {
			earliestDeparture = departure
			earliestBus = bus
		}
	}

	return (earliestBus * (earliestDeparture - timestamp)).description
}

func partTwo() -> String {
	// data (offset: time pairs):
	// [(0, 19), (13, 37), (19, 599), (21, 29), (36, 17), (42, 23), (50, 761), (60, 41), (63, 13)]
	//
	// t % 19 == 0
	// (t + 13) % 37 == 0 == (t + 50) % 37
	// (t + 19) % 599 == 0 == (t + 19) % 599
	// (t + 21) % 29 == 0 == (t + 50) % 29
	// (t + 36) % 17 == 0 == (t + 19) % 17
	// (t + 42) % 23 == 0 == (t + 19) % 23
	// (t + 50) % 761 == 0 == (t + 50) % 761
	// (t + 60) % 41 == 0 == (t + 19) % 41
	// (t + 63) % 13 == 0 == (t + 50) % 13
	//
	// (t + 50) % (37, 29, 761, 13) == 0
	// (t + 19) % (19, 599, 17, 23, 41) == 0
	//
	// (t + 50) % 10,615,189 == 0
	// (t + 19) % 182,448,811 == 0
	
	let inc = 182_448_811
	var tWithOffset = inc // t + 19

	while true {
		if (tWithOffset + 31) % 10_615_189 == 0 {
			return (tWithOffset - 19).description
		}
		
		tWithOffset += inc
	}
}
	
print(partOne())
print(partTwo())
