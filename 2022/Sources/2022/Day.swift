import Foundation

protocol Day {
	var input: String { get }
	
	init(input: String)
	
	func partOne() -> String
	func partTwo() -> String
}
