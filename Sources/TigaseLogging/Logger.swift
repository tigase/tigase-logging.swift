//
// Logger.swift
//
// Tigase Logging for Swift
// Copyright (C) 2020 "Tigase, Inc." <office@tigase.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. Look for COPYING file in the top folder.
// If not, see http://www.gnu.org/licenses/.
//

import Foundation


#if canImport(os)
import os
#endif

public struct Logger {
    
    #if DEBUG
    public static var DISABLE_SECURE_LOGGING = true
    #else
    public static var DISABLE_SECURE_LOGGING = false
    #endif
    
    #if canImport(os)
    private let log: OSLog;
    #else
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS";
        return formatter;
    }();
    private let category: String;
    #endif
    
    public init(subsystem: String, category: String) {
        #if canImport(os)
        log = OSLog(subsystem: subsystem, category: category);
        #else
        self.category = category;
        #endif
    }
    
    public func debug(_ msg: LogMessage) {
        log(level: .debug, msg);
    }
        
    public func info(_ msg: LogMessage) {
        log(level: .info, msg);
    }
    
    public func log(level: LogLevel = .default, _ msg: LogMessage) {
        #if canImport(os)
        if log.isEnabled(type: level.logLevel) {
            os_log("%{public}s", log: log, type: level.logLevel, msg.description);
        }
        #else
        print("\(Logger.dateFormatter.string(from: Date())) \(category) \(level.name) \(msg.description)")
        #endif
    }
    
    public func error(_ msg: LogMessage) {
        log(level: .error, msg);
    }
    
    public func fault(_ msg: LogMessage) {
        log(level: .fault, msg);
    }
    
}

public enum LogLevel {
    case debug
    case info
    case `default`
    case error
    case fault
    
    #if canImport(os)
    public var logLevel: OSLogType {
        switch self {
        case .debug:
            return .debug;
        case .info:
            return .info;
        case .default:
            return .default;
        case .error:
            return .error;
        case .fault:
            return .fault;
        }
    }
    #else
    public var name: String {
        switch self {
        case .debug:
            return "DEBUG";
        case .info:
            return "INFO";
        case .default:
            return "DEFAULT";
        case .error:
            return "ERROR";
        case .fault:
            return "FAULT";
        }
    }
    #endif
}

