// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "2022",
    products: [
		.executable(name: "2022", targets: ["2022"]),
    ],
    dependencies: [
		.package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
		.package(url: "https://github.com/apple/swift-collections", from: "1.0.3"),
    ],
    targets: [
        .executableTarget(
            name: "2022",
            dependencies: [
				.product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "Collections", package: "swift-collections")
			],
			swiftSettings: [.unsafeFlags(["-O"])]
		)
    ]
)
