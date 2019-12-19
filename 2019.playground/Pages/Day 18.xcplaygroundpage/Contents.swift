//: [Previous](@previous)

import Foundation

let input = """
#################################################################################
#.........#.........#...#..q#.....#.....#.................#..........e......#...#
#####.###.###.#####.#.#.#.#.#.###.#.###.#.#####.#.#######.###############.#.###.#
#.....#..i....#...#.#.#.#.#.#.#.#.#.#.#.#.....#.#.#....z#.....C.........#.#.....#
#.###.###########.#.#.###.#.#.#.#.#.#.#.#####.#.#.#.###.###############.#.#####.#
#...#.#.........#.#.#...#.#.....#d#.#j..#.....#.#.#.#...#.........#.....#...#...#
###.###.#####.#.#.#.###.#.#######.#.###.#.#####.#.#.#.###.#######.#####.###.#.###
#...#...#...#.#.#.......#.#.#.....#...#.#.#.#...#.#.#.#.........#.#...#.....#...#
#.###.###.#.###.#######.#.#.#.#####.#.###.#.#.###.#.#.#.#######.#.#.#.#########.#
#...#.#...#.....#...#...#...#.#...#.#...#...#.#...#.#...#...#...#...#.#.....#...#
#.#.#.#.#.#####.#.#.#######.#.###.#.###.#.###K#####.#####.#.#########.#.#####.###
#.#...#.#.#...#.#.#.........#...#.#...#.#.#...#...#.....#.#.#........v#.......#.#
#.#####.###.#.#.#.###########.#.#.###.#N#.#.###.#.#####.#L#.#.#############.###.#
#.#...#.....#.#.#.#...#.....#.#.#.#...#.#.#.#...#.....#.#.#.#.....#.......#.....#
#.#.#.#######.###.#.###.###.###.#.#.###.###.#.#######.#.#.#.#.###.#.#####.#####.#
#.#.#.......#.....#...#.#.......#.#...#.#...#...#.S.#.#.#.#.#...#.#....y#.#.#...#
#.#.#####.#.#########.#.#########.#.###.#.#.###.#.#.#.#.#.#G#####.#####.#.#.#.###
#.#.....#.#.#.........#.W.#.....#.#.#...#.#.#...#.#.#...#.#.#.......#...#.#...#.#
#.#######.#.###.###.#####.#.#.#.#.#.#.#.#.###.###.#.#.###.#.#.#####.#T###.#.###.#
#.......#.#.....#.#.#.....#.#.#.#...#.#.#.#...#...#.#...#.#.#.....#.#...#.#.#...#
#######.#.#######.#.#.#######.#.#.###.###.#.###.###.#####.#.#####.#####.#.#.#.#.#
#.#.....#.#.......#.#.#.....#.#.#...#...#...#.#.#.#.......#.#...#.......#.#...#.#
#.#.#####.#.#.###.#.###.###.#.#.#####.#.#.###.#.#.#########.###.#######.#.#####.#
#...#.....#r#...#.#.....#.#...#.....#.#.#.....#.....A.#...#..p..#.....#.#.#.....#
#.#####.#######.#########.#########.###.#####.#######.#.#########.###.###.#####.#
#.......#.....#.......#...#.......#...#.#.#...#.....#.#.......H...#.....#.....#.#
###########.#.###.#####.#.#.#####.###.#.#.#.###.#.#.#.#####.#.#########.###.#.###
#.........#.#.....#.....#.#.....#...#...#.#...#.#.#.#.#...#.#.......#.#...#.#...#
#.#######.#.#####.#.#####.#####.###.###.#.###.###.###.#.#M###.#####.#.###.#####R#
#...#...#.#.....#.#.#...#.....#.#.#...#.#...#...#...#...#...#...#...#...#...#...#
###.#.#.#.#####.###.#.#######.#.#.#.###.#.#.###.###.#######.###.#.###.#.###.#.###
#...#.#...#...#.#...#.......#.....#.#...#.#.#...#...#.....#...#.#...#.#.#...#...#
#.#######.#.#.#.#.###.#####.#######.#O###.###.###.###.###.###.#.###.#.#.#.#####.#
#.#.....#.#.#...#...#.#.#.......#...#...#.....#...#...#.#.#...#.#.#.#.#.#.....#.#
#.#.###.#.#.#.#####.#.#.#.#.#####.#####.#.#######.#.###.#.#.###.#.#B###.#####.#.#
#.#.#...#...#.#.....#...#.#.#...#.#.....#.....#...#...#.#...#.....#...#.....#.#.#
#.#E#.#########.#####.###.#.#.#.#.#.#########.#.#####.#.#############.#.#####.#.#
#...#.#.......#.....#.#...#.#.#...#.#...#...#.#.#.....#.....#.......#.#.......#.#
#.###.#.#####.#####.###.###.#.#####.###.#.#.#.#.#.#####.###.#.#####.#.#.#######.#
#...#.......#...........#...#.............#.....#.......#.....#......x#.........#
#######################################.@.#######################################
#.......#.......#.....................#.......#...#...#.....#.......#...#.......#
#.#######.#####.#.#.#################.#.#####.#.#.#.#.#.###.#.#####.#.#.#.###.#.#
#...#.....#...#...#.....#.......#.....#.#...#...#.#.#...#.#.#.#...#...#...#...#.#
#.#.#.#####.#.#########.#.###.###.#####.#.#.###.#.#.#####.#.#.#.###########.###.#
#.#.#.......#.......#...#...#...#.....#.#.#...#.#.#.#.....#...#.......#.#...#...#
#.#.#####.#####.#####.#########.#####.#.#.###.###.#.#.#.#########.###.#.#.###.###
#.#...#...#...#.#.....#...........#...#.#.#.#.#...#.#.#...........#.....#...#...#
#####.#.###.#.###.#####.#.#.#######.###.#.#.#.#.#.#.#.#######.#.#########.#.###.#
#.....#.#...#.....#.....#.#.#....o......#k#...#.#.#.#.#.......#.#.......#.#...#.#
#.#####.#.#############.#.###.#########.#.###.#.#.#.#.#.#######.#.#####.#####.#.#
#..c....#.#.....#.....#.#.......#.....#.#...#n..#.#.#.#...#.#...#...#.....#...#.#
#.#####.#.#.###.#.###.#######.###.###.#.#.#.#######.#####.#.#.#####.#####.#.#####
#.#...#.#.....#.....#.#f....#.#...#...#.#.#...#...#.......#.#.#.#...#..u#.#.....#
###.#.###############.#.###.#.#.#####.#.#####.#.#.#########.#.#.#.#.#.#.#.#.###.#
#...#.#...............#...#.#.#.....#.#.#...#.#.#...#.......#...#.#.#.#.#.#.#...#
#.###.#.#######Z#########.#.#.#####.#.#.#.#.#.#.#.###.#.#######.#.###.#.#.###.###
#...#...#.......#...#.....#.#.#.....#.#.#.#.#.#.#.....#.....#...#.....#.#...#...#
#.#.###.#########.#.#.#####.###.#####.###.#.#.#.#######.###.#.#########.###.#.#.#
#.#...#.#.........#.#.#...#...U.#...#...#.#...#.#.....#...#.......#.#...#...#.#.#
#.###.###.#########.#.#.###########.###.#.#.###.#.###.###########.#.#.###.#####.#
#.#.#.#.V.#.....#...#.#.............#...#.#.#...#.#...#.P.....#...#.#.#...#....w#
#.#.#.#.###.#.###.#.#############.#.#.###.###.###.#.###.#######.###.#.#.###.#####
#...#...#...#.#...#.#.....#.......#.#...#...#...#.#.....#.....#.#...#.#...#.....#
###.#####.###.#.###.#.###.#.###########.#.#J###.#.#########.#.#.#.###.###.###.#.#
#.#...#.....#.#.#...#.#.....#.......#...#.#.....#.#.....#...#.#.#...#...#...#.#.#
#.###.#####.###.#.###.#######.#####.#.###.#######.#.#.#.#.###.#.###.###.###.###.#
#...#.......#...#.....#.......#...#...#.#.#...#...#s#.#.#a#...#.....#...#.#.....#
#.###.#######.#####.###.#######.#.#####.#.#.#.#.#####.#.#.#.#####.###F###.#####.#
#.....#.......#...#.#...#.....#.#.....#.#.#.#.#g..#...#...#.....#.#...#.......#.#
#.#####.#######.#.#.#.#####.#.###.###.#.#.#.#####.#.###########.###.###.#######.#
#...#.#.....#...#...#.......#...#.#...#.#.#.....#.#.#...#.....#..m..#.......#...#
###.#.#####.#.#################.#.#.###.#.#.###.#.#.#.#.#.#.#.#############.#.###
#...#.#.....#.#.......#.#.D.....#.#.....#.#...#.#.#.#.#...#.#.....#.......#.#...#
#.###.#Y#####.#.#####.#.#.#######.#####.#.#####.#.#.###.###.#######.#.###.#.###.#
#.#...#...#.#...#...#...#.....#...#h#...#.......#.#...#...#...#...#.#...#.#...#.#
#.#.#.###.#.###.#.#.###.#####.#.###.#.#######.###.#.#.###.###.#.#.#.###.#.#.###.#
#.#.#...#.#.....#.#...#.#.....#...#.#.#.#.....#...#.#.#.#.#.#.#.#.#.#.#.#...#...#
#I#####.#.#######.###.###Q#######.#.#.#.#.#####.#####.#.#.#.#.#X#.#.#.#.#####.###
#t......#...........#.............#.....#.....#....l..#.....#...#.....#..b......#
#################################################################################
"""

