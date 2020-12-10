import Foundation

let input = """
70
102
148
9
99
63
40
52
91
39
55
28
54
22
95
61
118
35
14
21
129
82
137
45
7
87
81
25
3
108
41
11
145
18
65
80
115
29
136
42
97
104
117
141
62
121
23
96
24
128
48
1
112
8
34
144
134
116
58
147
51
84
17
126
64
68
135
10
77
105
127
73
111
90
16
103
109
98
146
123
130
69
133
110
30
122
15
74
33
38
83
92
2
53
140
4
"""

let joltages = input
	.split(separator: "\n")
	.map { Int($0)! }
	.sorted()

func partOne() -> String {
	var one = 0
	var three = 0
	var previousJoltage = 0
	
	for joltage in joltages {
		defer { previousJoltage = joltage }
		
		switch joltage - previousJoltage {
		case 3: three += 1
		case 1: one += 1
		default: break
		}
	}
	
	three += 1 // last step to n + 3
	return (one * three).description
}

func partTwo() -> String {
	let goal = joltages.last! + 3
	var paths: [Int: Int] = [0: 1]
	
	for newJoltage in (joltages + [goal]) {
		var newPaths: [Int: Int] = [:]
		
		for (joltage, count) in paths {
			if (newJoltage - joltage) <= 3 {
				newPaths[joltage, default: 0] += count
				newPaths[newJoltage, default: 0] += count
			}
		}
		
		paths = newPaths
	}
	
	return paths[goal]!.description
}

print(partOne())
print(partTwo())
