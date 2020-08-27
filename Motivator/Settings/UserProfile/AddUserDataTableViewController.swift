//
//  CreateUserProfileTableViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/27/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import JTMaterialSpinner

final class AddUserDataTableViewController: UITableViewController {
	
	private var presenter: AddUserDataTablePresenterDelegate?
	var spinnerView = JTMaterialSpinner()
	var avatarImage: UIImage?
	
	init(user: User?) {
		if #available(iOS 13.0, *) {
			super.init(style: .insetGrouped)
		} else {
			super.init(style: .grouped)
		}
		presenter = AddUserDataTablePresenter(view: self, user: user)
		hidesBottomBarWhenPushed = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//		SelectFamilyRoleTableViewController().delegate = self
		
		configureView()
		configureSubviews()
	}
	
	private func configureView() {
		
		navigationItem.title = "Edit Profile"
		
		let nextButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
		navigationItem.rightBarButtonItem = nextButton
		//		navigationItem.hidesBackButton = true
		//		navigationController?.navigationBar.backgroundColor = tableView.backgroundColor
		//		tableView.separatorColor = GeneralColors.globalColor
		tableView.separatorStyle = .none
//		tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		tableView.backgroundColor = .black
		tableView.keyboardDismissMode = .interactive
		tableView.register(AddingUserDataTableViewCell.self, forCellReuseIdentifier: String(describing: AddingUserDataTableViewCell.self))
		tableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: String(describing: LogOutTableViewCell.self))
		
	}
	
	private func configureSubviews() {
		spinnerView.circleLayer.lineWidth = 5.0
		spinnerView.circleLayer.strokeColor = UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0).cgColor
		spinnerView.animationDuration = 2.5
		spinnerView.frame = CGRect(x: tableView.center.x - 40, y: tableView.center.y - 100, width: 80, height: 80)
		
		view.addSubview(spinnerView)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddingUserDataTableViewCell.self), for: indexPath) as! AddingUserDataTableViewCell
			cell.delegate = self
			cell.configure(newImage: avatarImage, user: presenter?.currentUser)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogOutTableViewCell.self), for: indexPath) as! LogOutTableViewCell
		cell.delegate = self
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return indexPath.section == 0 ? 120 : 50
	}
	
//	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		return nil
//	}
//	
//	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		return 10
//	}
//	
//	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//		return nil
//	}
//	
//	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//		return 0
//	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//		if indexPath.section == 1 {
		//			let destination = SelectFamilyRoleTableViewController()
		//			destination.delegate = self
		//			navigationController?.show(destination, sender: self)
		//		}
	}
	
	@objc func doneButtonPressed() {
		
		presenter?.uploadAvatarImage(image: avatarImage)
		//		presenter?.updateUserDataIfNeeded()
	}
}


// MARK: - CreateUserProfileTableViewDelegate
extension AddUserDataTableViewController: AddUserDataTableViewDelegate {
	
	func popViewController() {
		navigationController?.popViewController(animated: true)
	}
	
	func reloadTableView() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	func userNameDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddingUserDataTableViewCell else {
			return nil
		}
		return cell.requestUpdatedName()
	}
	
	func spinnerStartAnimate() {
		spinnerView.beginRefreshing()
	}
	
	func spinnerStopAnimate() {
		spinnerView.endRefreshing()
	}
}

//extension AddUserDataTableViewController: SelectFamilyRoleDelegate {
//	
//	func selectedRole(role: FamilyRoleRow) {
//		presenter?.familyRole = role
//		print(" l o l o l o ", role.rawValue)
//		reloadTableView()
//	}
//}

extension AddUserDataTableViewController: AddPhotoButtonDelegate{
	
	func addPhotoButtonDidTap() {
		showAlert()
	}
}

extension AddUserDataTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	private func showAlert() {
		
		let alert = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (action) in
			self?.showCamera() }))
		
		alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { [ weak self] (action) in
			self?.showPhotoLibrary() }))
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	func showPhotoLibrary() {
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .photoLibrary
			imagePickerController.allowsEditing = true
			present(imagePickerController, animated: true, completion: nil)
		}
	}
	
	func showCamera() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .camera
			imagePickerController.allowsEditing = true
			present(imagePickerController, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			//			presenter?.avatarRepresentation = MediaRepresentation(image)
			avatarImage = image
		}
		
		
		dismiss(animated: true) {
			self.tableView.reloadSections([0], with: .automatic)
		}
	}
	
}

//
//
//	func showPhotoLibrary() {
//		guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
////		checkPHStatus(controller: self) { [weak self] (state) in
//			guard let self = self, state else { return }
//			let imagePickerController = UIImagePickerController()
//			imagePickerController.delegate = self
//			imagePickerController.sourceType = .photoLibrary
//			imagePickerController.allowsEditing = true
//			self.present(imagePickerController, animated: true, completion: nil)
////		}
//	}
//
//	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//		dismiss(animated: true, completion: nil)
//	}
//
//

//}

extension AddUserDataTableViewController: LogOutTableViewCellDelegate {
	
	func logOutDidTap() {
		presenter?.logOutRequest()
	}
	
	
}