struct Point: Equatable, Hashable {
    var x: Int
    var y: Int
    
    static let zero = Point(x: 0, y: 0)
    
    func moving(in direction: Direction) -> Point {
        switch direction {
        case .up: return Point(x: x, y: y - 1)
        case .down: return Point(x: x, y: y + 1)
        case .left: return Point(x: x - 1, y: y)
        case .right: return Point(x: x + 1, y: y)
        }
    }
}

enum Direction: CaseIterable {
    case left, right, up, down
}

struct Path: Equatable, Hashable {
    let location: Point
    let destination: Character
    let obstacles: [Character]
    let steps: Int
}

func generatePaths(from initialPosition: Point, board: [Point: Character]) -> Set<Path> {
    var paths: Set<Path> = []
    
    var steps = 0
    var currentPositions: [(position: Point, obstacles: [Character])] = [(initialPosition, [])]
    var visited: [Point: Int] = [initialPosition : steps]
    var visitedNewPositions = true
    
    while visitedNewPositions {
        let newPositions = currentPositions
            .flatMap { currentPosition in
                Direction
                    .allCases
                    .map { currentPosition.position.moving(in: $0) }
                    .filter { board[$0] != "#" }
                    .filter { visited.keys.contains($0) == false }
                    .map { ($0, board[$0]!.isUppercase ? currentPosition.obstacles + [board[$0]!] : currentPosition.obstacles) }
            }
        
        if newPositions.isEmpty == false {
            steps += 1
            newPositions.forEach {
                visited[$0.0] = steps
                if board[$0.0]!.isLowercase {
                    paths.insert(Path(location: $0.0, destination: board[$0.0]!, obstacles: $0.1, steps: steps))
                }
            }
            currentPositions = newPositions
        }
        
        visitedNewPositions = !newPositions.isEmpty
    }
    
    return paths
}

