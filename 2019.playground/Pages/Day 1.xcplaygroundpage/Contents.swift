import Foundation

let input = """
88397
140448
79229
122289
143507
71642
145178
149729
104257
109287
136937
131253
88847
143302
104210
56054
137178
134861
117151
103772
135590
64319
53682
101137
52772
142235
88312
146564
131670
74925
126276
109028
95438
56083
77649
135414
52079
83883
92754
69122
77489
142896
126195
78749
133146
107841
75897
70156
128501
113859
64823
147935
72855
139576
125827
57409
113492
85048
89204
68744
120464
118813
102856
117750
130545
65139
77010
139609
88580
104355
99680
82451
141198
142489
121556
66616
121318
149517
135978
126001
70211
73221
52727
82621
143301
64186
75382
130742
135248
129867
78189
148444
95969
106317
147315
81697
131555
56152
105759
117769
"""

let numbers = input
    .components(separatedBy: .newlines)
    .map { Int($0)! }

func fuel(forMass mass: Int) -> Int {
    return Int((Double(mass) / 3).rounded(.down) - 2)
}

func recursivelyCalculatedFuel(forMass mass: Int) -> Int {
    var currentFuel = fuel(forMass: mass)
    var totalFuel = currentFuel
    while true {
        let newFuel = fuel(forMass: currentFuel)
        if newFuel <= 0 {
            return totalFuel
        } else {
            totalFuel += newFuel
            currentFuel = newFuel
        }
    }
}

func partOne() -> String {
    let totalFuel = numbers
        .lazy
        .map { fuel(forMass: $0) }
        .reduce(0, +)
    
    return "\(totalFuel)"
}

func partTwo() -> String {
    let totalFuel = numbers
        .lazy
        .map { recursivelyCalculatedFuel(forMass: $0) }
        .reduce(0, +)
    
    return "\(totalFuel)"
}

print(partOne())
print(partTwo())

//: [Next](@next)
