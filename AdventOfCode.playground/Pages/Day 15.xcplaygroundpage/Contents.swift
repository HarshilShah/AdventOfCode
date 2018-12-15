//: [Previous](@previous)
import Foundation

let input = """
################################
#######..##########.##.G.##.####
#######...#######........#..####
#######..G.######..#...##G..####
########..G###........G##...####
######....G###....G....###.#####
######....####..........##..####
#######...###...........##..E..#
#######.G..##...........#.#...##
######....#.#.....#..GG......###
#####..#..G...G........G.#....##
##########.G.......G........####
#########.G.G.#####EE..E...#####
#########....#######.......#####
#########...#########.......####
########....#########...G...####
#########...#########.#....#####
##########..#########.#E...E####
######....#.#########........#.#
######..G.#..#######...........#
#####.........#####.E......#####
####........................####
####.........G...####.....######
##................##......######
##..........##.##.........######
#............########....E######
####..........#######.E...######
####........#..######...########
########....#.E#######....######
#########...####################
########....####################
################################
"""

struct Position: Equatable, Hashable {
    var x: Int
    var y: Int
}

public enum Direction {
    case up, left, right, down
}

extension Direction: Comparable {
    public static func < (lhs: Direction, rhs: Direction) -> Bool {
        if lhs == .up { return true }
        if lhs == .left && rhs != up { return true }
        if lhs == .right && rhs == .down { return true }
        return false
    }
}

extension Array: Comparable where Element == Direction {
    public static func < (lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return lhs.count < rhs.count
        }
        
        for (left, right) in zip(lhs, rhs) {
            if left == right {
                continue
            } else {
                return left < right
            }
        }
        
        return true
    }
}

enum BoardPiece: Equatable {
    case open, wall
}

struct AttackPiece: Equatable {
    enum Kind: Equatable {
        case elf, goblin
        
        var opposite: Kind {
            switch self {
            case .elf: return .goblin
            case .goblin: return .elf
            }
        }
    }
    
    let kind: Kind
    var x: Int
    var y: Int
    var position: Position { return Position(x: x, y: y) }
    
    var health = 200
    
    init(kind: Kind, y: Int, x: Int) {
        self.kind = kind
        self.y = y
        self.x = x
    }
    
    mutating func move(_ direction: Direction) {
        switch direction {
        case .up: y -= 1
        case .down: y += 1
        case .left: x -= 1
        case .right: x += 1
        }
    }
}

enum Piece: Equatable {
    case board(BoardPiece)
    case attack(AttackPiece)
    
    var attackPiece: AttackPiece? {
        guard case let .attack(attackPiece) = self else {
            return nil
        }
        
        return attackPiece
    }
}

struct Path {
    var from: Piece
    var to: Position
    var direction: [Direction]
}

struct Board {
    let elfAttack: Int
    let goblinAttack: Int
    
    var _backing: [[BoardPiece]]
    var _pieces: [AttackPiece]
    
    init(elfAttack: Int = 3, goblinAttack: Int = 3, text: String) {
        self.elfAttack = elfAttack
        self.goblinAttack = goblinAttack
        
        _backing = text
            .components(separatedBy: .newlines)
            .map { line in
                line.map { character -> BoardPiece in
                    switch character {
                    case "#": return .wall
                    default: return .open
                    }
                }
        }
        
        _pieces = text
            .components(separatedBy: .newlines)
            .enumerated()
            .flatMap { element -> [AttackPiece] in
                let (y, line) = element
                return line
                    .enumerated()
                    .compactMap { element -> AttackPiece? in
                        let (x, character) = element
                        let kind: AttackPiece.Kind
                        switch character {
                        case "E": kind = .elf
                        case "G": kind = .goblin
                        default: return nil
                        }
                        
                        return AttackPiece(kind: kind, y: y, x: x)
                }
        }
    }
    
    var scores: [Int] {
        return _pieces.map { $0.health }
    }
    
    var teamScores: (elf: [Int], goblin: [Int]) {
        var elf: [Int] = []
        var goblin: [Int] = []
        
        for piece in _pieces {
            switch piece.kind {
            case .elf: elf.append(piece.health)
            case .goblin: goblin.append(piece.health)
            }
        }
        
        return (elf, goblin)
    }
    
    func element(at position: Position) -> Piece {
        if let attackPiece = _pieces.filter({ $0.health > 0 }).first(where: { $0.position == position }) {
            return .attack(attackPiece)
        } else {
            return .board(_backing[position.y][position.x])
        }
    }
    
    func neighbours(_ position: Position) -> [(position: Position, direction: Direction)] {
        var result: [(Position, Direction)] = []
        let y = position.y
        let x = position.x
        
        if y > 0 { result.append((Position(x: x, y: y - 1), .up)) }
        if x > 0 { result.append((Position(x: x - 1, y: y), .left)) }
        if x < _backing[y].count - 1 { result.append((Position(x: x + 1, y: y), .right)) }
        if y < _backing.count - 1 { result.append((Position(x: x, y: y + 1), .down)) }
        return result.filter { element(at: $0.0) != .board(.wall) }
    }
    
