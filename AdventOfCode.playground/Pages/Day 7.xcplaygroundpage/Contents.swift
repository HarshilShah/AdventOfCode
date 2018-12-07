//: [Previous](@previous)
import Foundation

let input = """
Step E must be finished before step Y can begin.
Step Y must be finished before step T can begin.
Step I must be finished before step C can begin.
Step G must be finished before step F can begin.
Step C must be finished before step P can begin.
Step B must be finished before step Q can begin.
Step Z must be finished before step N can begin.
Step J must be finished before step W can begin.
Step W must be finished before step P can begin.
Step K must be finished before step D can begin.
Step Q must be finished before step L can begin.
Step V must be finished before step D can begin.
Step O must be finished before step M can begin.
Step A must be finished before step P can begin.
Step M must be finished before step L can begin.
Step R must be finished before step S can begin.
Step D must be finished before step X can begin.
Step X must be finished before step N can begin.
Step P must be finished before step T can begin.
Step F must be finished before step N can begin.
Step S must be finished before step L can begin.
Step U must be finished before step N can begin.
Step T must be finished before step L can begin.
Step N must be finished before step H can begin.
Step L must be finished before step H can begin.
Step N must be finished before step L can begin.
Step X must be finished before step F can begin.
Step P must be finished before step F can begin.
Step P must be finished before step H can begin.
Step B must be finished before step D can begin.
Step V must be finished before step H can begin.
Step X must be finished before step S can begin.
Step Q must be finished before step O can begin.
Step Z must be finished before step T can begin.
Step K must be finished before step N can begin.
Step S must be finished before step H can begin.
Step M must be finished before step P can begin.
Step Q must be finished before step D can begin.
Step R must be finished before step U can begin.
Step J must be finished before step P can begin.
Step P must be finished before step S can begin.
Step V must be finished before step U can begin.
Step R must be finished before step T can begin.
Step F must be finished before step S can begin.
Step D must be finished before step T can begin.
Step E must be finished before step N can begin.
Step J must be finished before step N can begin.
Step J must be finished before step A can begin.
Step K must be finished before step U can begin.
Step V must be finished before step N can begin.
Step V must be finished before step S can begin.
Step U must be finished before step L can begin.
Step F must be finished before step U can begin.
Step I must be finished before step T can begin.
Step J must be finished before step L can begin.
Step E must be finished before step T can begin.
Step T must be finished before step N can begin.
Step I must be finished before step G can begin.
Step R must be finished before step D can begin.
Step E must be finished before step B can begin.
Step X must be finished before step H can begin.
Step P must be finished before step L can begin.
Step Z must be finished before step J can begin.
Step O must be finished before step L can begin.
Step E must be finished before step H can begin.
Step F must be finished before step T can begin.
Step A must be finished before step F can begin.
Step U must be finished before step H can begin.
Step F must be finished before step H can begin.
Step C must be finished before step W can begin.
Step A must be finished before step L can begin.
Step V must be finished before step M can begin.
Step U must be finished before step T can begin.
Step E must be finished before step P can begin.
Step Y must be finished before step U can begin.
Step W must be finished before step R can begin.
Step E must be finished before step X can begin.
Step Q must be finished before step U can begin.
Step I must be finished before step F can begin.
Step V must be finished before step F can begin.
Step V must be finished before step T can begin.
Step R must be finished before step P can begin.
Step B must be finished before step A can begin.
Step S must be finished before step T can begin.
Step M must be finished before step F can begin.
Step Y must be finished before step F can begin.
Step C must be finished before step K can begin.
Step D must be finished before step S can begin.
Step O must be finished before step S can begin.
Step M must be finished before step U can begin.
Step Z must be finished before step S can begin.
Step R must be finished before step H can begin.
Step C must be finished before step O can begin.
Step G must be finished before step Q can begin.
Step Z must be finished before step D can begin.
Step B must be finished before step N can begin.
Step I must be finished before step H can begin.
Step I must be finished before step P can begin.
Step E must be finished before step J can begin.
Step V must be finished before step L can begin.
Step B must be finished before step U can begin.
"""

extension Character {
    var time: Int {
        return Int(unicodeScalars.first!.value) - 4
    }
}

var instructions: [Character: Set<Character>] = [:]

input
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)
    .forEach { line in
        let currentIndex = line.index(line.startIndex, offsetBy: 5)
        let current = line[currentIndex]
        let nextIndex = line.index(line.startIndex, offsetBy: 36)
        let next = line[nextIndex]
        
        
        if instructions.contains(where: { $0.key == current }) == false {
            instructions[current] = []
        }
        
        var list = instructions[next, default: []]
        list.insert(current)
        instructions[next] = list
}

func partOne() -> String {
    func recursivelyCompletedInstructions(_ currentlyCompleted: [Character]) -> [Character] {
        var completed = currentlyCompleted
        
        let queue = instructions.compactMap { pair -> Character? in
            let (instruction, dependencies) = pair
            guard !completed.contains(instruction), dependencies.isSubset(of: completed) else {
                return nil
            }
            
            return instruction
        }
        
        for instruction in queue.sorted() {
            guard !completed.contains(instruction) else {
                continue
            }
            
            completed.append(instruction)
            completed = recursivelyCompletedInstructions(completed)
        }
        
        return completed
    }
    
    let result = recursivelyCompletedInstructions([])
    
    return String(result)
}

func partTwo() -> String {
    enum Worker: Equatable {
        case workingOn(char: Character, timeStamp: Int)
        case free
    }
    
    let workerCount = 5
    var workers = [Worker](repeating: .free, count: workerCount)
    
    func completableInstructions(_ completed: [Character]) -> [Character] {
        return instructions
            .compactMap { pair -> Character? in
                let (instruction, dependencies) = pair
                guard !completed.contains(instruction), dependencies.isSubset(of: completed) else {
                    return nil
                }
                
                return instruction
            }.sorted()
    }
    
    var completed: [Character] = []
    var queued: [Character] = []
    
    for timeStamp in 0... {
        for index in 0 ..< workers.count {
            guard case let .workingOn(char, time) = workers[index], time == timeStamp else {
                continue
            }
            
            completed.append(char)
            queued.removeAll(where: { $0 == char })
            workers[index] = .free
        }
        
        let nextInstructions = completableInstructions(completed)
            .filter { (queued.contains($0) || completed.contains($0)) == false }
        
        for instruction in nextInstructions {
            guard let freeWorkerIndex = workers.firstIndex(where: { $0 == .free }) else {
                break
            }
            
            workers[freeWorkerIndex] = .workingOn(char: instruction, timeStamp: timeStamp + instruction.time)
            queued.append(instruction)
        }
        
        if workers.allSatisfy({ $0 == .free }) {
            return "\(timeStamp)"
        }
    }
    
    return "Welp this didn't work"
}

print(partOne())
print(partTwo())
//: [Next](@next)
