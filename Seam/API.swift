//
//  API.swift
//  Seam
//
//  Created by Ricky Munz on 3/27/24.
//

import Foundation

struct BreweryPayload: Decodable {
	let name: String
}

class Api {
	static let shared = Api()

	private init() {}

	func loadBreweries(completion: @escaping ([String]) -> Void) {
		let urlString = "https://api.openbrewerydb.org/v1/breweries"

		guard var components = URLComponents(string: urlString) else {
			completion([])
			return
		}

		components.queryItems = [
			URLQueryItem(name: "per_page", value: "20")
		]

		guard let url = components.url else {
			completion([])
			return
		}

		let request = URLRequest(url: url)

		URLSession.shared.dataTask(with: request) { data, _, error in
			guard
				error == nil,
				let data,
				let breweryPayloads = try? JSONDecoder().decode([BreweryPayload].self, from: data)
			else {
				completion([])
				return
			}

			completion(breweryPayloads.map(\.name))
		}.resume()
	}
}
