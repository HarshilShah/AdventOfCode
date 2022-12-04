import Foundation

typealias CurrentDay = Day4

let testInput = """
<Insert your test input here>
"""

let input = """
<Insert your input here>
"""

let startTime = Date.now

print("--- Test Input---")
let testDay = CurrentDay(input: testInput)
print(testDay.partOne())
print(testDay.partTwo())

print("\n--- Input---")
let day = CurrentDay(input: input)
print(day.partOne())
print(day.partTwo())

let endTime = Date.now
let executionTime = Measurement(value: endTime.timeIntervalSince(startTime), unit: UnitDuration.seconds)
print("\nExecution Time: \(executionTime.formatted(.measurement(width: .wide, usage: .asProvided)))")
