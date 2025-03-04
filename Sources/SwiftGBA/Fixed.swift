public struct Fixed: Sendable {
    fileprivate static let shift: Int32 = 8
    fileprivate static let scale: Int32 = 1 << shift
    fileprivate static let mask: Int32 = scale - 1

    public var rawValue: Int32

    public static var one: Fixed {
        Fixed(rawValue: Fixed.scale)
    }

    public var fractionalPart: UInt32 {
        UInt32(rawValue & Self.mask)
    }
}

extension Fixed {
    public init(_ integer: Int32) {
        rawValue = integer << Self.shift
    }
}

extension Fixed: ExpressibleByFloatLiteral {
    public init(floatLiteral: Float) {
        rawValue = Int32(floatLiteral * Float(Fixed.scale))
    }
}

extension Fixed: ExpressibleByIntegerLiteral {
    public init(integerLiteral: Int32) {
        self.init(integerLiteral)
    }
}

extension Float {
    public init(_ fixed: Fixed) {
        self = Float(fixed.rawValue) / Float(Fixed.scale)
    }
}

extension Fixed {
    public static func +(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: lhs.rawValue + rhs.rawValue)
    }
    public static func -(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: lhs.rawValue - rhs.rawValue)
    }
    public static func *(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: (lhs.rawValue * rhs.rawValue) >> shift)
    }
    public static func /(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: (lhs.rawValue * scale) / rhs.rawValue)
    }
}

extension UInt32 {
    public init(_ fixed: Fixed) {
        self = UInt32(fixed.rawValue >> Fixed.shift)
    }
}

extension Int32 {
    public init(_ fixed: Fixed) {
        self = fixed.rawValue / Fixed.scale
    }
}