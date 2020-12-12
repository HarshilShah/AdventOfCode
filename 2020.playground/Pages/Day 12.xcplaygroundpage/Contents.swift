import Foundation

let input = """
S3
W3
F47
L90
W1
F42
N1
R90
F7
R90
E2
S1
W2
F11
E4
N1
F77
W1
S3
W4
F64
W3
R180
N5
E1
F8
N1
F54
N2
L180
N1
F44
E2
N2
L90
W3
F5
W2
L180
F100
N3
E1
W4
N5
F40
R180
W5
R90
N1
W3
R270
N1
R90
S5
F10
E4
N4
F56
E3
N4
W4
R90
N3
F24
F58
R90
N2
R90
W5
S2
R90
W3
R90
W1
N3
R90
N4
E2
F25
N5
N4
L90
E5
N4
R90
N1
R90
F73
W1
S3
W4
W1
F28
W3
E2
S3
F28
S3
R270
E1
S2
W3
S3
L90
F56
E5
L180
R90
F48
N2
F75
S2
E5
F21
F57
N5
L90
E4
N4
F14
S3
F75
W5
L90
E3
R90
N1
W4
F4
W5
S3
E3
F68
N3
R90
W4
N5
S3
F4
R90
F48
R90
F93
R90
S3
F90
R90
F41
N2
S1
E5
F19
E3
F71
R180
F16
W3
N4
W3
F12
L180
L90
R180
W4
R90
F26
W1
E4
F65
L90
F90
W5
S4
W1
E3
L90
W3
N2
F77
W2
L90
E4
S2
W5
F60
R90
F45
R90
S3
F56
W2
S3
W5
F58
L90
N1
F94
S4
F17
W5
R180
S2
R90
N4
W1
S3
R180
F93
R90
F45
E4
R90
S1
F81
E2
L90
S1
F63
E2
R90
E2
N1
W1
L90
F91
S5
L270
E3
S1
F29
N4
R180
F44
L90
E3
L90
F90
R90
F93
N2
S2
F28
E1
F58
N1
F9
L90
S1
F74
N2
F19
L180
S3
E1
R90
F55
S3
L90
F58
S1
R90
E4
F42
S5
R90
S4
L90
S1
E3
F75
L90
F44
E2
F50
S2
N4
W2
F14
W2
N2
F14
S1
W4
F74
L90
F52
W3
S5
L90
W5
N3
L90
F54
S1
R90
E3
R90
F23
S4
F75
N5
R90
F79
R90
F70
N2
F89
W1
S5
E2
F44
L180
W5
R90
F72
R90
N3
W4
N4
F90
R270
E4
F43
W4
F44
N5
F55
S4
F68
S1
E1
F39
W2
N4
F46
W5
F62
E1
R270
F97
W4
L180
F41
R90
W3
R270
S1
E1
R90
E2
F18
E2
F12
R90
W5
L90
E2
F82
N3
E5
F45
N5
F69
N5
W1
R90
F15
W1
S2
R90
F50
S4
S5
W2
S4
F21
E5
L90
F47
E1
F73
L90
F4
R90
F65
E2
S4
F52
E1
N1
L90
S1
F41
R180
S2
F5
E1
R90
N3
F29
L90
F69
E4
F92
R90
N4
L180
W5
N3
R180
W1
N5
E5
F1
N3
F19
W4
F33
N2
R90
E2
N3
F68
E3
S1
R90
N3
R180
E5
R90
W1
R90
S2
L90
F67
W2
S4
R270
W1
R90
F11
L180
F83
R90
N3
L90
W1
N1
L90
F41
N4
F45
S2
W4
S4
F92
E3
F21
R180
W4
S1
N3
R90
N2
L90
F97
N4
F99
F78
E2
S3
W1
N4
N1
E1
L180
F32
S1
F84
L90
S3
L90
E3
R90
F62
N4
L90
E2
R90
F68
S4
F29
E5
S5
R180
S1
F15
W1
S3
F65
L180
F54
L90
W2
S3
W2
F22
L180
W5
R90
E4
L90
F65
W5
F82
S3
W5
L90
F83
W4
L90
E1
F92
W4
N2
F99
L90
E5
R180
N5
W5
R90
N3
F74
R90
N1
F26
S3
W2
N2
E3
L90
F75
R90
F12
W3
S5
L90
N2
E4
F13
E1
F44
N3
R90
E5
R90
W4
F4
W5
N3
W3
F40
L180
W3
N2
E3
F57
W1
F16
S2
W3
R90
W3
F24
R90
F84
R90
W2
R270
S1
L180
F62
W1
R180
F71
E2
S2
R90
F84
E2
F64
R90
S5
F42
S4
F37
E5
R90
S2
R90
S4
W1
R180
F71
W3
F19
W5
R180
F98
S5
R90
N2
W5
N5
F14
L270
F29
L90
F94
W4
F92
W5
N4
F78
N1
S3
F10
L90
F72
R90
S2
L180
N3
R180
W3
F83
N4
E5
N2
E3
L90
E2
F84
S4
R90
E3
S4
F59
R90
W1
R90
F29
S4
W1
S5
L90
F77
R90
N4
F69
L90
W5
F15
N3
N1
L180
N2
N4
W4
N1
L180
W4
F5
R180
E2
R90
S2
R90
N2
F49
L180
F32
N5
R90
W5
L90
E1
F46
E1
L90
W3
F69
N5
E1
S3
L90
F98
W2
L90
F17
W3
N2
F78
E5
W1
S1
F73
S2
F36
N5
E3
F61
R90
E4
F88
L90
E4
R180
W4
S2
R180
N2
F17
E5
S5
E1
R90
S3
L90
R90
S4
F1
W2
N1
W5
F35
S2
F78
S2
L90
W1
L180
N4
F99
F34
L90
N5
R90
S4
L90
N2
F72
E5
S4
R180
S4
F18
W1
L90
E1
S4
E2
R90
F62
L90
F71
S1
F18
F6
N1
F28
L90
N1
F24
E1
R90
S2
F51
"""

