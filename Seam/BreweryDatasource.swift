//
//  BreweryDatasource.swift
//  Seam
//
//  Created by Ricky Munz on 3/27/24.
//

import Foundation

protocol BreweryDatasource {
	func loadBreweries(completion: @escaping ([String]) -> Void)
}

class ApiBreweryDatasource: BreweryDatasource {
	func loadBreweries(completion: @escaping ([String]) -> Void) {
		Api.shared.loadBreweries(completion: completion)
	}
}
