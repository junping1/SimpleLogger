//
//  ------------------------------------------------
//  Original project: LoggerManager
//  Created on 2024/10/28 by Fatbobman(东坡肘子)
//  X: @fatbobman
//  Mastodon: @fatbobman@mastodon.social
//  GitHub: @fatbobman
//  Blog: https://fatbobman.com
//  ------------------------------------------------
//  Copyright © 2024-present Fatbobman. All rights reserved.

import Foundation

public protocol LoggerManagerProtocol: Sendable {
    func log(
        _ message: String,
        level: LogLevel,
        file: String,
        function: String,
        line: Int
    )
}

extension LoggerManagerProtocol {
    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }

    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }

    public func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }

    public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
}

extension LoggerManagerProtocol where Self == LoggerManager {
    static func `default`(subsystem: String, category: String) -> Self {
        LoggerManager(backend: OSLogBackend(subsystem: subsystem, category: category))
    }

    static func console(subsystem: String = "Console Logger") -> Self {
        LoggerManager(backend: ConsoleLogBackend(subsystem: subsystem))
    }
}
