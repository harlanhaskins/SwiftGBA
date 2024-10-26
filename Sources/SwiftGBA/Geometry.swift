struct Size {
  var width: UInt32
  var height: UInt32
  static var zero: Size {
    Size(width: 0, height: 0)
  }
}
struct Vector {
  var dx: Int32
  var dy: Int32
  static var zero: Vector {
    Vector(dx: 0, dy: 0)
  }
}
struct Point {
  var x: UInt32
  var y: UInt32
  static var zero: Point {
    Point(x: 0, y: 0)
  }
}
struct Rect {
  var origin: Point
  var size: Size
  static var zero: Rect {
    Rect(origin: .zero, size: .zero)
  }
  var center: Point {
    get { Point(x: midX, y: midY) }
    set {
      midX = newValue.x
      midY = newValue.y
    }
  }
  var minX: UInt32 {
    get { origin.x }
    set { origin.x = newValue }
  }
  var midX: UInt32 {
    get { origin.x + (size.width / 2) }
    set { origin.x = newValue - (size.width / 2) }
  }
  var maxX: UInt32 {
    get { origin.x + size.width }
    set { origin.x = newValue - size.width }
  }
  var minY: UInt32 {
    get { origin.y }
    set { origin.y = newValue }
  }
  var midY: UInt32 {
    get { origin.y + (size.height / 2) }
    set { origin.y = newValue - (size.height / 2) }
  }
  var maxY: UInt32 {
    get { origin.y + size.height }
    set { origin.y = newValue - size.height }
  }
}

extension Rect {
  init(x: UInt32, y: UInt32, width: UInt32, height: UInt32) {
    self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
  }
  init(center: Point, size: Size) {
    let origin = Point(x: center.x - size.width / 2, y: center.y - size.height / 2)
    self.init(origin: origin, size: size)
  }
}