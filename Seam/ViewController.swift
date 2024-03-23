//
//  ViewController.swift
//  Seam
//
//  Created by Ricky Munz on 3/21/24.
//

import UIKit

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
			URLQueryItem(name: "per_page", value: "2")
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

class ViewController: UIViewController {

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()

		Api.shared.loadBreweries() { breweryNames in
			print(breweryNames)
		}
	}

	private func configureViews() {
		tableView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(tableView)

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
