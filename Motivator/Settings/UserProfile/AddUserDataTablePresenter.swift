//
//  CreateUserProfileTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/27/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

final class AddUserDataTablePresenter {
	
	private weak var view: AddUserDataTableViewDelegate?
	let storage = Storage.storage()
	
	var ref: DatabaseReference?
	var currentUser: User?
	var familyRole: FamilyRoleRow? //{ didSet { view?.reloadData() }}
	var avatarURL: String?
	
	init(view: AddUserDataTableViewDelegate, user: User?) {
		self.view = view
		self.currentUser = user
	}
	
	func uploadAvatarImage(image: UIImage?) {
		view?.spinnerStartAnimate()
		guard let image = image, let userID = Auth.auth().currentUser?.uid else { updateUserDataIfNeeded(); return }
		let storageRef = storage.reference().child("images")

		let data = image.pngData()!
		// Create a reference to the file you want to upload
		let riversRef = storageRef.child("\(userID).jpg")

		// Upload the file to the path "images/rivers.jpg"
		let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
			guard let metadata = metadata else {
				// Uh-oh, an error occurred!
				return
			}
			// Metadata contains file metadata such as size, content-type.
//			let size = metadata.size
			// You can also access to download URL after upload.
			riversRef.downloadURL { (url, error) in
				guard let downloadURL = url else { return }
				self.avatarURL = downloadURL.absoluteString
				self.updateUserDataIfNeeded()
			}
		}
	}
	
	func updateUserDataIfNeeded() {
		
		let name = view?.userNameDidRequest()
		guard let userID = Auth.auth().currentUser?.uid else { return }
		ref = Database.database().reference().child("users").child(userID)
		var post = [AnyHashable : Any]()
		if avatarURL != nil {
		post = ["name": name as Any,
						"avatarURL": avatarURL as Any,
								] as [AnyHashable : Any]
		} else {
			post = ["name": name as Any
					] as [AnyHashable : Any]
		}
			ref?.updateChildValues(post)
		view?.spinnerStopAnimate()
		view?.popViewController()
	}
}

// MARK: - CreateUserProfileTablePresenterDelegate
extension AddUserDataTablePresenter: AddUserDataTablePresenterDelegate {
	
	func logOutRequest() {
		print("LOG OUT")
	}
	
	
}
