//: [Previous](@previous)
import Foundation

let input = """
initial state: #.#####.#.#.####.####.#.#...#.......##..##.#.#.#.###..#.....#.####..#.#######.#....####.#....##....#

##.## => .
#.#.. => .
..... => .
##..# => #
###.. => #
.##.# => .
..#.. => #
##.#. => #
.##.. => .
#..#. => .
###.# => #
.#### => #
.#.## => .
#.##. => #
.###. => #
##### => .
..##. => .
#.#.# => .
...#. => #
..### => .
.#.#. => #
.#... => #
##... => #
.#..# => #
#.### => #
#..## => #
....# => .
####. => .
#...# => #
#.... => .
...## => .
..#.# => #
"""

let components = input.components(separatedBy: .newlines)

let inputString = components[0].dropFirst(15)

let rules: [[Character]: Character] = components[2...]
    .reduce(into: [:]) { dict, line in
        dict[Array(line.prefix(5))] = line.last!
    }

func nextGeneration(from current: inout [Character], offset: inout Int) {
    let prefix = current.prefix(while: { $0 == ".".first })
    offset += prefix.count
    current.removeFirst(prefix.count)
    
    let suffix = current.reversed().prefix(while: { $0 == ".".first })
    current.removeLast(suffix.count)
    
    let padding = Array("....")
    current = current + padding
    
    var buffer = padding
    offset -= 2
    
    var nextGeneration = [Character]()
    
    for character in current {
        buffer.append(character)
        defer { buffer.removeFirst() }
        let nextCharacter = rules[buffer] ?? "."
        nextGeneration.append(nextCharacter)
    }
    
    current = nextGeneration
}

func value(_ array: [Character], offset: Int) -> Int {
    return array
        .enumerated()
        .map { $0.element == "#".first ? $0.offset + offset : 0 }
        .reduce(0, +)
}

func partOne() -> String {
    let generations = 20
    
    var current = Array(inputString)
    var offset = 0
    
    for _ in 1 ... generations {
        nextGeneration(from: &current, offset: &offset)
    }
    
    let result = value(current, offset: offset)
    return "\(result)"
}

func partTwo() -> String {
    let generations = 50_000_000_000
    
    var current = Array(inputString)
    var offset = 0
    
    var visited: [[Character]: (gen: Int, offset: Int)] = [:]
    
    for gen in 1 ... generations {
        nextGeneration(from: &current, offset: &offset)
        
        if let (previousGen, previousOffset) = visited[current] {
            let genDifference = gen - previousGen
            let offsetDifference = offset - previousOffset
            let remainingGens = generations - gen
            
            if remainingGens % genDifference == 0 {
                offset += remainingGens * offsetDifference
                break
            }
        } else {
            visited[current] = (gen, offset)
        }
    }
    
    let result = value(current, offset: offset)
    return "\(result)"
}

print(partOne())
print(partTwo())
//: [Next](@next)
