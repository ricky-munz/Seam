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
}
