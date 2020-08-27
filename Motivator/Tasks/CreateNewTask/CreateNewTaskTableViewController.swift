//
//  CreateNewTaskTableViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit


final class CreateNewTaskTableViewController: UITableViewController {
	
	let datePicker: UIDatePicker = {
		let picker = UIDatePicker()
		picker.translatesAutoresizingMaskIntoConstraints = false
		picker.timeZone = NSTimeZone.local
		picker.locale = NSLocale.init(localeIdentifier: "ru_RU") as Locale
		picker.datePickerMode = .dateAndTime
		
		return picker
	}()
	
	var presenter: CreateNewTaskPresenterDelegate?
	var deadline: String?
	var priority: PriorityType? { didSet { tableView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .automatic) }}
	var selectedUser: User? { didSet { tableView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .automatic) }}
	
	init(currentUser: User?) {
		if #available(iOS 13.0, *) {
			super.init(style: .insetGrouped)
		} else {
			super.init(style: .grouped)
			
		}
		presenter = CreateNewTaskPresenter(view: self, currentUser: currentUser)
		hidesBottomBarWhenPushed = true
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
		
		navigationItem.title = "Create New Task"
		
		tableView.keyboardDismissMode = .interactive
		tableView.backgroundColor = .black
		tableView.separatorColor = .black
		tableView.estimatedRowHeight = 50
		
		tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		tableView.register(TaskNameTableViewCell.self, forCellReuseIdentifier: String(describing: TaskNameTableViewCell.self))
		tableView.register(TaskDescriptionTableViewCell.self, forCellReuseIdentifier: String(describing: TaskDescriptionTableViewCell.self))
		tableView.register(TaskDeadlineTableViewCell.self, forCellReuseIdentifier: String(describing: TaskDeadlineTableViewCell.self))
		tableView.register(TaskPriorityTableViewCell.self, forCellReuseIdentifier: String(describing: TaskPriorityTableViewCell.self))
		tableView.register(TaskRewardTableViewCell.self, forCellReuseIdentifier: String(describing: TaskRewardTableViewCell.self))
		tableView.register(TaskPerformerTableViewCell.self, forCellReuseIdentifier: String(describing: TaskPerformerTableViewCell.self))
		
		let createButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createButtonPressed))
		navigationItem.rightBarButtonItem = createButton
	}
	
	//	func configureOkActon() {
	//		print(dateString != nil)
	//		okAction?.isEnabled = dateString != nil ? true : false
	//	}
	
	private func showAlertDatePicker() {
		
		datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
		datePicker.setValue(UIColor.lightGray, forKeyPath: "textColor")
		datePicker.setValue(false, forKeyPath: "highlightsToday")
	
//		let attributedTitle = NSAttributedString(string: "Set the time to complete the task", attributes: [
//			NSAttributedString.Key.foregroundColor : UIColor.red
//		])
		let alertView = UIAlertController(title: "Set the time to complete the task", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
		
		alertView.view.addSubview(datePicker)
		let subview = (alertView.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
		alertView.view.backgroundColor = .clear
		subview.backgroundColor = .darkGray
		datePicker.topAnchor.constraint(equalTo: alertView.view.topAnchor, constant: 24).isActive = true
		datePicker.centerXAnchor.constraint(equalTo: alertView.view.centerXAnchor).isActive = true
//		alertView.setValue(attributedTitle, forKey: "attributedTitle")
		let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
			
			print("ok")
		}
		alertView.addAction(okAction)
		present(alertView, animated: true, completion: nil)
	}
	
	
	private func configureSubviews() {
		//view.addSubview
		//constraints
	}
	
	@objc func datePickerValueChanged(_ sender: UIDatePicker) {
		
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"HH:mm:ss"
		
		deadline = dateFormatter.string(from: sender.date)
		tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .automatic)
	}
	
	@objc func createButtonPressed() {
		presenter?.createNewTask()
		
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let typeCell = presenter?.dataSource[indexPath.section] ?? .taskName
		
		switch typeCell {
		case .taskName:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskNameTableViewCell.self), for: indexPath) as! TaskNameTableViewCell
			return cell
		case .description:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskDescriptionTableViewCell.self), for: indexPath) as! TaskDescriptionTableViewCell
			cell.delegate = self
			return cell
		case .deadline:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskDeadlineTableViewCell.self), for: indexPath) as! TaskDeadlineTableViewCell
			cell.configure(date: deadline)
			return cell
		case .reward:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskRewardTableViewCell.self), for: indexPath) as! TaskRewardTableViewCell
			return cell
		case .priority:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskPriorityTableViewCell.self), for: indexPath) as! TaskPriorityTableViewCell
			cell.configure(priority: priority)
			return cell
		case .performer:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskPerformerTableViewCell.self), for: indexPath) as! TaskPerformerTableViewCell
			cell.configure(user: selectedUser)
			return cell
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter?.dataSource[section].rawValue
	}
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if indexPath.row == 1 {
			return UITableView.automaticDimension
		}
		return 50
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let typeCell = presenter?.dataSource[indexPath.section] ?? .taskName
		switch typeCell {
		case .deadline:
			showAlertDatePicker()
		case .priority:
			let destination = SelectPriorityForTaskTableViewController(controller: self)
			navigationController?.show(destination, sender: self)
		case .performer:
			let destination = SelectPerformerTableViewController(controller: self)
			navigationController?.show(destination, sender: self)
		default: break
		}
	}
	
	func taskNameDidRequest() -> String? {
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TaskNameTableViewCell else { return nil }
		return cell.requestUpdatedName()
	}
	
	func descriptionDidRequest() -> String? {
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? TaskDescriptionTableViewCell else { return nil }
		return cell.requestUpdatedDescription()
	}
	
	func rewardDidRequest() -> String? {
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? TaskRewardTableViewCell else { return nil }
		return cell.requestUpdatedReward()
	}
}

// MARK: - CreateNewTaskViewDelegate
extension CreateNewTaskTableViewController: CreateNewTaskViewDelegate {
	
	func popToViewController() {
		navigationController?.popViewController(animated: true)
	}
}

extension CreateNewTaskTableViewController: TaskDescriptionTableViewCellDelegate {
	func updateHeightOfRow(_ cell: UITableViewCell, _ textView: UITextView) {
		
		let size = textView.bounds.size
		let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
		
		if size.height != newSize.height {
			UIView.performWithoutAnimation {
				self.tableView.performBatchUpdates(nil, completion: nil)
				
				if let thisIndexPath = self.tableView.indexPath(for: cell) {
					self.tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
				}
			}
		}
	}}
