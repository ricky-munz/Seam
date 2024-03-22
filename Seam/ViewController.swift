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
}

class ViewController: UIViewController {

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()
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
