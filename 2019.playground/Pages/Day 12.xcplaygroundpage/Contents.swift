//: [Previous](@previous)

import Foundation

let input = """
<x=10, y=15, z=7>
<x=15, y=10, z=0>
<x=20, y=12, z=3>
<x=0, y=-3, z=13>
"""

struct Vector: Equatable, Hashable {
    var x: Int
    var y: Int
    var z: Int
    
    static let zero = Vector(x: 0, y: 0, z: 0)
}

struct Moon: Equatable {
    var position: Vector
    var velocity: Vector
    
    var potentialEnergy: Int { abs(position.x) + abs(position.y) + abs(position.z) }
    var kineticEnergy: Int { abs(velocity.x) + abs(velocity.y) + abs(velocity.z) }
    var totalEnergy: Int { potentialEnergy * kineticEnergy }
    
    mutating func move() {
        position.x += velocity.x
        position.y += velocity.y
        position.z += velocity.z
    }
}

extension Array where Element == Moon {
    var xValues: [Int] { map({ $0.position.x }) + map({ $0.velocity.x }) }
    var yValues: [Int] { map({ $0.position.y }) + map({ $0.velocity.y }) }
    var zValues: [Int] { map({ $0.position.z }) + map({ $0.velocity.z }) }
    
    mutating func applyGravity() {
        self = self.map { moon -> Moon in
            var deltas = Vector.zero
            
            self.filter({ $0 != moon }).forEach { otherMoon in
                if moon.position.x < otherMoon.position.x { deltas.x += 1 }
                else if moon.position.x > otherMoon.position.x { deltas.x -= 1 }
    
                if moon.position.y < otherMoon.position.y { deltas.y += 1 }
                else if moon.position.y > otherMoon.position.y { deltas.y -= 1 }
    
                if moon.position.z < otherMoon.position.z { deltas.z += 1 }
                else if moon.position.z > otherMoon.position.z { deltas.z -= 1 }
            }
            
            var newMoon = moon
            newMoon.velocity.x += deltas.x
            newMoon.velocity.y += deltas.y
            newMoon.velocity.z += deltas.z
            return newMoon
        }
    }
    
    mutating func move() {
        indices.forEach { self[$0].move() }
    }
}

func lcm(_ m: Int, _ n: Int) -> Int? {
    func gcd(_ m: Int, _ n: Int) -> Int {
        var a: Int = 0
        var b: Int = max(m, n)
        var r: Int = min(m, n)

        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        
        return b
    }
    
    guard (m & n) != 0 else { return nil }
    return m / gcd(m, n) * n
}

let initialMoons = input
    .split(separator: "\n")
    .map { line -> Moon in
        let positionValues = line
            .split { "-0123456789".contains($0) == false }
            .map { Int($0)! }
        let position = Vector(x: positionValues[0], y: positionValues[1], z: positionValues[2])
        return Moon(position: position, velocity: .zero)
    }

func partOne() -> String {
    var moons = initialMoons
    
    for _ in 1...1000 {
        moons.applyGravity()
        moons.move()
    }

    return moons
        .map { $0.totalEnergy }
        .reduce(0, +)
        .description
}

func partTwo() -> String {
    let xValues = initialMoons.xValues
    let yValues = initialMoons.yValues
    let zValues = initialMoons.zValues
    
    var xRepeat: Int? = nil
    var yRepeat: Int? = nil
    var zRepeat: Int? = nil
    
    var moons = initialMoons
    
    for cycleCount in 1... {
        moons.applyGravity()
        moons.move()
        
        if xRepeat == nil && moons.xValues == xValues { xRepeat = cycleCount }
        if yRepeat == nil && moons.yValues == yValues { yRepeat = cycleCount }
        if zRepeat == nil && moons.zValues == zValues { zRepeat = cycleCount }
        
        if [xRepeat, yRepeat, zRepeat].allSatisfy({ $0 != nil }) { break }
    }
    
    return lcm(xRepeat!, lcm(yRepeat!, zRepeat!)!)!.description
}

print(partOne())
print(partTwo())

//: [Next](@next)
