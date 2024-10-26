import _Volatile

struct Color {
  var packed: UInt16
  init(red: UInt8, green: UInt8, blue: UInt8) {
    packed = RGB8(red, green, blue)
  }
  init(_ packed: UInt16) {
    self.packed = packed
  }
}

enum Screen {
  static var start: UnsafeMutablePointer<UInt16> {
    .init(bitPattern: 0x6000000)!
  }
  static func draw(_ pixel: Color, at point: Point) {
    start[Int(point.x) + (Int(point.y) * 240)] = pixel.packed
  }
  static let width: UInt32 = 240
  static let height: UInt32 = 160
  static let frame = Rect(origin: .zero, size: Size(width: width, height: height))
}

enum Drawing {
  static let backgroundPalette = VolatileMappedRegister<UInt16>(unsafeBitPattern: 0x5000000)
  static let spritePalette = VolatileMappedRegister<UInt16>(unsafeBitPattern: 0x5000200)
  static let spriteMemory = UnsafeMutablePointer<UInt16>(bitPattern: 0x6010000)!
}