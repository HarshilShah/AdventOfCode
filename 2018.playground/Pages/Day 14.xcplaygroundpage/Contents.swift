//: [Previous](@previous)
import Foundation

let input = """
165061
"""

class MultipleRunnerDoublyLinkedList {
    
    class Node {
        var value: Int
        var next: Node!
        var previous: Node!
        
        init(_ value: Int) {
            self.value = value
        }
    }
    
    enum Direction {
        case forwards, backwards
    }
    
    var current: Node
    var head: Node
    var runners: [Node]
    
    init(value: Int, runners: Int) {
        let head = Node(value)
        head.next = head
        head.previous = head
        
        self.head = head
        self.current = head
        self.runners = Array(repeating: head, count: runners)
    }
    
    func move(runner: Int, inDirection direction: Direction = .forwards, steps: Int = 1) {
        for _ in 1...steps {
            runners[runner] = runners[runner].next
        }
    }
    
    func move(inDirection direction: Direction = .forwards, steps: Int = 1) {
        for _ in 1 ... steps {
            switch direction {
            case .forwards:  current = current.next
            case .backwards: current = current.previous
            }
        }
    }
    
    func insert(_ value: Int) {
        let newNode = Node(value)
        
        newNode.next = current.next
        current.next.previous = newNode
        newNode.previous = current
        current.next = newNode
        
        current = newNode
    }
    
    func insertAtEnd(_ value: Int) {
        current = head.previous
        insert(value)
    }
    
    func remove() -> Int {
        let removedNode = current
        move()
        
        let value = removedNode.value
        
        removedNode.previous.next = removedNode.next
        removedNode.next.previous = removedNode.previous
        
        removedNode.previous = nil
        removedNode.next = nil
        
        return value
    }
}

let recipeCountLimit = Int(input)!
let initialRecipes: (Int, Int) = (3, 7)

func partOne() -> String {
    let recipes = MultipleRunnerDoublyLinkedList(value: initialRecipes.0, runners: 2)
    recipes.insert(initialRecipes.1)
    recipes.move(runner: 1)
    
    var recipeCount = 2
    
    repeat {
        let firstValue  = recipes.runners[0].value
        let secondValue = recipes.runners[1].value
        
        let newRecipe = firstValue + secondValue
        if newRecipe >= 10 {
            recipes.insertAtEnd(newRecipe / 10)
            recipes.insertAtEnd(newRecipe % 10)
            recipeCount += 2
        } else {
            recipes.insertAtEnd(newRecipe)
            recipeCount += 1
        }
        
        recipes.move(runner: 0, steps: 1 + firstValue)
        recipes.move(runner: 1, steps: 1 + secondValue)
    } while recipeCount < recipeCountLimit + 10
    
    var result = ""
    
    recipes.current = recipes.head
    
    for _ in 1 ... recipeCountLimit {
        recipes.move()
    }
    
    for _ in 1 ... 10 {
        result.append("\(recipes.current.value)")
        recipes.move()
    }
    
    return result
}

func partTwo() -> String {
    let recipes = MultipleRunnerDoublyLinkedList(value: initialRecipes.0, runners: 2)
    recipes.insert(initialRecipes.1)
    recipes.move(runner: 1)
    
    var recipeCount = 2
    
    let bufferSizeLimit = input.count
    var buffer = Array(repeating: 0, count: bufferSizeLimit - recipeCount)
    buffer.append(initialRecipes.0)
    buffer.append(initialRecipes.1)
    
    let searchValue = input.map({ String($0) }).map({ Int($0)! })
    
    var matchFound = false
    
    repeat {
        var bufferQueue: [Int]
        
        let firstValue  = recipes.runners[0].value
        let secondValue = recipes.runners[1].value
        let newRecipe = firstValue + secondValue
        
        if newRecipe >= 10 {
            recipes.insertAtEnd(1)
            recipes.insertAtEnd(newRecipe % 10)
            bufferQueue = [1, newRecipe % 10]
        } else {
            recipes.insertAtEnd(newRecipe)
            bufferQueue = [newRecipe]
        }
        
        for item in bufferQueue {
            buffer.append(item)
            buffer.removeFirst()
            recipeCount += 1
            
            if buffer == searchValue {
                matchFound = true
                break
            }
        }
        
        if matchFound {
            break
        }
        
        recipes.move(runner: 0, steps: 1 + firstValue)
        recipes.move(runner: 1, steps: 1 + secondValue)
    } while true
    
    let result = "\(recipeCount - input.count)"
    return result
}

print(partOne())
print(partTwo())
//: [Next](@next)
