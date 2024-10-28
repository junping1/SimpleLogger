# ``SimpleLogger``

A simple logging library for Swift 6, providing easy-to-use logging functionalities with support for different log levels and backends.

## Features

- **Log Levels**: Supports `.debug`, `.info`, `.warning`, and `.error` levels.
- **Custom Backends**: Easily create custom log backends by conforming to `LoggerBackend`.
- **Built-in Backends**: Includes `ConsoleLogBackend` and `OSLogBackend`.
- **Thread Safety**: Utilizes `DispatchQueue` for thread-safe logging.
- **Environment Configurable**: Control logging output via environment variables.

## Usage

### Creating a Logger

#### Default OS Logger

```swift
let logger: LoggerManagerProtocol = .default(subsystem: "com.yourapp", category: "networking")
```

#### Console Logger

```swift
let logger: LoggerManagerProtocol = .console()
```

### Logging Messages

```swift
logger.debug("This is a debug message")
logger.info("This is an info message")
logger.warning("This is a warning message")
logger.error("This is an error message")
```

### Custom Logger Backend

Conform to `LoggerBackend` to create a custom backend:

```swift
public protocol LoggerBackend: Sendable {
    var subsystem: String { get }
    var category: String { get }
    func log(level: LogLevel, message: String, metadata: [String: String]?)
}
```

Example:

```swift
struct CustomLoggerBackend: LoggerBackend {
    let subsystem: String = "Custom Logger"
    
    func log(level: LogLevel, message: String, metadata: [String: String]?) {
        // Custom logging implementation
    }
}
```

### Disabling Logs

Set the `DisableLogger` environment variable to disable logging:

```swift
ProcessInfo.processInfo.environment["DisableLogger"] = "true"
```

## Examples

### Using the Default Logger

```swift
import SimpleLogger

let logger: LoggerManagerProtocol = .default(subsystem: "com.example.app", category: "general")
logger.info("App started")
```

### Using the Console Logger

```swift
import SimpleLogger

let logger: LoggerManagerProtocol = .console()
logger.debug("Debugging information")
```

### Custom Logger Test

```swift
struct CustomLogger: LoggerManagerProtocol {
    let expect: @Sendable (String, LogLevel) -> Void
    
    func log(_ message: String, level: LogLevel, file: String, function: String, line: Int) {
        expect(message, level)
    }
}

let logger: LoggerManagerProtocol = CustomLogger(expect: { msg, level in
    #expect(msg == "Hello, World!")
    #expect(level == .info)
})
logger.info("Hello, World!")
```


