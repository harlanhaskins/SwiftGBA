import _Volatile

struct Sprite {
    nonisolated static var tileMemory: UnsafeMutablePointer<CHARBLOCK> {
        .init(bitPattern: 0x6000000)!
    }
    nonisolated static var paletteMemory: UnsafeMutableRawPointer {
        .init(bitPattern: 0x5000000)!
    }
    nonisolated static var paletteObjectMemory: UnsafeMutableRawPointer {
        paletteMemory + 0x00200
    }
    nonisolated static var objectMemory: UnsafeMutablePointer<OBJ_ATTR> {
        .init(bitPattern: 0x07000000)!
    }
    enum Size {
        /* the different sizes of sprites which are possible */
        case _8x8
        case _16x16
        case _32x32
        case _64x64
        case _16x8
        case _32x8
        case _32x16
        case _64x32
        case _8x16
        case _8x32
        case _16x32
        case _32x64

        var bits: (shape: UInt8, size: UInt8) {
            switch self {
            case ._8x8:   (0,0)
            case ._16x16: (1,0)
            case ._32x32: (2,0)
            case ._64x64: (3,0)
            case ._16x8:  (0,1)
            case ._32x8:  (1,1)
            case ._32x16: (2,1)
            case ._64x32: (3,1)
            case ._8x16:  (0,2)
            case ._8x32:  (1,2)
            case ._16x32: (2,2)
            case ._32x64: (3,2)
            }
        }
    }
    private var attributes: (UInt16, UInt16, UInt16, UInt16)

}

// Attribute 0
func ATTR0_BUILD(y: UInt32, shape: UInt32, bpp: UInt32, mode: UInt32, mos: UInt32, bld: UInt32, win: UInt32) -> UInt32 {
    ((y)&255) | (((mode)&3)<<8) | (((bld)&1)<<10) | (((win)&1)<<11)
        | (((mos)&1)<<12) | (((bpp)&8)<<10) | (((shape)&3)<<14)
}

// Attribute 1, regular sprites
func ATTR1_BUILD_R(x: UInt32, size: UInt32, hflip: UInt32, vflip: UInt32) -> UInt32 {
    ((x)&511) | (((hflip)&1)<<12) | (((vflip)&1)<<13) | (((size)&3)<<14)
}

// Attribute 1, affine sprites
func ATTR1_BUILD_A(x: UInt32, size: UInt32, aff_id: UInt32) -> UInt32
{
    ((x)&511) | (((aff_id)&31)<<9) | (((size)&3)<<14)
}

// Attribute 2
func ATTR2_BUILD(id: UInt32, pbank: UInt32, prio: UInt32) -> UInt32
{
    ((id)&0x3FF) | (((pbank)&15)<<12) | (((prio)&3)<<10)
}