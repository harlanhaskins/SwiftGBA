import _Volatile

/// A Logging module for writing logs to mGBA's log stream.
enum Log {
    private enum Level: UInt16 {
        /// Fatal causes mGBA to halt execution.
        case fatal = 0x100
        case error = 0x101
        case warning = 0x102
        case info = 0x103
        case debug = 0x104
    }

    /// Buffer for log messages to be written to.
    private static var logBuffer: UnsafeMutableRawPointer { .init(bitPattern: 0x04FF_F600)! }

    /// Send register.
    ///
    /// Writing a level to this address drains the log buffer, logging it at the given log level.
    private static let sendLogMailbox = VolatileMappedRegister<UInt16>(unsafeBitPattern: 0x04FF_F700)

    /// Register for enabling logging.
    ///
    /// Writing a value of `0xC0DE` to this address will initialize logging. If logging was initialized
    /// properly in mGBA, reading this address will return the value `0x1DEA`.
    private static let logEnableMailbox = VolatileMappedRegister<UInt16>(unsafeBitPattern: 0x04FF_F780)

    private static func writeLog(_ message: StaticString, at level: Level) {
        let cString = UnsafeBufferPointer(start: message.utf8Start, count: message.utf8CodeUnitCount)
        let dst = UnsafeMutableRawBufferPointer(start: logBuffer, count: message.utf8CodeUnitCount)
        dst.copyBytes(from: cString)
        send(level)
    }

    private static func writeLog(_ message: UnsafePointer<UInt8>, at level: Level) {
        let dst = logBuffer.assumingMemoryBound(to: UInt8.self)
        strcpy(dst, message)
        send(level)
    }

    private static func send(_ level: Level) {
        sendLogMailbox.store(level.rawValue)
    }

    static func enable() {
        logEnableMailbox.store(0xC0DE)
    }

    static func debug(_ message: StaticString) {
        writeLog(message, at: .debug)
    }
    static func info(_ message: StaticString) {
        writeLog(message, at: .info)
    }
    static func warning(_ message: StaticString) {
        writeLog(message, at: .warning)
    }
    static func error(_ message: StaticString) {
        writeLog(message, at: .error)
    }
    static func fatal(_ message: StaticString) {
        writeLog(message, at: .fatal)
    }
    static func debug(cString message: UnsafePointer<UInt8>) {
        writeLog(message, at: .debug)
    }
    static func info(cString message: UnsafePointer<UInt8>) {
        writeLog(message, at: .info)
    }
    static func warning(cString message: UnsafePointer<UInt8>) {
        writeLog(message, at: .warning)
    }
    static func error(cString message: UnsafePointer<UInt8>) {
        writeLog(message, at: .error)
    }
    static func fatal(cString message: UnsafePointer<UInt8>) {
        writeLog(message, at: .fatal)
    }
}