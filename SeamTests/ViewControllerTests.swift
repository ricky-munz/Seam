//
//  ViewControllerTests.swift
//  SeamTests
//
//  Created by Ricky Munz on 3/22/24.
//

import XCTest
@testable import Seam

final class ViewControllerTests: XCTestCase {

	func test_onInit_tableIsEmpty() {
		let sut = ViewController()
		XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
	}

	func test_viewDidLoad_tableIsPopulated() {
		let sut = ViewController()

		sut.loadViewIfNeeded()

		let expectation = expectation(description: "Load rows")

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
			expectation.fulfill()
		}

		waitForExpectations(timeout: 2)
	}
}
