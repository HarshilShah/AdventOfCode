//
//  Day.swift
//  AdventOfCode
//
//  Created by Harshil Shah on 30/11/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

import Foundation

protocol Day {
    init(_ input: String)
    
    func partOne() -> String
    func partTwo() -> String
}
