//
//  ViewController.swift
//  Seam
//
//  Created by Ricky Munz on 3/21/24.
//

import UIKit

class ViewController: UIViewController {
	let tableView = UITableView()
	private let cellReuseId = "cell"

	let datasource: BreweryDatasource

	init(datasource: BreweryDatasource = ApiBreweryDatasource()) {
		self.datasource = datasource
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureViews()

		datasource.loadBreweries { [weak self] in
			self?.runOnMainThread {
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
		datasource.breweries.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
		cell.textLabel?.text = datasource.breweries[indexPath.row]
		return cell
	}
}
