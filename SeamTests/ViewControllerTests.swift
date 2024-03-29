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
		let sut = ViewController(datasource: BreweryDatasourceSpy())
		XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
	}

	func test_viewDidLoad_tableIsPopulated() {
		let datasourceSpy = BreweryDatasourceSpy()
		let sut = ViewController(datasource: datasourceSpy)

		sut.loadViewIfNeeded()

		datasourceSpy.breweries = Array(repeating: "Test", count: 20)
		datasourceSpy.completion?()

		XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 20)
	}
}

private class BreweryDatasourceSpy: BreweryDatasource {
	var breweries = [String]()
	var completion: (() -> Void)?

	func loadBreweries(completion: @escaping () -> Void) {
		self.completion = completion
	}
}
