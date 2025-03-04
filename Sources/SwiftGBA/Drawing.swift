import tonc
import _Volatile

public struct Color: Sendable {
  public var packed: UInt16
  public init(red: UInt8, green: UInt8, blue: UInt8) {
    packed = RGB8(red, green, blue)
  }
  public init(_ packed: UInt16) {
    self.packed = packed
  }
}

public enum Screen: Sendable {
  public static var start: UnsafeMutablePointer<UInt16> {
    .init(bitPattern: 0x6000000)!
  }
  public static func draw(_ pixel: Color, at point: Point) {
    start[Int(point.x) + (Int(point.y) * 240)] = pixel.packed
  }
  public static let width: UInt32 = 240
  public static let height: UInt32 = 160
  public static let frame = Rect(origin: .zero, size: Size(width: width, height: height))
}

public enum Drawing {
  public static var backgroundPalette: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: 0x5000000) }
  public static var spritePalette: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: 0x5000200) }
  public static var spriteMemory: UnsafeMutablePointer<UInt16> {  .init(bitPattern: 0x6010000)! }
}