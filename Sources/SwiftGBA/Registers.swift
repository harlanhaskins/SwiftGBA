import _Volatile
    
enum Register {
    private static let baseAddress: UInt = 0x04000000
    
    /// Mirrored at 03ff:fff[y], which is why this works out (0300:7ff[y])
    
    static var interruptFunctionBIOS: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress - 0x0008) 
    }
    
    /// Memory address that the system will jump to after a soft reset
    static var softResetDestination: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress - 0x0006) 
    }
    
    // MARK: - Display Registers
    
    /// LCD Control register - Controls all aspects of the display system
    static var displayControl: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0000) 
    }
    
    /// LCD Status register - Indicates LCD's current status and controls LCD interrupts
    static var displayStatus: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0004) 
    }
    
    /// Vertical Counter register - Indicates the current scanline being processed
    static var verticalScanlineCount: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0006) 
    }
    
    // MARK: - Background Control Registers
    
    /// Array of background control registers
    static var backgroundControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0006) 
    }
    
    /// Background 0 Control register - Controls various properties of background 0
    static var background0Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0008) 
    }
    
    /// Background 1 Control register - Controls various properties of background 1
    static var background1Control: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x000A) 
    }
    
    /// Background 2 Control register - Controls various properties of background 2
    static var background2Control: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x000C) 
    }
    
    /// Background 3 Control register - Controls various properties of background 3
    static var background3Control: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x000E) 
    }
    
    // MARK: - Background Scroll Registers (Write Only)
    
    /// Background 0 Horizontal Offset register - Controls horizontal scrolling of background 0
    static var background0HorizontalOffset: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0010) 
    }
    
    /// Background 0 Vertical Offset register - Controls vertical scrolling of background 0
    static var background0VerticalOffset: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0012) 
    }
    
    /// Background 1 Horizontal Offset register - Controls horizontal scrolling of background 1
    static var background1HorizontalOffset: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0014) 
    }
    
    /// Background 1 Vertical Offset register - Controls vertical scrolling of background 1
    static var background1VerticalOffset: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0016) 
    }
    
    /// Background 2 Horizontal Offset register - Controls horizontal scrolling of background 2
    static var background2HorizontalOffset: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0018) 
    }
    
    /// Background 2 Vertical Offset register - Controls vertical scrolling of background 2
    static var background2VerticalOffset: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x001A) 
    }
    
    /// Background 3 Horizontal Offset register - Controls horizontal scrolling of background 3
    static var background3HorizontalOffset: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x001C) 
    }
    
    /// Background 3 Vertical Offset register - Controls vertical scrolling of background 3
    static var background3VerticalOffset: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x001E) 
    }
    
    // MARK: - Affine Background Parameters (Write Only)
    
    /// Background 2 Affine Transformation Matrix Parameter A (dx)
    static var background2AffineParameterA: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0020) 
    }
    
    /// Background 2 Affine Transformation Matrix Parameter B (dmx)
    static var background2AffineParameterB: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0022) 
    }
    
    /// Background 2 Affine Transformation Matrix Parameter C (dy)
    static var background2AffineParameterC: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0024) 
    }
    
    /// Background 2 Affine Transformation Matrix Parameter D (dmy)
    static var background2AffineParameterD: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0026) 
    }
    
    /// Background 2 Reference Point X-Coordinate
    static var background2ReferencePointX: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x0028) 
    }
    
    /// Background 2 Reference Point Y-Coordinate
    static var background2ReferencePointY: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x002C) 
    }
    
    /// Background 3 Affine Transformation Matrix Parameter A (dx)
    static var background3AffineParameterA: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0030) 
    }
    
    /// Background 3 Affine Transformation Matrix Parameter B (dmx)
    static var background3AffineParameterB: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0032) 
    }
    
    /// Background 3 Affine Transformation Matrix Parameter C (dy)
    static var background3AffineParameterC: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0034) 
    }
    
    /// Background 3 Affine Transformation Matrix Parameter D (dmy)
    static var background3AffineParameterD: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x0036) 
    }
    
    /// Background 3 Reference Point X-Coordinate
    static var background3ReferencePointX: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x0038) 
    }
    
    /// Background 3 Reference Point Y-Coordinate
    static var background3ReferencePointY: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x003C) 
    }
    
    // MARK: - Window Registers
    
    /// Window 0 Horizontal Dimensions - Right and Left coordinates packed as 0xLLRR
    static var window0Horizontal: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0040) 
    }
    
    /// Window 1 Horizontal Dimensions - Right and Left coordinates packed as 0xLLRR
    static var window1Horizontal: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0042) 
    }
    
    /// Window 0 Vertical Dimensions - Top and Bottom coordinates packed as 0xTTBB
    static var window0Vertical: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0044) 
    }
    
    /// Window 1 Vertical Dimensions - Top and Bottom coordinates packed as 0xTTBB
    static var window1Vertical: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0046) 
    }
    
    /// Inside Windows Control - Controls layers visible inside Windows 0 and 1
    static var windowInsideControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0048) 
    }
    
    /// Outside Windows Control - Controls layers visible outside windows and in object window
    static var windowOutsideControl: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x004A) 
    }
    
    // MARK: - Individual Window Coordinates
    
    /// Window 0 Right Coordinate
    static var window0Right: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0040) 
    }
    
    /// Window 0 Left Coordinate
    static var window0Left: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0041) 
    }
    
    /// Window 1 Right Coordinate
    static var window1Right: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0042) 
    }
    
    /// Window 1 Left Coordinate
    static var window1Left: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0043) 
    }
    
    /// Window 0 Bottom Coordinate
    static var window0Bottom: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0044) 
    }
    
    /// Window 0 Top Coordinate
    static var window0Top: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0045) 
    }
    
    /// Window 1 Bottom Coordinate
    static var window1Bottom: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0046) 
    }
    
    /// Window 1 Top Coordinate
    static var window1Top: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0047) 
    }
    
    /// Window 0 Layer Control
    static var window0Control: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0048) 
    }
    
    /// Window 1 Layer Control
    static var window1Control: VolatileMappedRegister<UInt8> { 
        .init(unsafeBitPattern: baseAddress + 0x0049) 
    }
    
    /// Outside Window Layer Control
    static var windowOutsideLayerControl: VolatileMappedRegister<Int8> { 
        .init(unsafeBitPattern: baseAddress + 0x004A) 
    }
    
    /// Object Window Layer Control
    static var windowObjectControl: VolatileMappedRegister<Int8> { 
        .init(unsafeBitPattern: baseAddress + 0x004B) 
    }
    
    // MARK: - Special Effects Registers
    
    /// Mosaic Effect Control - Controls sprite and background mosaic effects
    static var mosaicControl: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x004C) 
    }
    
    /// Blend Control - Controls alpha blending effects between layers
    static var blendControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0050) 
    }
    
    /// Alpha Blend Values - Controls transparency levels for alpha blending
    static var blendAlpha: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0052) 
    }
    
    /// Brightness Control - Controls brightness for fade effects
    static var blendBrightness: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0054) 
    }
    
    // MARK: - Sound Channel 1 Registers (Square Wave with Sweep)
    
    /// Channel 1 Sweep Control - Controls frequency sweep
    static var sound1Sweep: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0060) 
    }
    
    /// Channel 1 Control - Controls duty cycle, length, and envelope
    static var sound1Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0062) 
    }
    
    /// Channel 1 Frequency - Controls sound frequency and reset
    static var sound1Frequency: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0064) 
    }
    
    // MARK: - Sound Channel 2 Registers (Simple Square Wave)
    
    /// Channel 2 Control - Controls duty cycle, length, and envelope
    static var sound2Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0068) 
    }
    
    /// Channel 2 Frequency - Controls sound frequency and reset
    static var sound2Frequency: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x006C) 
    }
    
    // MARK: - Sound Channel 3 Registers (Wave Player)
    
    /// Channel 3 Wave Select - Controls wave bank and playback
    static var sound3WaveSelect: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0070) 
    }
    
    /// Channel 3 Control - Controls volume and playback length
    static var sound3Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0072) 
    }
    
    /// Channel 3 Frequency - Controls sound frequency and reset
    static var sound3Frequency: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0074) 
    }
    
    // MARK: - Sound Channel 4 Registers (Noise Generator)
    
    /// Channel 4 Control - Controls length, envelope, and noise parameters
    static var sound4Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0078) 
    }
    
    /// Channel 4 Frequency - Controls noise parameters and reset
    static var sound4Frequency: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x007C) 
    }
    
    // MARK: - Sound Control Registers
    
    /// Main Sound Control - Master control for all sound channels
    static var soundControl: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0080) 
    }
    
    /// DMG Sound Control - Controls legacy Game Boy sound channels
    static var soundDMGControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0080) 
    }
    
    /// Direct Sound Control - Controls direct sound channels A and B
    static var soundDirectControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0082) 
    }
    
    /// Sound Status - Sound channel status flags
    static var soundStatus: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0084) 
    }
    
    /// Sound Bias - Controls master volume and bias level
    static var soundBias: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0088) 
    }
    
    // MARK: - Sound Wave RAM
    
    /// Channel 3 Wave Pattern RAM - Complete wave buffer
    static var wavePatternRAM: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0090) 
    }
    
    /// Wave Pattern RAM Bank 0
    static var wavePatternRAM0: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0090) 
    }
    
    /// Wave Pattern RAM Bank 1
    static var wavePatternRAM1: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0094) 
    }
    
    /// Wave Pattern RAM Bank 2
    static var wavePatternRAM2: VolatileMappedRegister<UInt32> { 
        .init(unsafeBitPattern: baseAddress + 0x0098) 
    }
    
    /// Wave Pattern RAM Bank 3
    static var wavePatternRAM3: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x009C) 
    }
    
    /// Direct Sound Channel A FIFO Buffer
    static var directSoundFIFOA: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00A0) 
    }
    
    /// Direct Sound Channel B FIFO Buffer
    static var directSoundFIFOB: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00A4) 
    }
    
    // MARK: - DMA Registers
    
    /// DMA 0 Source Address Register
    static var dma0SourceAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00B0) 
    }
    
    /// DMA 0 Destination Address Register
    static var dma0DestinationAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00B4) 
    }
    
    /// DMA 0 Control Register
    static var dma0Control: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00B8) 
    }
    
    /// DMA 1 Source Address Register
    static var dma1SourceAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00BC) 
    }
    
    /// DMA 1 Destination Address Register
    static var dma1DestinationAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00C0) 
    }
    
    /// DMA 1 Control Register
    static var dma1Control: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00C4) 
    }
    
    /// DMA 2 Source Address Register
    static var dma2SourceAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00C8) 
    }
    
    /// DMA 2 Destination Address Register
    static var dma2DestinationAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00CC) 
    }
    
    /// DMA 2 Control Register
    static var dma2Control: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00D0) 
    }
    
    /// DMA 3 Source Address Register
    static var dma3SourceAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00D4) 
    }
    
    /// DMA 3 Destination Address Register
    static var dma3DestinationAddress: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00D8) 
    }
    
    /// DMA 3 Control Register
    static var dma3Control: VolatileMappedRegister<Int32> { 
        .init(unsafeBitPattern: baseAddress + 0x00DC) 
    }
    
    // MARK: - Timer Registers
    
    /// Timer 0 Count Value
    static var timer0Count: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0100) 
    }
    
    /// Timer 0 Control Register
    static var timer0Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0102) 
    }
    
    /// Timer 1 Count Value
    static var timer1Count: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0104) 
    }
    
    /// Timer 1 Control Register
    static var timer1Control: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0106) 
    }
    
    /// Timer 2 Count Value
    static var timer2Count: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0108) 
    }
    
    /// Timer 2 Control Register
    static var timer2Control: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x010A) 
    }
    
    /// Timer 3 Count Value
    static var timer3Count: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x010C) 
    }
    
    /// Timer 3 Control Register
    static var timer3Control: VolatileMappedRegister<Int16> { 
        .init(unsafeBitPattern: baseAddress + 0x010E) 
    }
    
    // MARK: - Serial Communication Registers
    
    /// Serial I/O Control Register - Controls Normal/Multiplayer/UART modes
    static var serialControl: VolatileMappedRegister<UInt16> { 
        .init(unsafeBitPattern: baseAddress + 0x0128) 
    }
    
    /// General Serial Data Register
    
    /// Serial Input/Output Control Register
    /// Controls communication mode (Normal/Multiplayer/UART) and associated settings
    /// Handles baud rate, transfer direction, and start/busy flags
    static var serialIOControl: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0128) }
    
    /// General-purpose 32-bit Serial Data Register
    /// Used for both Normal and UART mode data transfer
    static var serialData32Bit: VolatileMappedRegister<UInt32> { .init(unsafeBitPattern: baseAddress + 0x0120) }
    
    /// 8-bit Serial Data Register
    /// Used for byte-wise communication in Normal/UART modes
    static var serialData8Bit: VolatileMappedRegister<Int16> { .init(unsafeBitPattern: baseAddress + 0x012A) }
    
    /// Multiplayer Communication Data Array
    /// Contains all data for 4-player communication mode
    static var multiplayerDataArray: VolatileMappedRegister<Int16> { .init(unsafeBitPattern: baseAddress + 0x0120) }
    
    /// Multiplayer Master Device Data Register
    /// Contains data from the controlling GameBoy Advance
    static var multiplayerMasterData: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0120) }
    
    /// Multiplayer Slave Device 1 Data Register
    /// Contains data from the first connected slave device
    static var multiplayerSlave1Data: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0122) }
    
    /// Multiplayer Slave Device 2 Data Register
    /// Contains data from the second connected slave device
    static var multiplayerSlave2Data: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0124) }
    
    /// Multiplayer Slave Device 3 Data Register
    /// Contains data from the third connected slave device
    static var multiplayerSlave3Data: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0126) }
    
    /// Multiplayer Data Receive Register
    /// Buffer for incoming multiplayer communication data
    static var multiplayerDataReceiver: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0120) }
    
    /// Multiplayer Data Transmit Register
    /// Buffer for outgoing multiplayer communication data
    static var multiplayerDataSender: VolatileMappedRegister<Int16> { .init(unsafeBitPattern: baseAddress + 0x012A) }
    
    /// Input Control Registers
    
    /// Game Input Status Register (Read-Only)
    /// Contains the current state of all GBA buttons and D-pad
    /// Bits are cleared (0) when corresponding button is pressed
    static var keyInputStatus: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0130) }
    
    /// Key Interrupt Control Register
    /// Controls which key combinations trigger interrupts
    /// Enables/disables key interrupt and sets interrupt conditions
    static var keyInterruptControl: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0132) }
    
    /// JoyBus Communication Registers
    
    /// Serial Mode Select/General Purpose Data Register
    /// Controls serial communication mode and GPIO pins
    static var serialModeSelect: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0134) }
    
    /// JoyBus Communication Control Register
    /// Controls the JoyBus communication protocol settings
    static var joyBusControl: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0140) }
    
    /// JoyBus Receive Data Register
    /// Buffer for incoming JoyBus communication data
    static var joyBusReceiveData: VolatileMappedRegister<UInt32> { .init(unsafeBitPattern: baseAddress + 0x0150) }
    
    /// JoyBus Transmit Data Register
    /// Buffer for outgoing JoyBus communication data
    static var joyBusTransmitData: VolatileMappedRegister<UInt32> { .init(unsafeBitPattern: baseAddress + 0x0154) }
    
    /// JoyBus Communication Status Register
    /// Contains flags indicating JoyBus connection and transfer status
    static var joyBusStatus: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0158) }
    
    /// System Control and Interrupt Registers
    
    /// Interrupt Enable Register
    /// Controls which hardware interrupts are enabled
    /// Each bit corresponds to a different interrupt source
    static var interruptEnable: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0200) }
    
    /// Interrupt Flag Register
    /// Shows which interrupts are currently pending
    /// Writing 1 to a bit acknowledges the corresponding interrupt
    static var interruptFlags: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0202) }
    
    /// Wait State Control Register
    /// Controls memory access timing for different memory regions
    /// Affects ROM, SRAM, and other external memory access speeds
    static var waitStateControl: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0204) }
    
    /// Interrupt Master Enable Register
    /// Global enable/disable for all hardware interrupts
    /// Must be set to 1 for any interrupts to fire
    static var interruptMasterEnable: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0208) }
    
    /// System Pause Control Register
    /// Controls system pause functionality
    /// Exact behavior may vary between hardware revisions
    static var systemPauseControl: VolatileMappedRegister<UInt16> { .init(unsafeBitPattern: baseAddress + 0x0300) }
}