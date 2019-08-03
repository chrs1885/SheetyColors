// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SheetyColors",
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.40.11"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.34.0"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.4"),
        .package(url: "https://github.com/eneko/SourceDocs.git", from: "0.5.1"),
    ],
    targets: [
        .target(name: "SheetyColors_Example", dependencies: [], path: "Example", sources: ["SheetyColors/SheetType.swift"]),
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
