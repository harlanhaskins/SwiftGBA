import _Volatile

public enum DMA {
    /* pointer to the DMA source location */
    public static let source = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000D4)

    /* pointer to the DMA destination location */
    public static let destination = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000D8)

    /* pointer to the DMA count/control */
    public static let count = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000DC)

    /* flags for the sizes to transfer, 16 or 32 bits */
    public static let sixteenBit = UInt32(0x00000000)
    public static let thirtyTwoBit = UInt32(0x04000000)
    public static let enable = UInt32(0x80000000)

    public static func copy(
        from source: UnsafeBufferPointer<UInt16>,
        to destination: UnsafeBufferPointer<UInt16>
    ) {
        self.source.store(UInt32(UInt(bitPattern: source.baseAddress!)))
        self.destination.store(UInt32(UInt(bitPattern: destination.baseAddress!)))
        self.count.store(UInt32(source.count) | sixteenBit | enable)
    }

    public static func copy(
        from source: UnsafeBufferPointer<UInt32>,
        to destination: UnsafeBufferPointer<UInt32>
    ) {
        self.source.store(UInt32(UInt(bitPattern: source.baseAddress!)))
        self.destination.store(UInt32(UInt(bitPattern: destination.baseAddress!)))
        self.count.store(UInt32(source.count) | thirtyTwoBit | enable)
    }
}