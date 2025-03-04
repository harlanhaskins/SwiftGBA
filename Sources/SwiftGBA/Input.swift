import tonc

public enum Key: Sendable {
  case a
  case b
  case up
  case down
  case left
  case right
  case start
  case select
  case l
  case r

  public var rawValue: UInt32 {
    switch self {
    case .a: UInt32(KEY_A)
    case .b: UInt32(KEY_B)
    case .up: UInt32(KEY_UP)
    case .down: UInt32(KEY_DOWN)
    case .left: UInt32(KEY_LEFT)
    case .right: UInt32(KEY_RIGHT)
    case .start: UInt32(KEY_START)
    case .select: UInt32(KEY_SELECT)
    case .l: UInt32(KEY_L)
    case .r: UInt32(KEY_R)
    }
  }

  public static func poll() {
    key_poll()
  }

  public var isDown: Bool {
    key_is_down(rawValue) != 0
  }

  public var isUp: Bool {
    key_is_up(rawValue) != 0
  }

  public var isHit: Bool {
    key_hit(rawValue) != 0
  }
}