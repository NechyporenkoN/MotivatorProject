//
//  CreateFamilyTableViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import JTMaterialSpinner
import CropViewController

final class CreateFamilyTableViewController: UITableViewController {
	
	private var presenter: CreateFamilyTablePresenterDelegate?
	private var spinnerView = JTMaterialSpinner()
	var avatar: UIImage? { didSet { tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic) }}
	
	init(currentUser: User?) {
		if #available(iOS 13.0, *) {
			super.init(style: .insetGrouped)
		} else {
			super.init(style: .grouped)
		}
		presenter = CreateFamilyTablePresenter(view: self, currentUser: currentUser)
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
		navigationItem.title = "Create family"
		tableView.keyboardDismissMode = .onDrag
		tableView.backgroundColor = .black
		tableView.separatorColor = .black
		tableView.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
		tableView.register(TaskNameTableViewCell.self, forCellReuseIdentifier: String(describing: TaskNameTableViewCell.self))
		tableView.register(SetupFamilyAvatarTableViewCell.self, forCellReuseIdentifier: String(describing: SetupFamilyAvatarTableViewCell.self))
		tableView.register(SetupAvatarButtonTableViewCell.self, forCellReuseIdentifier: String(describing: SetupAvatarButtonTableViewCell.self))
		
		let createBarButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createBarButtonPressed))
		navigationItem.rightBarButtonItem = createBarButton
	}
	
	private func configureSubviews() {
		spinnerView.circleLayer.lineWidth = 5.0
		spinnerView.circleLayer.strokeColor = UIColor.lightGray.cgColor//UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0).cgColor
		spinnerView.animationDuration = 2.5
		spinnerView.frame = CGRect(x: tableView.center.x - 40, y: tableView.center.y - 100, width: 80, height: 80)
		view.addSubview(spinnerView)
	}
	
	private func showInviteActionSheet() {
		
		let alert = UIAlertController(title: "Who do you want to invite?", message: nil, preferredStyle: .actionSheet)
		
		let message = "Hey, invite you to join our family"
		var textToShare = [ message ]
		if let familyID = presenter?.userID {
			textToShare.append(familyID)
		}
		let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
		activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
		
		let parentAction = UIAlertAction(title: "Parent", style: .default) { [weak self] (_) in
			self?.present(activityViewController, animated: true, completion: nil)
		}
		let childAction = UIAlertAction(title: "Child", style: .default) { [weak self] (_) in
			self?.present(activityViewController, animated: true, completion: nil)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] (_) in
			self?.navigationController?.popViewController(animated: true)
		}
		let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
		alert.view.backgroundColor = .clear
		subview.backgroundColor = .darkGray
		
		alert.addAction(parentAction)
		alert.addAction(childAction)
		alert.addAction(cancelAction)
		present(alert, animated: true, completion: nil)
	}
	
	@objc func createBarButtonPressed() {
		guard fmilyNameDidRequest() != nil else { return }
		presenter?.uploadAvatarImage(image: avatar)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 1 ? 2 : 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			if indexPath.row == 0 {
				let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SetupFamilyAvatarTableViewCell.self), for: indexPath) as! SetupFamilyAvatarTableViewCell
				cell.configure(avatar: avatar)
				return cell
			}
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SetupAvatarButtonTableViewCell.self), for: indexPath) as! SetupAvatarButtonTableViewCell
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskNameTableViewCell.self), for: indexPath) as! TaskNameTableViewCell
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 1 {
			if indexPath.row == 0 {
				return 208
			}
		}
		return 50
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 1 {
			if indexPath.row == 1 {
				showAddPhotoAlert()
			}
		}
	}
}

// MARK: - CreateFamilyTableViewDelegate
extension CreateFamilyTableViewController: CreateFamilyTableViewDelegate {
	
	func popViewController() {
		let familyController = FamilyTableViewController(currentUser: presenter?.currentUser)
		navigationController?.viewControllers.insert(familyController, at: 1)
		navigationController?.popViewController(animated: true)
	}
	
	func spinnerStartAnimate() {
		spinnerView.beginRefreshing()
	}
	
	func spinnerStopAnimate() {
		spinnerView.endRefreshing()
	}
	
	func fmilyNameDidRequest() -> String? {
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TaskNameTableViewCell else { return nil }
		return cell.requestUpdatedName()
	}
	
	func showAlert() {
		let alert = UIAlertController(title: "Do you want to add a member?", message: "", preferredStyle: .alert)
		
		let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
		alert.view.backgroundColor = .clear
		subview.backgroundColor = .darkGray
		
		let inviteAction = UIAlertAction(title: "Invite", style: .default) { [weak self] (_) in
			print("Invite")
			self?.showInviteActionSheet()
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] (_) in
			self?.navigationController?.popViewController(animated: true)
		}
		alert.addAction(inviteAction)
		alert.addAction(cancelAction)
		present(alert, animated: true, completion: nil)
	}
}

extension CreateFamilyTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropViewControllerDelegate {

		private func showAddPhotoAlert() {
		
		let alert = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (action) in
			self?.showCamera() }))
		
		alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { [ weak self] (action) in
			self?.showPhotoLibrary() }))
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	private func showPhotoLibrary() {
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .photoLibrary
			imagePickerController.allowsEditing = false
			present(imagePickerController, animated: true, completion: nil)
		}
	}
	
	private func showCamera() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .camera
			imagePickerController.allowsEditing = false
			present(imagePickerController, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

		dismiss(animated: true) {
			self.presentCropViewController(image: pickedImage)
		}
	}
	
	func presentCropViewController(image: UIImage) {
		let cropViewController = CropViewController(image: image)
		cropViewController.delegate = self //as! CropViewControllerDelegate
		present(cropViewController, animated: true, completion: nil)
	}
	
	func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
		cropViewController.dismiss(animated: true, completion: nil)
	}
	
	func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
			avatar = image
		cropViewController.dismiss(animated: true, completion: nil)
	}
}

//protocol ImagePickerControllerDelegate: class {
//	func imagePickerControllerDidFinish(image: UIImage?, _: UIImagePickerController)
//}
