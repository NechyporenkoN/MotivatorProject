//
//  SelectPerformerTableViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class SelectPerformerTableViewController: UITableViewController {
	
	private var presenter: SelectPerformerTablePresenterDelegate?
	var previousController: CreateNewTaskTableViewController?
	
	init(controller: CreateNewTaskTableViewController?) {
		previousController = controller
		if #available(iOS 13.0, *) {
			super.init(style: .insetGrouped)
		} else {
			super.init(style: .grouped)
			
		}
		presenter = SelectPerformerTablePresenter(view: self, currentUser: previousController?.presenter?.currentUser)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	
	private func configureView() {
		navigationItem.title = "Select Performer"
		tableView.backgroundColor = .black
		tableView.separatorColor = .black
		tableView.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
		tableView.register(SelectPerformerTableViewCell.self, forCellReuseIdentifier: String(describing: SelectPerformerTableViewCell.self))
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectPerformerTableViewCell.self), for: indexPath) as! SelectPerformerTableViewCell
		cell.configure(user: presenter?.dataSource[indexPath.section])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		previousController?.selectedUser = presenter?.dataSource[indexPath.section]
		navigationController?.popViewController(animated: true)
	}
}

// MARK: - SelectPerformerTableViewDelegate
extension SelectPerformerTableViewController: SelectPerformerTableViewDelegate {
	
	func tableViewReloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
