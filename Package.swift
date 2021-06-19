// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SheetyColors",
    platforms: [
        .iOS(.v11), .macOS(.v10_12),
    ],
    products: [
        .library(
            name: "SheetyColors",
            targets: ["SheetyColors"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/chrs1885/Capable.git", from: "2.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.7.2"),
        .package(url: "https://github.com/Quick/Quick.git", from: "2.2.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.7"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.44.6"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.39.1"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.4"),
        .package(url: "https://github.com/eneko/SourceDocs.git", from: "0.6.1"),
    ],
    targets: [
        .target(name: "SheetyColors_Example", dependencies: [], path: "Example", sources: ["SheetyColors/SheetType.swift"]),
        .target(name: "SheetyColors", dependencies: ["Capable"], path: "SheetyColors"),
        .testTarget(name: "SheetyColors_Tests", dependencies: ["SheetyColors", "Quick", "Nimble", "SnapshotTesting"], path: "Example/Tests"),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfig([
        "komondor": [
            "pre-commit": [
                "swift run swiftformat .",
                "swift run swiftlint autocorrect --path SheetyColors/",
                "swift run sourcedocs generate -- -workspace Example/SheetyColors.xcworkspace -scheme SheetyColors",
                "git add .",
            ],
        ],
    ])
#endif
