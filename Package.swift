import PackageDescription

let package = Package(
    name: "Node",
    targets: [
        Target(
            name: "Node"
        ),
    ],
    dependencies: [
      .Package(url: "https://github.com/vapor/path-indexable.git", majorVersion: 1),
      .Package(url: "https://github.com/vapor/polymorphic.git",  Version(2, 0, 0, prereleaseIdentifiers: ["alpha.1"]))
    ]
)
