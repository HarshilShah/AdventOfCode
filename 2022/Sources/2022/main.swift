import Foundation

let input = """
<Insert your input here>
"""

let startTime = Date()
let day = Day1(input: input)
print(day.partOne())
print(day.partTwo())
let endTime = Date()
print(endTime.timeIntervalSince(startTime))
