public protocol NodeBacked: NodeConvertible, PathIndexable, Polymorphic {
    var node: Node { get set }
    init(_ node: Node)
}

// Convertible
extension NodeBacked {
    public init(node: Node, in context: Context) throws {
        self.init(node)
    }

    public func makeNode() -> Node {
        return node
    }
}

// Polymorphic
extension NodeBacked {
    public var isNull: Bool { return node.isNull }
    public var bool: Bool? { return node.bool }
    public var double: Double? { return node.double }
    public var int: Int? { return node.int }
    public var string: String? { return node.string }
    public var array: [Polymorphic]? { return node.array }
    public var object: [String: Polymorphic]? { return node.object }
}

// PathIndexable
extension NodeBacked {

    /**
     If self is an array representation, return array
     */
    public var pathIndexableArray: [Self]? {
        return node.pathIndexableArray?.map { Self($0) }
    }

    /**
     If self is an object representation, return object
     */
    public var pathIndexableObject: [String: Self]? {
        guard case let .object(o) = node else { return nil }
        var object: [String: Self] = [:]
        for (key, val) in o {
            object[key] = Self(val)
        }
        return object
    }

    /**
     Initialize json w/ array
     */
    public init(_ array: [Self]) {
        let array = array.map { $0.node }
        let node = Node.array(array)
        self.init(node)
    }

    /**
     Initialize json w/ object
     */
    public init(_ o: [String: Self]) {
        var object: [String: Node] = [:]
        for (key, val) in o {
            object[key] = val.node
        }
        let node = Node.object(object)
        self.init(node)
    }
}