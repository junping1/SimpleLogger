@testable import LoggerManager
import Testing

/// add `DisableLogger = true` in environment variables can disable log output
@Test func osLoggerTest() async throws {
    let logger: LoggerManagerProtocol = .default(subsystem: "test", category: "default")
    logger.info("Hello, World!")
}

@Test func consoleLoggerTest() async throws {
    let logger: LoggerManagerProtocol = .console()
    logger.info("Hello, World!")
}

@Test func customLoggerTest() async throws {
    let logger: LoggerManagerProtocol = CustomLogger(expect: { meg, level in
        #expect(meg == "Hello, World!")
        #expect(level == .info)
    })
    logger.info("Hello, World!")
}

struct CustomLogger: LoggerManagerProtocol {
    let expect: @Sendable (String, LogLevel) -> Void
    func log(_ message: String, level: LogLevel, file: String, function: String, line: Int) {
        expect(message, level)
    }
}
