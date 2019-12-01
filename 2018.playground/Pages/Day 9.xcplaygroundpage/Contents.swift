//: [Previous](@previous)
import Foundation

let input = """
416 players; last marble is worth 71975 points
"""

class DoublyLinkedList {
    
    class Node {
        var value: Int
        var next: Node?
        var previous: Node?
        
        init(_ value: Int) {
            self.value = value
        }
    }
    
    enum Direction {
        case forwards, backwards
    }
    
    var current: Node
    var head: Node
    
    init(head: Node) {
        head.next = head
        head.previous = head
        
        self.head = head
        self.current = head
    }
    
    func move(inDirection direction: Direction = .forwards, steps: Int = 1) {
        for _ in 1 ... steps {
            switch direction {
            case .forwards:  current = current.next!
            case .backwards: current = current.previous!
            }
        }
    }
    
    func insert(_ value: Int) {
        let newNode = Node(value)
        
        newNode.next = current.next!
        current.next!.previous = newNode
        newNode.previous = current
        current.next = newNode
        
        current = newNode
    }
    
    func remove() -> Int {
        let removedNode = current
        move()
        
        let value = removedNode.value
        
        removedNode.previous?.next = removedNode.next
        removedNode.next?.previous = removedNode.previous
        
        removedNode.previous = nil
        removedNode.next = nil
        
        return value
    }
}

func scores(playerCount: Int, marbleCount: Int) -> [Int] {
    var scores = Array(repeating: 0, count: playerCount + 1)
    let marbles = DoublyLinkedList(head: DoublyLinkedList.Node(0))
    var currentPlayer = 1
    
    for marble in 1...marbleCount {
        if marble % 23 == 0 {
            marbles.move(inDirection: .backwards, steps: 7)
            let removedMarble = marbles.remove()
            scores[currentPlayer] += marble + removedMarble
        } else {
            marbles.move()
            marbles.insert(marble)
        }
        
        currentPlayer = (currentPlayer % playerCount) + 1
    }
    
    return scores
}

let playerCount = Int(input.components(separatedBy: .whitespaces).first!)!
let marbleCount = Int(input.components(separatedBy: .whitespaces).dropLast().last!)!

func partOne() -> String {
    let result = scores(playerCount: playerCount, marbleCount: marbleCount).max()!
    return "\(result)"
}

func partTwo() -> String {
    let result = scores(playerCount: playerCount, marbleCount: marbleCount * 100).max()!
    return "\(result)"
}

print(partOne())
print(partTwo())
//: [Next](@next)
