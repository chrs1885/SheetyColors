// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SheetyColors",
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.40.11"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.34.0"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.4"),
        .package(url: "https://github.com/eneko/SourceDocs.git", from: "0.5.1"),
        .package(url: "https://github.com/chrs1885/Capable.git", from: "1.1.3"),
        .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.2")
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.5.0"),
    ],
    products: [
        .library(
            name: "SheetyColors",
            targets: ["SheetyColors"])
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
