//: [Previous](@previous)
import Foundation

let input = """
Immune System:
2086 units each with 11953 hit points with an attack that does 46 cold damage at initiative 13
329 units each with 3402 hit points (weak to bludgeoning) with an attack that does 90 slashing damage at initiative 1
414 units each with 7103 hit points (weak to bludgeoning; immune to radiation) with an attack that does 170 radiation damage at initiative 4
2205 units each with 7118 hit points (immune to cold; weak to fire) with an attack that does 26 radiation damage at initiative 18
234 units each with 9284 hit points (weak to slashing; immune to cold, fire) with an attack that does 287 radiation damage at initiative 12
6460 units each with 10804 hit points (weak to fire) with an attack that does 15 slashing damage at initiative 11
79 units each with 1935 hit points with an attack that does 244 radiation damage at initiative 8
919 units each with 2403 hit points (weak to fire) with an attack that does 22 slashing damage at initiative 2
172 units each with 1439 hit points (weak to slashing; immune to cold, fire) with an attack that does 69 slashing damage at initiative 3
1721 units each with 2792 hit points (weak to radiation, fire) with an attack that does 13 cold damage at initiative 16

Infection:
1721 units each with 29925 hit points (weak to cold, radiation; immune to slashing) with an attack that does 34 radiation damage at initiative 5
6351 units each with 21460 hit points (weak to cold) with an attack that does 6 slashing damage at initiative 15
958 units each with 48155 hit points (weak to bludgeoning) with an attack that does 93 radiation damage at initiative 7
288 units each with 41029 hit points (immune to bludgeoning; weak to radiation) with an attack that does 279 cold damage at initiative 20
3310 units each with 38913 hit points with an attack that does 21 radiation damage at initiative 19
3886 units each with 16567 hit points (immune to bludgeoning, cold) with an attack that does 7 cold damage at initiative 9
39 units each with 7078 hit points with an attack that does 300 bludgeoning damage at initiative 14
241 units each with 40635 hit points (weak to cold) with an attack that does 304 fire damage at initiative 6
7990 units each with 7747 hit points (immune to fire) with an attack that does 1 radiation damage at initiative 10
80 units each with 30196 hit points (weak to fire) with an attack that does 702 bludgeoning damage at initiative 17
"""

struct Identifier: Equatable, Hashable {
    let value: Int
}

struct Group {
    enum Kind {
        case immuneSystem, infection
    }
    
    let kind: Kind
    let id: Identifier
    var numberOfUnits: Int
    let hitPoints: Int
    var attackDamage: Int
    let attackType: String
    let initiative: Int
    let immunities: [String]?
    let weaknesses: [String]?
    
    var effectivePower: Int { return numberOfUnits * attackDamage }
    
    static func parse(fromLine line: String, kind: Kind, index: Int) -> Group {
        let components = line.components(separatedBy: .whitespaces)
        let numberOfUnits = Int(components[0])!
        let hitPoints = Int(components[4])!
        
        let immunities: [String]? = {
            guard var immuneIndex = components.firstIndex(where: { $0.hasSuffix("immune") }) else {
                return nil
            }
            
            var immunities: [String] = []
            immuneIndex += 1
            
            while true {
                immuneIndex += 1
                let immunity = components[immuneIndex]
                immunities.append(String(immunity.dropLast()))
                
                if immunity.last == ";" || immunity.last == ")" {
                    break
                }
            }
            
            return immunities
        }()
        
        let weaknesses: [String]? = {
            guard var weaknessIndex = components.firstIndex(where: { $0.hasSuffix("weak") }) else {
                return nil
            }
            
            var weaknesses: [String] = []
            weaknessIndex += 1
            
            while true {
                weaknessIndex += 1
                let weakness = components[weaknessIndex]
                weaknesses.append(String(weakness.dropLast()))
                
                if weakness.last == ";" || weakness.last == ")" {
                    break
                }
            }
            
            return weaknesses
        }()
        
        let doesIndex = components.firstIndex(of: "does")!
        let attackDamage = Int(components[doesIndex + 1])!
        let attackType = components[doesIndex + 2]
        let initiative = Int(components.last!)!
        
        return Group(kind: kind, id: Identifier(value: index), numberOfUnits: numberOfUnits, hitPoints: hitPoints, attackDamage: attackDamage, attackType: attackType, initiative: initiative, immunities: immunities, weaknesses: weaknesses)
    }
    
