struct Sprite {
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