public struct Size: Sendable {
  public var width: UInt32
  public var height: UInt32

  public init(width: UInt32, height: UInt32) {
    self.width = width
    self.height = height
  }

  public static var zero: Size {
    Size(width: 0, height: 0)
  }
}

public struct Vector: Sendable {
  public var dx: Int32
  public var dy: Int32
  public init(dx: Int32, dy: Int32) {
    self.dx = dx
    self.dy = dy
  }
  public static var zero: Vector {
    Vector(dx: 0, dy: 0)
  }
}

public struct Point: Sendable {
  public var x: UInt32
  public var y: UInt32
  public init(x: UInt32, y: UInt32) {
    self.x = x
    self.y = y
  }
  public static var zero: Point {
    Point(x: 0, y: 0)
  }
}

public struct Rect: Sendable {
  public var origin: Point
  public var size: Size
  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  public static var zero: Rect {
    Rect(origin: .zero, size: .zero)
  }
  public var center: Point {
    get { Point(x: midX, y: midY) }
    set {
      midX = newValue.x
      midY = newValue.y
    }
  }
  public var minX: UInt32 {
    get { origin.x }
    set { origin.x = newValue }
  }
  public var midX: UInt32 {
    get { origin.x + (size.width / 2) }
    set { origin.x = newValue - (size.width / 2) }
  }
  public var maxX: UInt32 {
    get { origin.x + size.width }
    set { origin.x = newValue - size.width }
  }
  public var minY: UInt32 {
    get { origin.y }
    set { origin.y = newValue }
  }
  public var midY: UInt32 {
    get { origin.y + (size.height / 2) }
    set { origin.y = newValue - (size.height / 2) }
  }
  public var maxY: UInt32 {
    get { origin.y + size.height }
    set { origin.y = newValue - size.height }
  }
}

extension Rect {
  public init(x: UInt32, y: UInt32, width: UInt32, height: UInt32) {
    self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
  }

  public init(center: Point, size: Size) {
    let origin = Point(x: center.x - size.width / 2, y: center.y - size.height / 2)
    self.init(origin: origin, size: size)
  }
}