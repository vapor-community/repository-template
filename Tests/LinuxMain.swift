import XCTest

import AppTests

var tests = [XCTestCaseEntry]()
tests += StubTests.allTests()

XCTMain(tests)
