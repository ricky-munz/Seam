//
//  ViewController.swift
//  Seam
//
//  Created by Ricky Munz on 3/21/24.
//

import UIKit

class Api {
	static let shared = Api()

	private init() {}

	func loadBreweries(completion: ([String]) -> Void) {

	}
}

class ViewController: UIViewController {

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()

		Api.shared.loadBreweries() { _ in

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