    func isInSelectionOrder(_ other: Group) -> Bool {
        if effectivePower > other.effectivePower { return true }
        if effectivePower < other.effectivePower { return false }
        return initiative > other.initiative
    }
    
    func isInAttackingOrder(_ other: Group) -> Bool {
        return initiative > other.initiative
    }
    
    func applyingBoost(_ boost: Int) -> Group {
        var copy = self
        copy.attackDamage += boost
        return copy
    }
    
    func damage(from other: Group) -> Int {
        if immunities?.contains(other.attackType) ?? false {
            return 0
        }
        
        if weaknesses?.contains(other.attackType) ?? false {
            return other.effectivePower * 2
        }
        
        return other.effectivePower
    }
}

enum BattleOutcome {
    case winner(kind: Group.Kind, numberOfUnits: Int)
    case stasis
}

let initialGroups: [Group] = {
    var groups: [Group] = []
    var kind = Group.Kind.immuneSystem
    var index = 0
    
    for line in input.components(separatedBy: .newlines) {
        if line == "Immune System:" || line.isEmpty {
            continue
        }
        
        if line == "Infection:" {
            kind = .infection
            continue
        }
        
        let group = Group.parse(fromLine: line, kind: kind, index: index)
        groups.append(group)
        index += 1
    }
    
    return groups
}()

func battle(withInitialGroups initialGroups: [Group]) -> BattleOutcome {
    var groups = initialGroups
    var didKillSomeone = false
    
    while true {
        didKillSomeone = false
        var targets: [Identifier: Identifier] = [:]
        
        for group in groups.sorted(by: { $0.isInSelectionOrder($1) }) {
            let potentialTargets = groups.filter {
                $0.kind != group.kind &&
                targets.values.contains($0.id) == false &&
                $0.damage(from: group) > 0
            }
            
            if potentialTargets.isEmpty {
                continue
            }
            
            let target = potentialTargets
                .map { (group: $0, damage: $0.damage(from: group)) }
                .max {
                    if $0.damage < $1.damage { return true }
                    if $0.damage > $1.damage { return false }
                    
                    if $0.group.effectivePower < $1.group.effectivePower { return true }
                    if $0.group.effectivePower > $1.group.effectivePower { return false }
                    
                    return $0.group.initiative < $1.group.initiative
                }!.group
            
            targets[group.id] = target.id
        }
        
        for group in groups.sorted(by: { $0.isInAttackingOrder($1) }) {
            guard
                let enemyIdentifier = targets[group.id],
                let actualGroup = groups.first(where: { $0.id == group.id }),
                actualGroup.numberOfUnits > 0
            else {
                continue
            }
            
            let actualEnemyIndex = groups.firstIndex(where: { $0.id == enemyIdentifier })!
            let enemy = groups[actualEnemyIndex]
            let damage = enemy.damage(from: actualGroup)
            let unitsKilled = damage / enemy.hitPoints
            
            groups[actualEnemyIndex].numberOfUnits -= unitsKilled
            
            if unitsKilled > 1 { didKillSomeone = true }
        }
        
        guard didKillSomeone else {
            return .stasis
        }
        
        groups.removeAll { $0.numberOfUnits <= 0 }
        
        let containsInfection = groups.contains { $0.kind == .infection }
        let containsImmuneSystems = groups.contains { $0.kind == .immuneSystem }
        
        guard containsInfection && containsImmuneSystems else {
            let winner: Group.Kind = containsInfection ? .infection : .immuneSystem
            let numberOfRemainingUnits = groups.reduce(0, { $0 + $1.numberOfUnits })
            return .winner(kind: winner, numberOfUnits: numberOfRemainingUnits)
        }
    }
}

func partOne() -> String {
    guard case let .winner(_, score) = battle(withInitialGroups: initialGroups) else {
        fatalError("There has to be a winner")
    }
    
    return "\(score)"
}

func partTwo() -> String {
    var boost = 0
    
    while true {
        let groups = initialGroups.map { $0.kind == .immuneSystem ? $0.applyingBoost(boost) : $0 }
        
        guard
            case let .winner(kind, score) = battle(withInitialGroups: groups),
            kind == .immuneSystem
        else {
            boost += 1
            continue
        }
        
        return "\(score)"
    }
}

print(partOne())
print(partTwo())
//: [Next](@next)