struct Point: Hashable {
	var x: Int
	var y: Int
	
	mutating func move(steps: Int, inDirection direction: Direction) {
		switch direction {
		case .n: y -= steps
		case .e: x += steps
		case .w: x -= steps
		case .s: y += steps
		}
	}
}

enum Direction {
	case n, e, w, s
	
	mutating func turnLeft() {
		switch self {
		case .n: self = .w
		case .e: self = .n
		case .w: self = .s
		case .s: self = .e
		}
	}
	
	mutating func turnRight() {
		switch self {
		case .n: self = .e
		case .e: self = .s
		case .w: self = .n
		case .s: self = .w
		}
	}
}

func partOne() -> String {
	var position = Point(x: 0, y: 0)
	var direction = Direction.e
	
	for instruction in input.split(separator: "\n") {
		let command = instruction.first!
		let amount = Int(instruction.dropFirst())!
		
		switch command {
		case "N": position.move(steps: amount, inDirection: .n)
		case "E": position.move(steps: amount, inDirection: .e)
		case "W": position.move(steps: amount, inDirection: .w)
		case "S": position.move(steps: amount, inDirection: .s)
		case "L":
			
			(0 ..< amount/90).forEach { _ in
				direction.turnLeft()
			}
			
		case "R":
			
			(0 ..< amount/90).forEach { _ in
				direction.turnRight()
			}
			
		case "F": position.move(steps: amount, inDirection: direction)
		default: fatalError("Unexpected input")
		}
	}
	
	return (abs(position.x) + abs(position.y)).description
}

func partTwo() -> String {
	var position = Point(x: 0, y: 0)
	var waypoint = Point(x: 10, y: -1)

	for instruction in input.split(separator: "\n") {
		let command = instruction.first!
		let amount = Int(instruction.dropFirst())!
		
		switch command {
		case "N": waypoint.move(steps: amount, inDirection: .n)
		case "E": waypoint.move(steps: amount, inDirection: .e)
		case "W": waypoint.move(steps: amount, inDirection: .w)
		case "S": waypoint.move(steps: amount, inDirection: .s)
		case "L":
			
			let cgPoint = CGPoint(x: waypoint.x, y: waypoint.y)
				.applying(CGAffineTransform(rotationAngle: -.pi * CGFloat(amount) / 180))
			waypoint = Point(x: Int(cgPoint.x.rounded()), y: Int(cgPoint.y.rounded()))
			
		case "R":
			
			let cgPoint = CGPoint(x: waypoint.x, y: waypoint.y)
				.applying(CGAffineTransform(rotationAngle: .pi * CGFloat(amount) / 180))
			waypoint = Point(x: Int(cgPoint.x.rounded()), y: Int(cgPoint.y.rounded()))
			
		case "F":
			
			position.x += waypoint.x * amount
			position.y += waypoint.y * amount
			
		default: fatalError("Unexpected input")
		}
	}
	
	return (abs(position.x) + abs(position.y)).description
}

print(partOne())
print(partTwo())
