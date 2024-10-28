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

/// 示例：控制台日志后端
public final class ConsoleLogBackend: LoggerBackend {
    public let subsystem: String
    public init(subsystem: String = "console logger") {
        self.subsystem = subsystem
    }

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()

    public func log(level: LogLevel, message: String, metadata: [String: String]?) {
        let timestamp = dateFormatter.string(from: Date())
        let fullMessage = "\(timestamp) [\(level.rawValue.uppercased())] " +
            "\(message) in \(metadata?["function"] ?? "") at \(metadata?["file"] ?? ""):\(metadata?["line"] ?? "")"
        print(fullMessage)
    }
}
