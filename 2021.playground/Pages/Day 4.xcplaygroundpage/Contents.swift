//: [Previous](@previous)

import Foundation

let input = """
<Insert your input here>
"""

struct Position: Hashable {
    let x: Int
    let y: Int
}

struct Board {
    var numbers: [Position: Int]
    
    var markedNumbers: Set<Int>
    var lastNumber: Int?
    
    mutating func mark(_ number: Int) {
        markedNumbers.insert(number)
        lastNumber = number
    }
    
    func score() -> Int? {
        var hasWon = false
        for row in (0 ..< 5) {
            if hasWon { break }
            
            let positions = (0 ..< 5).lazy.map { Position(x: row, y: $0) }
            if positions.allSatisfy({ markedNumbers.contains(numbers[$0]!) }) {
                hasWon = true
            }
        }
        
        for column in (0 ..< 5) {
            if hasWon { break }
            
            let positions = (0 ..< 5).lazy.map { Position(x: $0, y: column) }
            if positions.allSatisfy({ markedNumbers.contains(numbers[$0]!) }) {
                hasWon = true
            }
        }
        
        guard hasWon else { return nil }
        var allNumbers = Set(numbers.values)
        markedNumbers.forEach { allNumbers.remove($0) }
        return allNumbers.reduce(0, +) * lastNumber!
    }
}


let numbers =  input
    .split(separator: "\n")
    .first!
    .split(separator: ",")
    .map { Int($0)! }

let boardChunks = input
    .drop(while: { $0 != "\n" })
    .dropFirst()
    .components(separatedBy: "\n\n")

let initialBoards = boardChunks.map { chunk -> Board in
    var board = Board(numbers: [:], markedNumbers: [], lastNumber: nil)
    chunk.split(separator: "\n").enumerated().forEach { row, line in
        line.split(separator: " ").compactMap({ Int($0) }).enumerated().forEach { column, value in
            board.numbers[Position(x: row, y: column)] = value
        }
    }
    return board
}

func partOne() -> String {
    var boards = initialBoards
    
    for number in numbers {
        boards.indices.forEach {
            boards[$0].mark(number)
        }
        
        if let score = boards.lazy.compactMap({ $0.score() }).first {
            return score.description
        }
    }
    
    fatalError("This shouldn't happen")
}

func partTwo() -> String {
    var boards = initialBoards
    
    for number in numbers {
        boards.indices.forEach {
            boards[$0].mark(number)
        }
        
        if boards.count == 1, let score = boards.first?.score() {
            return score.description
        }
        
        boards.removeAll { $0.score() != nil }
    }
    
    fatalError("This shouldn't happen")
}

print(partOne())
print(partTwo())

//: [Next](@next)
