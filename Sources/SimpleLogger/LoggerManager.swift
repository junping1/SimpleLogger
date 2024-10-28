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

/// 日志管理器
public final class LoggerManager: LoggerManagerProtocol, @unchecked Sendable {
    let backend: LoggerBackend
    let queue: DispatchQueue

    public init(
        backend: LoggerBackend,
        qos: DispatchQoS = .utility
    ) {
        self.backend = backend
        queue = DispatchQueue(label: backend.subsystem, qos: qos)
    }

    public func log(
        _ message: String,
        level: LogLevel = .debug,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        queue.async {
            let metadata = [
                "file": (file as NSString).lastPathComponent,
                "function": function,
                "line": String(line),
            ]
            self.backend.log(level: level, message: message, metadata: metadata)
        }
    }
}
