struct Fixed {
    fileprivate static let shift: Int32 = 8
    fileprivate static let scale: Int32 = 1 << shift
    fileprivate static let mask: Int32 = scale - 1

    var rawValue: Int32

    static var one: Fixed {
        Fixed(rawValue: Fixed.scale)
    }

    var fractionalPart: UInt32 {
        UInt32(rawValue & Self.mask)
    }
}

extension Fixed {
    init(_ integer: Int32) {
        rawValue = integer << Self.shift
    }
}

extension Fixed: ExpressibleByFloatLiteral {
    init(floatLiteral: Float) {
        rawValue = Int32(floatLiteral * Float(Fixed.scale))
    }
}

extension Fixed: ExpressibleByIntegerLiteral {
    init(integerLiteral: Int32) {
        self.init(integerLiteral)
    }
}

extension Float {
    init(_ fixed: Fixed) {
        self = Float(fixed.rawValue) / Float(Fixed.scale)
    }
}

extension Fixed {
    static func +(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: lhs.rawValue + rhs.rawValue)
    }
    static func -(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: lhs.rawValue - rhs.rawValue)
    }
    static func *(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: (lhs.rawValue * rhs.rawValue) >> shift)
    }
    static func /(lhs: Fixed, rhs: Fixed) -> Fixed {
        Fixed(rawValue: (lhs.rawValue * scale) / rhs.rawValue)
    }
}

extension UInt32 {
    init(_ fixed: Fixed) {
        self = UInt32(fixed.rawValue >> Fixed.shift)
    }
}

extension Int32 {
    init(_ fixed: Fixed) {
        self = fixed.rawValue / Fixed.scale
    }
}