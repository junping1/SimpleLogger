//
//  ------------------------------------------------
//  Original project: LoggerManager
//  Created on 2024/10/28 by Fatbobman( 东坡肘子 )
//  X: @fatbobman
//  Mastodon: @fatbobman@mastodon.social
//  GitHub: @fatbobman
//  Blog: https://fatbobman.com
//  ------------------------------------------------
//  Copyright © 2024-present Fatbobman. All rights reserved.

/// An enumeration that defines the log levels.
public enum LogLevel: String, Comparable, Sendable {
    /// The debug log level.
    case debug
    /// The info log level.
    case info
    /// The warning log level.
    case warning
    /// The error log level.
    case error
    /// The fault log level.
    case fault

    /// Compares two log levels.
    ///
    /// - Parameters:
    ///   - lhs: The left log level.
    ///   - rhs: The right log level.
    /// - Returns: A boolean value indicating whether the left log level is less than the right log level.
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        let order: [LogLevel] = [.debug, .info, .warning, .error]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
}
