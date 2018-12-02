//
//  Day01.swift
//  AdventOfCode
//
//  Created by Harshil Shah on 02/12/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

import Foundation

struct Day01: Day {
    
    private let input: String
    
    init(_ input: String) {
        self.input = input
    }
    
    func partOne() -> String {
        let numbers = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { Int($0)! }
        
        let total = numbers.reduce(0, { $0 + $1 })
        
        return "\(total)"
    }
    
    func partTwo() -> String {
        let numbers = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { Int($0)! }
        
        var visited: Set<Int> = [0]
        var output = 0
        
        repeat {
            for number in numbers {
                output += number
                
                if visited.contains(output) {
                    return "\(output)"
                } else {
                    visited.insert(output)
                }
            }
        } while true
    }
    
}