let initialBoard: [Point: Character] = {
    var dict: [Point: Character] = [:]
    
    input
        .split(separator: "\n")
        .enumerated()
        .forEach { y, line in
            line
                .enumerated()
                .forEach { x, char in
                    dict[Point(x: x, y: y)] = char
                }
        }
    
    return dict
}()

func partOne() -> String {
    struct State: Equatable, Hashable {
        var position: Point
        var remainingKeys: Set<Character>
    }
    
    var visited: [State: Int] = [:]
    var minScore = Int.max
    
    func move(state: State, paths: [Point: Set<Path>], steps initialSteps: Int) {
        guard initialSteps < minScore else { return }
        
        let remainingKeys = state.remainingKeys
        let remainingLocks = remainingKeys.map { $0.uppercased().first! }
        
        guard remainingKeys.isEmpty == false else {
            minScore = min(initialSteps, minScore)
            return
        }
        
        if let existing = visited[state], existing <= initialSteps {
            return
        }

        visited[state] = initialSteps
        
        paths[state.position]!
            .filter { path in
                remainingKeys.contains(path.destination) &&
                path.obstacles.allSatisfy { remainingLocks.contains($0) == false } &&
                initialSteps + path.steps < minScore
            }
            .sorted { $0.steps < $1.steps }
            .forEach { next in
                var newState = state
                newState.position = next.location
                newState.remainingKeys.remove(next.destination)
                move(state: newState, paths: paths, steps: initialSteps + next.steps)
            }
    }
    
    var board = initialBoard
    let startingPoint = board.first(where: { $0.value == "@" })!.key
    board[startingPoint] = "."
    
    var paths: [Point: Set<Path>] = [:]
    paths.reserveCapacity(30)
    
    let pathStartingPoints = [startingPoint] + board.filter({ $0.value.isLowercase }).keys
    pathStartingPoints.forEach { paths[$0] = generatePaths(from: $0, board: board) }
    
    let initialState = State(
        position: startingPoint,
        remainingKeys: Set(board.filter({ $0.value.isLowercase }).values)
    )
    move(state: initialState, paths:paths, steps: 0)
    return minScore.description
}


