import Algorithms
import Collections
import Foundation
import RegexBuilder

final class Directory: NSObject {
	weak var parent: Directory? = nil
	
	var name: String
	var subdirectories: [Directory] = []
	var files: [String: Int] = [:]
	
	init(name: String, subdirectories: [Directory] = [], files: [String: Int] = [:]) {
		self.name = name
		self.subdirectories = subdirectories
		self.files = files
	}
	
	func size() -> Int {
		files.values.reduce(0, +)
			+ subdirectories.map { $0.size() }.reduce(0, +)
	}
	
	func sizes() -> [Int] {
		[size()] + subdirectories.flatMap { $0.sizes() }
	}
}

struct Day7: Day {
	var input: String
	
	init(input: String) {
		self.input = input
	}
	
	func partOne() -> String {
		fileTree()
			.sizes()
			.lazy
			.filter { $0 <= 100_000 }
			.count
			.description
	}
	
	func partTwo() -> String {
		let tree = fileTree()
		let totalSize = tree.size()
		let maxSize = 40_000_000
		let toDelete = totalSize - maxSize
		return tree
			.sizes()
			.filter { $0 >= toDelete }
			.min()!
			.description
	}
	
	func fileTree() -> Directory {
		let instructionsWithOutputs = input
			.split(separator: "\n")
			.chunked { current, next in next.starts(with: "$") == false }
		
		let root = Directory(name: "/")
		var current = root
		
		for instructionWithOutputs in instructionsWithOutputs {
			let instruction = instructionWithOutputs.first!
			let outputs = instructionWithOutputs.dropFirst()
			
			switch instruction.dropFirst(2).prefix(2) {
			case "cd":
				let newDirectoryName = String(instruction.dropFirst(5))
				
				switch newDirectoryName {
				case "/": break
				case "..": current = current.parent!
				default:
					if let existing = current.subdirectories.first(where: { $0.name == newDirectoryName }) {
						current = existing
					} else {
						let newDirectory = Directory(name: String(instruction.dropFirst(5)))
						current.subdirectories.append(newDirectory)
						newDirectory.parent = current
						current = newDirectory
					}
				}
				
			case "ls":
				for output in outputs {
					if output.starts(with: "dir") {
						let newDirectory = Directory(name: String(output.dropFirst(4)))
						current.subdirectories.append(newDirectory)
						newDirectory.parent = current
					} else {
						let size = Int(output.split(separator: " ").first!)!
						let name = String(output.split(separator: " ").last!)
						current.files[name] = size
					}
				}
				
			default: fatalError("unexpected input")
			}
		}
		
		return root
	}
}
