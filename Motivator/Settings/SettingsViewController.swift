//
//  SettingsViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
	
	private var presenter: SettingsPresenterDelegate?
	
	
	init() {
		if #available(iOS 13.0, *) {
			super.init(style: .insetGrouped)
		} else {
			super.init(style: .grouped)
		}
		presenter = SettingsPresenter(view: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		configureSubviews()
		
	}
	
	private func configureView() {

		tableView.backgroundColor = .black
//		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

		tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: String(describing: SettingsTableViewCell.self))
	}
	
	private func configureSubviews() {
		//view.addSubview
		//constraints
	}
	
	//	private func showAddUserDataController() {
	//		let destination = AddUserDataTableViewController(user: presenter?.currentUser)
	//		navigationController?.show(destination, sender: self)
	//	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource[section].count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let presenter = presenter else { return UITableViewCell()}
		let section = presenter.dataSource[indexPath.section][indexPath.row]
		switch section {
		case .userProfile:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self), for: indexPath) as! SettingsTableViewCell
			cell.configure(title: "Profile", iconName: "Profile")
//			cell.cornerRect = .topLeft
			return cell
		case .family:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self), for: indexPath) as! SettingsTableViewCell
					cell.configure(title: "Family", iconName: "Family")
			return cell
		case .stars:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self), for: indexPath) as! SettingsTableViewCell
						cell.configure(title: "Motivation Star", iconName: "Star")
//			cell.cornerRect = .bottomRight
			return cell
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
//	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		return nil
//	}
	
//	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		if section == 0 {
//			return "Profile"
//		}
//		if section == 1 {
//			return "Family"
//		}
//		return nil
//	}

	
//	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		return 10//30//section == 2 ? 0 : 16
//	}
	
//	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//		return nil
//	}
//	
//	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//		return 0
//	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let presenter = presenter else { return }
		let section = presenter.dataSource[indexPath.section][indexPath.row]
		switch section {
		case .userProfile:
			let destination = AddUserDataTableViewController(user: presenter.currentUser)
			navigationController?.show(destination, sender: self)
		case .family:
			if presenter.currentUser?.familyID != nil {
				let destination = FamilyTableViewController(currentUser: presenter.currentUser)
				navigationController?.show(destination, sender: self)
			} else {
				showActionSheet()
			}
		case .stars:
			print("coins")
		}
	}
	
	private func showActionSheet() {
		
		let alert = UIAlertController(title: "Do you want to create a new family or join an existing one?", message: nil, preferredStyle: .actionSheet)
		
		let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
		alert.view.backgroundColor = .clear
		subview.backgroundColor = .darkGray
		
		let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] (action) in
			let destination = CreateFamilyTableViewController(currentUser: self?.presenter?.currentUser)
			self?.navigationController?.show(destination, sender: self)
		}
		let joinAction = UIAlertAction(title: "Join", style: .default) { [weak self] (action) in
			let destination = JoinFamilyTableViewController(currentUser: self?.presenter?.currentUser)
			self?.navigationController?.show(destination, sender: self)
		}
		alert.addAction(createAction)
		alert.addAction(joinAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {
	
	func tableViewReloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