func partTwo() -> String {
    struct State: Equatable, Hashable {
        var positions: Set<Point>
        var remainingKeys: Set<Character>
    }
    
    var visited: [State: Int] = [:]
    var minScore = Int.max
    
    func move(state: State, paths: [Point: Set<Path>], steps initialSteps: Int) {
        guard initialSteps < minScore else { return }
        
        let remainingKeys = state.remainingKeys
        let remainingLocks = remainingKeys.map { $0.uppercased().first! }
        
        guard remainingKeys.isEmpty == false else {
            minScore = min(initialSteps, minScore)
            return
        }
        
        if let existing = visited[state], existing <= initialSteps {
            return
        }
        
        visited[state] = initialSteps
        
        state.positions
            .flatMap { position -> [(Point, Path)] in
                return paths[position]!
                    .filter { path in
                        remainingKeys.contains(path.destination) &&
                        path.obstacles.allSatisfy { remainingLocks.contains($0) == false } &&
                        initialSteps + path.steps < minScore
                    }
                    .map { (position, $0) }
            }
            .sorted { $0.1.steps < $1.1.steps }
            .forEach { initialPosition, next in
                var newState = state
                newState.positions.remove(initialPosition)
                newState.positions.insert(next.location)
                newState.remainingKeys.remove(next.destination)
                move(state: newState, paths: paths, steps: initialSteps + next.steps)
            }
    }
    
    var board = initialBoard
    let originalStartingPoint = board.first(where: { $0.value == "@" })!.key
    
    var startingPoints: [Point] = []
    startingPoints.reserveCapacity(4)
    
    for y in (-1 ... 1) {
        for x in (-1 ... 1) {
            let position = Point(x: originalStartingPoint.x + x, y: originalStartingPoint.y + y)
            if abs(x) == 1, abs(y) == 1 {
                startingPoints.append(position)
                board[position] = "."
            } else {
                board[position] = "#"
            }
        }
    }
    
    var paths: [Point: Set<Path>] = [:]
    paths.reserveCapacity(30)
    
    let pathStartingPoints = startingPoints + board.filter({ $0.value.isLowercase }).keys
    pathStartingPoints.forEach { paths[$0] = generatePaths(from: $0, board: board) }
    
    let initialState = State(
        positions: Set(startingPoints),
        remainingKeys: Set(board.filter({ $0.value.isLowercase }).values)
    )
    move(state: initialState, paths: paths, steps: 0)
    return minScore.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
