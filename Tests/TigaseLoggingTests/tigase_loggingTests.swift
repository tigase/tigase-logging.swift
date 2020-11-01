//
// tigase_loggingTests.swift
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

import XCTest
@testable import TigaseLogging

final class tigase_loggingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let logger = Logger(subsystem: "TigaseLogging", category: "Test");
        let date = Date();
        logger.log(level: .debug, "Some message with \(date) embedded in it");
        XCTAssertTrue(true);
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
