//
//  Day02.swift
//  AdventOfCode
//
//  Created by Harshil Shah on 02/12/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

import Foundation

struct Day02: Day {
    
    private let input: String
    
    init(_ input: String) {
        self.input = input
    }
    
    func partOne() -> String {
        let text = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        
        var twoRepeats = 0
        var threeRepeats = 0
        
        text.forEach { line in
            var counts = [Character: Int]()
            line.forEach { counts[$0, default: 0] += 1 }
            
            if counts.contains(where: { $0.value == 2 }) {
                twoRepeats += 1
            }
            
            if counts.contains(where: { $0.value == 3 }) {
                threeRepeats += 1
            }
        }
        
        return "\(twoRepeats * threeRepeats)"
    }
    
    func partTwo() -> String {
        let text = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        
        for (indexOne, valueOne) in text.enumerated() {
            for (_, valueTwo) in Array(text.dropFirst(indexOne + 1)).enumerated() {
                var diff = 0
                
                for (c1, c2) in zip(valueOne, valueTwo) {
                    if c1 != c2 {
                        diff += 1
                    }
                    
                    if diff > 1 {
                        break
                    }
                }
                
                if diff == 1 {
                    return String(zip(valueOne, valueTwo).compactMap { return ($0 == $1) ? $0 : nil })
                }
            }
        }
        
        return "This didn't work"
    }
    
}
