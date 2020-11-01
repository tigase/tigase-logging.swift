//
// LogMessageInterpolation.swift
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

public struct LogMessageInterpolation: StringInterpolationProtocol {
    
    public typealias StringLiteralType = String

    private var values: [(LogPrivacy,()->String)] = [];
    
    public var description: String {
        return values.map({
            switch $0.0 {
            case .auto(let mask):
                if Logger.DISABLE_SECURE_LOGGING {
                    return $0.1();
                } else {
                    switch mask {
                    case .none:
                        return "<<private>>";
                    case .hash:
                        return "<<hash: \(String(format: "%02X", $0.1().hashValue).suffix(6))>>";
                    }
                }
            case .private(let mask), .sensitive(let mask):
                switch mask {
                case .none:
                    return "<<private>>";
                case .hash:
                    return "\($0.1()).hashValue)";
                }
            case .public:
                return $0.1();
            }
        }).joined();
    }
    
    public init(literalCapacity: Int, interpolationCount: Int) {
    }
    
    public mutating func appendLiteral(_ literal: String) {
        values.append((.public, { literal }));
    }

    public mutating func appendInterpolation<T: Error>(_ suppplier: @autoclosure @escaping ()->T, privacy: LogPrivacy =  .public) {
        values.append((privacy, { String(reflecting: suppplier()) }));
    }

    public mutating func appendInterpolation(_ suppplier: @autoclosure @escaping ()->Int, privacy: LogPrivacy = .public) {
        values.append((privacy, { String(suppplier()) }));
    }
    
    public mutating func appendInterpolation(_ suppplier: @autoclosure @escaping ()->Double, privacy: LogPrivacy = .public) {
        values.append((privacy, { String(suppplier()) }));
    }

    public mutating func appendInterpolation(_ suppplier: @autoclosure @escaping ()->Any.Type, privacy: LogPrivacy =  .public) {
        values.append((privacy, { String(reflecting: suppplier()) }));
    }

    public mutating func appendInterpolation<T: CustomStringConvertible>(_ suppplier: @autoclosure @escaping ()->T, privacy: LogPrivacy = .auto(mask: .none)) {
        values.append((privacy, { String(describing: suppplier()) }));
    }

    public mutating func appendInterpolation<T: Any>(_ suppplier: @autoclosure @escaping ()->T, privacy: LogPrivacy = .public) {
        values.append((privacy, { String(describing: suppplier()) }));
    }

    public mutating func append(supplier: @escaping ()->String, privacy: LogPrivacy) {
        values.append((privacy, supplier));
    }
    
}
