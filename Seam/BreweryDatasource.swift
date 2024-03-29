//
//  BreweryDatasource.swift
//  Seam
//
//  Created by Ricky Munz on 3/27/24.
//

import Foundation

protocol BreweryDatasource {
	var breweries: [String] { get }
	func loadBreweries(completion: @escaping ([String]) -> Void)
}

class ApiBreweryDatasource: BreweryDatasource {
	private(set) var breweries = [String]()

	func loadBreweries(completion: @escaping ([String]) -> Void) {
		Api.shared.loadBreweries { breweries in
			self.breweries = breweries
			completion(breweries)
		}
	}
}
