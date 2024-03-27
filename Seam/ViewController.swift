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

protocol BreweryDatasource {
	func loadBreweries(completion: @escaping ([String]) -> Void)
}

class ApiBreweryDatasource: BreweryDatasource {
	func loadBreweries(completion: @escaping ([String]) -> Void) {
		Api.shared.loadBreweries(completion: completion)
	}
}

class ViewController: UIViewController {
	let tableView = UITableView()
	private let cellReuseId = "cell"

	var loadBreweries = Api.shared.loadBreweries

	var breweryNames = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()

		loadBreweries { [weak self] breweryNames in
			self?.runOnMainThread {
				self?.breweryNames = breweryNames
				self?.tableView.reloadData()
			}
		}
	}

	private func configureViews() {
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
		tableView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(tableView)

		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func runOnMainThread(_ task: @escaping () -> Void) {
		if Thread.isMainThread {
			task()
		} else {
			DispatchQueue.main.async(execute: task)
		}
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		breweryNames.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
		cell.textLabel?.text = breweryNames[indexPath.row]
		return cell
	}
}
