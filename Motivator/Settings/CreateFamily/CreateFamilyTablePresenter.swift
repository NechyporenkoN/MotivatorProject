//
//  CreateFamilyTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import Firebase

final class CreateFamilyTablePresenter {
	
	private weak var view: CreateFamilyTableViewDelegate?
	private let storage = Storage.storage()
	var userID = Auth.auth().currentUser?.uid
	private var avatarStringURL: String?
	var currentUser: User?
	
	init(view: CreateFamilyTableViewDelegate, currentUser: User?) {
		self.view = view
		self.currentUser = currentUser
	}
	
	func uploadAvatarImage(image: UIImage?) {
				view?.spinnerStartAnimate()
		guard let image = image, let userID = userID else {
			createFamily()
			return
		}
		let storageRef = storage.reference().child("images").child("families")
		
		let data = image.pngData()!
		let imagesRef = storageRef.child("\(userID).jpg")
		
		_ = imagesRef.putData(data, metadata: nil) { [weak self] (_,_) in
			imagesRef.downloadURL { (url, error) in
				guard let downloadURL = url else { return }
				self?.avatarStringURL = downloadURL.absoluteString
				self?.createFamily()
			}
		}
	}
	
	private func createFamily() {
		
		guard let familyName = view?.fmilyNameDidRequest(), let userID = userID else {
			view?.spinnerStopAnimate()
			return
		}
		
		let ref = Database.database().reference().child("families").child(userID)
		var post = [AnyHashable : Any]()
		if avatarStringURL != nil {
			post = ["name": familyName as Any,
							"avatarURL": avatarStringURL as Any,
				] as [AnyHashable : Any]
		} else {
			post = ["name": familyName as Any
				] as [AnyHashable : Any]
		}
		ref.updateChildValues(post)
		addFamilyToUser()
		view?.spinnerStopAnimate()
		view?.popViewController()
//		view?.showAlert()
	}
	
	private func addFamilyToUser() {
		guard let userID = userID else { return }
		let ref = Database.database().reference().child("users").child(userID)
		var post = [AnyHashable : Any]()
		post = ["familyID": userID as Any] as [AnyHashable : Any]
		ref.updateChildValues(post)
	}
	
}

// MARK: - CreateFamilyTablePresenterDelegate
extension CreateFamilyTablePresenter: CreateFamilyTablePresenterDelegate {
	
}
