//
//  TasksViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class TasksTableViewController: UITableViewController {
	
	private var presenter: TasksTablePresenterDelegate?
	var selectedIndexs: [IndexPath: Bool] = [:]
	
	init() {
		super.init(style: .plain)
		presenter = TasksTablePresenter(view: self)
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
		tableView.separatorStyle = .singleLine
		tableView.separatorColor = .black
//		tableView.setEditing(true, animated: true)
		
		tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: String(describing: TaskTableViewCell.self))
		
//		configureAddTaskButton()
	}
	
	func configureAddTaskButton() {
		if presenter?.currentUser?.rights == Rights.parent.rawValue {
			let addTaskBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButtonPressed))
			navigationItem.rightBarButtonItem = addTaskBarButton
		} else {
			navigationItem.rightBarButtonItem =  nil
		}
	}
	
	private func configureSubviews() {
		//view.addSubview
		//constraints
	}
	
	private func cellIsSelected(indexPath: IndexPath) -> Bool {
		if let number = selectedIndexs[indexPath] {
			return number
		} else {
			return false
		}
	}
	
	
	@objc func addTaskButtonPressed() {
		let destination = CreateNewTaskTableViewController(currentUser: presenter?.currentUser)
		navigationController?.show(destination, sender: self)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskTableViewCell.self), for: indexPath) as! TaskTableViewCell
		cell.configure(task: presenter?.dataSource[indexPath.row], isSelected: selectedIndexs[indexPath] ?? false, rights: presenter?.currentUser?.rights ?? "child")
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if self.cellIsSelected(indexPath: indexPath) {
			return UIScreen.main.bounds.size.width//height - ((navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height) - (tabBarController?.tabBar.frame.height ?? 0)
		} else {
			return 120
		}
		//		return 120
	}
	
	//	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
	//
	//		let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
	//		cell.layer.transform = translationTransform
	//
	//		UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut, animations: {
	//			cell.layer.transform = CATransform3DIdentity })
	//	}
	
	
	//	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
	//		if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
	//					cell.cellDidTap()
	//		//			cell.helperBackgroundView.frame.size.height = 400
	//				}
	//	}
	//
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//		tableView.deselectRow(at: indexPath, animated: true)
		
		let isSelected = !self.cellIsSelected(indexPath: indexPath)
		selectedIndexs[indexPath] = isSelected
		
		tableView.performBatchUpdates(nil, completion: nil)
		
		if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
			cell.cellDidTap()
		}
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		guard let presenter = presenter else { return nil }
		let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
			print("DELETE")
		}
		
		let done = UIContextualAction(style: .normal, title: "Done") { (action, view, handler) in
			print("DONE")
		}
		
		let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
			print("EDIT")
		}
		
		let approve = UIContextualAction(style: .normal, title: "Approve") { (action, view, handler) in
			print("approve")
		}
		
		let activate = UIContextualAction(style: .normal, title: "Activate") { (action, view, handler) in
			print("activate")
		}
		
		delete.backgroundColor = actionsColor(status: presenter.dataSource[indexPath.row].status)
		done.backgroundColor = actionsColor(status: presenter.dataSource[indexPath.row].status)
		edit.backgroundColor = actionsColor(status: presenter.dataSource[indexPath.row].status)
		approve.backgroundColor = actionsColor(status: presenter.dataSource[indexPath.row].status)
		activate.backgroundColor = actionsColor(status: presenter.dataSource[indexPath.row].status)
		
		if let deleteImage = textToImage(draw: "Delete", in: UIImage(named: "DeleteAction")!, at: CGPoint(x: 0, y: 57)).cgImage {
			delete.image = ImageWithoutRender(cgImage: deleteImage, scale: UIScreen.main.nativeScale, orientation: .up)
		}
		
		if let doneImage = textToImage(draw: "Done", in: UIImage(named: "DoneAction")!, at: CGPoint(x: 0, y: 57)).cgImage {
			done.image = ImageWithoutRender(cgImage: doneImage, scale: UIScreen.main.nativeScale, orientation: .up)
		}
		
		if let editImage = textToImage(draw: "Edit", in: UIImage(named: "EditAction")!, at: CGPoint(x: 0, y: 57)).cgImage {
			edit.image = ImageWithoutRender(cgImage: editImage, scale: UIScreen.main.nativeScale, orientation: .up)
		}
		
		if let approveImage = textToImage(draw: "Approve", in: UIImage(named: "DoneAction")!, at: CGPoint(x: 0, y: 57)).cgImage {
			approve.image = ImageWithoutRender(cgImage: approveImage, scale: UIScreen.main.nativeScale, orientation: .up)
		}
		
		if let activateImage = textToImage(draw: "Activate", in: UIImage(named: "ActivateAction")!, at: CGPoint(x: 0, y: 57)).cgImage {
			activate.image = ImageWithoutRender(cgImage: activateImage, scale: UIScreen.main.nativeScale, orientation: .up)
		}
		
		var configuration: UISwipeActionsConfiguration!
		let taskStatuses = presenter.dataSource[indexPath.row].status
		switch taskStatuses {
		case StatusTask.active.rawValue:
			if presenter.currentUser?.rights == Rights.parent.rawValue {
				configuration = UISwipeActionsConfiguration(actions: [delete, edit])
			} else {
				configuration = UISwipeActionsConfiguration(actions: [done])
			}
			case StatusTask.awaiting.rawValue:
			if presenter.currentUser?.rights == Rights.parent.rawValue {
				configuration = UISwipeActionsConfiguration(actions: [approve, activate])
			} else {
				configuration = UISwipeActionsConfiguration(actions: [activate])
			}
			case StatusTask.ready.rawValue:
			if presenter.currentUser?.rights == Rights.parent.rawValue {
				configuration = UISwipeActionsConfiguration(actions: [])
			} else {
				configuration = UISwipeActionsConfiguration(actions: [])
			}
			case StatusTask.unfulfilled.rawValue:
			if presenter.currentUser?.rights == Rights.parent.rawValue {
				configuration = UISwipeActionsConfiguration(actions: [])
			} else {
				configuration = UISwipeActionsConfiguration(actions: [])
			}
		default:
			break
		}
		
		configuration.performsFirstActionWithFullSwipe = false

		return configuration
	}
	
	func actionsColor(status: String?) -> UIColor? {
		guard let status = status else { return nil}
		var color: UIColor?
		
		if status == StatusTask.active.rawValue {
			color = GeneralColors.greenCellColor
		}
		else if status == StatusTask.awaiting.rawValue {
			color = GeneralColors.orangeCellColor
		}
		else if status == StatusTask.ready.rawValue {
			color = GeneralColors.purpleCellColor
		}
		else if status == StatusTask.unfulfilled.rawValue {
			color = GeneralColors.redCellColor
		}
		return color
	}
	
	//		override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	//			let frame = CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: (navigationController?.navigationBar.frame.height)! + 20)
	//			let backgroundView = UIView(frame: frame)
	//			backgroundView.backgroundColor = UIColor(red:0.15, green:0.50, blue:0.01, alpha:1.0)
	//			navigationController?.navigationBar.setBackgroundImage(backgroundView.asImage(), for: .default)
	//		}
}

// MARK: - TasksViewDelegate
extension TasksTableViewController: TasksTableViewDelegate {
	
	func tableViewReloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
