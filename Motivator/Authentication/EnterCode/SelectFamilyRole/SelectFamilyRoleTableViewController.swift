//
//  SelectFamilyRoleTableViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/28/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import JTMaterialSpinner

//protocol SelectFamilyRoleDelegate: class {
//    func selectedRole(role: FamilyRoleRow)
//}

final class SelectFamilyRoleTableViewController: UITableViewController {

	var spinnerView = JTMaterialSpinner()
	private var presenter: SelectFamilyRoleTablePresenterDelegate?
	var nextButton: UIBarButtonItem?
	
	init(familyRights: Rights?, authType: AuthType) {
		super.init(style: .grouped)
		presenter = SelectFamilyRoleTablePresenter(view: self, familyRights: familyRights, authType: authType)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureSubviews()
	}
	
	private func configureView() {
		
//		tableView.backgroundView = backgroundImageView
		navigationItem.title = "Choose Your Role"
		navigationItem.hidesBackButton = true
		nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
		navigationItem.rightBarButtonItem = nextButton
		nextButton?.isEnabled = false
		tableView.allowsSelection = true
		tableView.register(SelectFamilyRoleTableViewCell.self, forCellReuseIdentifier: String(describing: SelectFamilyRoleTableViewCell.self))
	}
	
	private func configureSubviews() {
		spinnerView.circleLayer.lineWidth = 5.0
		spinnerView.circleLayer.strokeColor = UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0).cgColor
		spinnerView.animationDuration = 2.5
		spinnerView.frame = CGRect(x: tableView.center.x - 40, y: tableView.center.y - 100, width: 80, height: 80)
//		spinnerView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

		view.addSubview(spinnerView)
	}
	
	@objc func nextButtonPressed() {
		presenter?.createUsers()
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return presenter?.dataSource.count ?? 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource[section].rows.count ?? 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SelectFamilyRoleTableViewCell.self), for: indexPath) as! SelectFamilyRoleTableViewCell
		cell.configure(role: presenter?.dataSource[indexPath.section].rows[indexPath.row] ?? .father)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter?.dataSource.count == 2 ? section == 0 ? "Parents" : "Childs" : nil
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		nextButton?.isEnabled = true
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		let role = presenter?.dataSource[indexPath.section].rows[indexPath.row]
		presenter?.familyRole = role
	}

	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
	}
//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//		selectedCell(indexPath: indexPath)
//	}
	
//	func selectedCell(indexPath: IndexPath) {
//		guard let cell = tableView.cellForRow(at: indexPath) as? SelectFamilyRoleTableViewCell, presenter != nil else { return }
//		cell.accessoryType = .none
//			switch presenter!.dataSource[indexPath.section].rows[indexPath.row] {
//			case .father:
//				cell.accessoryType = .checkmark
//			case .mother:
//				cell.accessoryType = .checkmark
//			case .son:
//				cell.accessoryType = .checkmark
//			case .daughter:
//				cell.accessoryType = .checkmark
//			}
//			if cell.isSelected {
//				cell.accessoryType = .checkmark
//			} else {
//				cell.accessoryType = .none
//			}
//			if cell.isSelectedRole {
//				cell.isSelectedRole = false
//				cell.accessoryType = .none
//			} else {
//				cell.accessoryType = .checkmark
//				cell.isSelectedRole = true
//			}
//			tableView.reloadRows(at: [indexPath], with: .none)
//		}
//	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - SelectFamilyRoleTableViewDelegate
extension SelectFamilyRoleTableViewController: SelectFamilyRoleTableViewDelegate {
	
	func setAndShowGeneralController() {
		let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
		appDel.setGeneralRootViewController()
		let destination = GeneralTabBarController()
		navigationController?.show(destination, sender: self)
	}
	
	func spinnerStartAnimate() {
		spinnerView.beginRefreshing()
	}
	
	func spinnerStopAnimate() {
		spinnerView.endRefreshing()
	}
	
	func popToViewController() {
		navigationController?.popToRootViewController(animated: true)
	}
}
