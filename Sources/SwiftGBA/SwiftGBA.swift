import Syscalls
import _Volatile

@main
struct Game {
  static func main() {
    sprite()
  }
  static func game() {
    irq_init(nil)
    irq_enable(II_VBLANK)
    
    // set background mode 3 (bitmap) and turn on background 2
    let backgroundPtr = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x4000000)
    backgroundPtr.store(0x403)

    let size = Size(width: 40, height: 30)
    var rect = Rect(
      center: Screen.frame.center,
      size: size)

    let maxX = Int32(Screen.width - rect.size.width)
    let maxY = Int32(Screen.height - rect.size.height)
    while true {
      m3_fill(UInt16(CLR_BLACK))
      m3_rect(Int32(rect.minX), Int32(rect.minY), Int32(rect.maxX), Int32(rect.maxY), Color(red: 222, green: 93, blue: 67).packed)

      Key.poll()
      var velocity = Vector(dx: 1, dy: 1)
      if Key.a.isDown {
        velocity.dx *= 2
        velocity.dy *= 2
      }
      var newX = Int32(rect.origin.x)
      var newY = Int32(rect.origin.y)
      if Key.right.isDown {
        newX += velocity.dx
      }
      if Key.left.isDown {
        newX -= velocity.dx
      }
      if Key.up.isDown {
        newY -= velocity.dy
      }
      if Key.down.isDown {
        newY += velocity.dy
      }

      newX = min(max(0, newX), maxX)
      newY = min(max(0, newY), maxY)
      rect.origin.x = UInt32(newX)
      rect.origin.y = UInt32(newY)

      wait_for_vblank()
    }
  }

  static func dvd() {
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

func obj_test(buffer: UnsafeMutableBufferPointer<OBJ_ATTR>) {
    var x: Int32 = 96
    var y: Int32 = 32
    var tid: UInt32 = 0
    var pb: UInt16 = 0      // (3) tile id, pal-bank
    let metr = buffer.baseAddress!

    obj_set_attr(metr, 
        0,              // Square, regular sprite
        0xC000,              // 64x64p, 
        (pb << 11) | UInt16(tid))   // palbank 0, tile 0

    // (4) position sprite (redundant here the _real_ position
    // is set further down
    obj_set_pos(metr, x, y)

    while true {
        vid_vsync()
        key_poll()

        // (5) Do various interesting things
        // move left/right
        x += 2*key_tri_horz()
        // move up/down
        y += 2*key_tri_vert()

        // increment/decrement starting tile with R/L
        if Key.r.isHit {
          tid += 1
        }
        if Key.l.isHit {
          tid -= 1
        }

        // flip
        if Key.a.isHit { // horizontally
            metr.pointee.attr1 ^= UInt16(ATTR1_HFLIP)
        }
        
        if Key.start.isHit { // vertically
            metr.pointee.attr1 ^= UInt16(ATTR1_VFLIP)
        }
        
        // make it glow (via palette swapping)
        pb = Key.select.isDown ? 1 : 0

        // toggle mapping mode
        // if Key.start.isHit {
        //     REG_DISPCNT ^= DCNT_OBJ_1D
        // }

        // Hey look, it's one of them build macros!
        metr.pointee.attr2 = UInt16(ATTR2_BUILD(id: tid, pbank: UInt32(pb), prio: 0))
        obj_set_pos(metr, x, y)

        oam_copy(Sprite.objectMemory, metr, 1)   // (6) Update OAM (only one now)
    }
}

func sprite()
{
    let obj_buffer = UnsafeMutableBufferPointer<OBJ_ATTR>.allocate(capacity: 128)
    // (1) Places the tiles of a 4bpp boxed metroid sprite 
    //   into LOW obj memory (cbb == 4)
    // memcpy(&Sprite.tileMemory[4].0, metr_boxTiles, metr_boxTilesLen)
    // memcpy(Sprite.paletteMemory, metrPal, metrPalLen)

    // (2) Initialize all sprites
    oam_init(obj_buffer.baseAddress, 128)
    Register.displayControl.store(UInt32(DCNT_OBJ) | UInt32(DCNT_OBJ_1D))

    obj_test(buffer: obj_buffer)
    obj_buffer.deallocate()
}