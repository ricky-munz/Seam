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
		let datasourceSpy = BreweryDatasourceSpy()
		let sut = ViewController(datasource: datasourceSpy)

		sut.loadViewIfNeeded()

		datasourceSpy.completion?(Array(repeating: "Test", count: 20))

		XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 20)
	}
}

private class BreweryDatasourceSpy: BreweryDatasource {
	var completion: (([String]) -> Void)?

	func loadBreweries(completion: @escaping ([String]) -> Void) {
		self.completion = completion
	}
}
