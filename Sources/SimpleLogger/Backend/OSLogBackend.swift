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
import OSLog

/// OSLog 后端实现
public final class OSLogBackend: LoggerBackend {
    public let subsystem: String
    let logger: Logger

    // 从环境变量中获取是否输出日志的选项
    let loggerEnabled: Bool

    public init(subsystem: String, category: String, environmentKey: String = "DisableLogger") {
        self.subsystem = subsystem
        logger = Logger(subsystem: subsystem, category: category)
        if let value = ProcessInfo.processInfo.environment[environmentKey]?.lowercased() {
            loggerEnabled = !(value == "true" || value == "1" || value == "yes")
        } else {
            loggerEnabled = true
        }
    }

    public func log(level: LogLevel, message: String, metadata: [String: String]?) {
        let osLogType: OSLogType = {
            switch level {
            case .debug: return .debug
            case .info: return .info
            case .warning: return .default
            case .error: return .error
            }
        }()

        guard loggerEnabled else { return }

        #if DEBUG
            let fullMessage = "\(message) in \(metadata?["function"] ?? "") at \(metadata?["file"] ?? ""):\(metadata?["line"] ?? "")"
            logger.log(level: osLogType, "\(fullMessage)")
        #else
            if level > .debug {
                logger.log(level: osLogType, "\(message)")
            }
        #endif
    }
}
