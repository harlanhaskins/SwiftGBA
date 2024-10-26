import _Volatile

enum DMA {
    /* pointer to the DMA source location */
    static let source = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000D4)

    /* pointer to the DMA destination location */
    static let destination = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000D8)

    /* pointer to the DMA count/control */
    static let count = VolatileMappedRegister<UInt32>(unsafeBitPattern: 0x40000DC)

    /* flags for the sizes to transfer, 16 or 32 bits */
    static let sixteenBit = UInt32(0x00000000)
    static let thirtyTwoBit = UInt32(0x04000000)
    static let enable = UInt32(0x80000000)

    static func copy(
        from source: UnsafeBufferPointer<UInt16>,
        to destination: UnsafeBufferPointer<UInt16>
    ) {
        self.source.store(UInt32(UInt(bitPattern: source.baseAddress!)))
        self.destination.store(UInt32(UInt(bitPattern: destination.baseAddress!)))
        self.count.store(UInt32(source.count) | sixteenBit | enable)
    }

    static func copy(
        from source: UnsafeBufferPointer<UInt32>,
        to destination: UnsafeBufferPointer<UInt32>
    ) {
        self.source.store(UInt32(UInt(bitPattern: source.baseAddress!)))
        self.destination.store(UInt32(UInt(bitPattern: destination.baseAddress!)))
        self.count.store(UInt32(source.count) | thirtyTwoBit | enable)
    }
}