    mutating func move(pieceAtIndex index: Int) {
        var piece: AttackPiece {
            get { return _pieces[index] }
            set { _pieces[index] = newValue }
        }
        
        var paths = neighbours(piece.position)
            .filter { element(at: $0.position) == .board(.open) }
            .map { Path(from: .attack(piece), to: $0.position, direction: [$0.direction]) }
        
        var shortestPaths: [Position: Path] = paths.reduce(into: [:]) { dictionary, path in
            dictionary[path.to] = path
        }
        
        var didFindNewPaths = false
        var didFindOppositeElement = false
        var shouldContinue: Bool {
            if didFindOppositeElement {
                return false
            }
            
            return didFindNewPaths
        }
        
        repeat {
            didFindNewPaths = false
            
            paths = paths.flatMap { path -> [Path] in
                let neighboursToVisit = neighbours(path.to).filter {
                    if let attackPiece = element(at: $0.position).attackPiece {
                        return attackPiece.kind != piece.kind
                    }
                    
                    return true
                }
                
                let newPaths = neighboursToVisit
                    .map { Path(from: .attack(piece), to: $0.position, direction: path.direction + [$0.direction]) }
                    .filter { shortestPaths[$0.to] == nil }
                
                if newPaths.count > 0 {
                    didFindNewPaths = true
                    newPaths.forEach { shortestPaths[$0.to] = $0 }
                }
                
                return newPaths
            }
            
            if shortestPaths.contains(where: { element(at: $0.key).attackPiece?.kind == piece.kind.opposite }) {
                didFindOppositeElement = true
            }
            
        } while shouldContinue
        
        let closestEnemy = shortestPaths
            .filter { element(at: $0.key).attackPiece?.kind == piece.kind.opposite }
            .sorted { $0.value.direction < $1.value.direction }
            .first
        
        if let direction = closestEnemy?.value.direction.first {
            piece.move(direction)
        }
    }
    
    func attack(forPieceKind kind: AttackPiece.Kind) -> Int {
        switch kind {
        case .elf: return elfAttack
        case .goblin: return goblinAttack
        }
    }
    
    mutating func attack(pieceAtIndex index: Int) {
        let piece = _pieces[index]
        let next = neighbours(piece.position)
        let enemyNeighbours = next
            .compactMap { element(at: $0.position).attackPiece }
            .filter { $0.kind != piece.kind }
            .filter { $0.health > 0 }
        let minimumHealth = enemyNeighbours.min(by: { $0.health < $1.health })?.health
        
        if let minimumHealth = minimumHealth {
            let pieceToAttack = enemyNeighbours.first(where: { $0.health == minimumHealth })!
            let indexToAttack = _pieces.firstIndex(of: pieceToAttack)!
            _pieces[indexToAttack].health -= attack(forPieceKind: piece.kind)
        }
    }
    
    mutating func iterate() {
        _pieces.sort { ($0.y < $1.y) || ($0.y == $1.y && $0.x < $1.x) }
        _pieces.indices.forEach { index in
            var piece: AttackPiece {
                get { return _pieces[index] }
                set { _pieces[index] = newValue }
            }
            
            guard piece.health > 0 else {
                return
            }
            
            let canMove: Bool = {
                return neighbours(piece.position)
                    .compactMap { element(at: $0.position).attackPiece }
                    .filter { $0.kind != piece.kind && $0.health > 0 }
                    .count == 0
            }()
            
            if canMove {
                move(pieceAtIndex: index)
            }
            
            attack(pieceAtIndex: index)
        }
        
        _pieces.removeAll { $0.health <= 0 }
    }
}

func partOne() -> String {
    var board = Board(text: input)
    var iterations = 0
    
    repeat {
        board.iterate()
        iterations += 1
    } while board.teamScores.elf.count > 0 && board.teamScores.goblin.count > 0
    
    let scores = board.teamScores
    let winnerScores = scores.elf.count == 0 ? scores.goblin : scores.elf
    let maxScore = winnerScores.reduce(0, +)
    let result = (iterations - 1) * maxScore
    let resultString = "\(result)"
    return resultString
}

func partTwo() -> String {
    func score(board: Board, elfAttack: Int, elfCount: Int) -> Int? {
        var board = board
        var iterations = 0
        var elfScores: [Int] = []
        
        repeat {
            board.iterate()
            iterations += 1
            elfScores = board.teamScores.elf
        } while elfScores.count == elfCount && board.teamScores.goblin.count > 0
        
        guard elfScores.count == elfCount else {
            return nil
        }
        
        let elfScore = elfScores.reduce(0, +)
        let result = (iterations - 1) * elfScore
        return result
    }
    
    var board = Board(text: input)
    var elfAttack = 3
    let elfCount = board.teamScores.elf.count
    var result: Int? = nil
    
    repeat {
        elfAttack += 1
        board = Board(elfAttack: elfAttack, text: input)
        result = score(board: board, elfAttack: elfAttack, elfCount: elfCount)
    } while result == nil
    
    let resultString = "\(result!)"
    return resultString
}

print(partOne())
print(partTwo())
//: [Next](@next)
