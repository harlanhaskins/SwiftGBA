import SwiftGBA
import tonc
import _Volatile

@main
struct DVD {
  static func main() {
    irq_init(nil)
    irq_enable(II_VBLANK)
    Log.enable()

    // set background mode 3 (bitmap) and turn on background 2
    let backgroundPtr = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x4000000)
    backgroundPtr.store(0x403)

    let size = Size(width: 40, height: 30)
    var rect = Rect(
      center: Screen.frame.center,
      size: size)

    var velocity = Vector(dx: 1, dy: 1)
    while true {
      m3_fill(UInt16(CLR_BLACK))
      m3_rect(
        Int32(rect.minX),
        Int32(rect.minY),
        Int32(rect.maxX),
        Int32(rect.maxY),
        Color(red: 222, green: 93, blue: 67).packed)

      if velocity.dx > 0 {
        rect.origin.x += UInt32(velocity.dx)
      } else {
        rect.origin.x -= UInt32(-velocity.dx)
      }

      if velocity.dy > 0 {
        rect.origin.y += UInt32(velocity.dy)
      } else {
        rect.origin.y -= UInt32(-velocity.dy)
      }

      if rect.maxX >= Screen.width || rect.minX == 0 {
        velocity.dx = -velocity.dx
      }
      if rect.maxY >= Screen.height || rect.minY == 0 {
        velocity.dy = -velocity.dy
      }

      wait_for_vblank()
    }
  }
}