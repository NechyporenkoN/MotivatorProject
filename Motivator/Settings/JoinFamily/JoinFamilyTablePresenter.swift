//
//  JoinFamilyTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 03.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Firebase

final class JoinFamilyTablePresenter {
	
	private weak var view: JoinFamilyTableViewDelegate?
	
	private var family: Family?
	var currentUser: User?
	
	
	init(view: JoinFamilyTableViewDelegate, currentUser: User?) {
		self.view = view
		self.currentUser = currentUser
	}
	
	private	func updateUserFamily(familyID: String?, rights: Rights) {
		guard let userID = currentUser?.userID, let familyID = familyID else { return }
		let ref = Database.database().reference().child("users").child(userID)
		var post = [AnyHashable : Any]()
		post = ["familyID": familyID as Any, "rights": rights.rawValue as Any] as [AnyHashable : Any]
		ref.updateChildValues(post, withCompletionBlock: { [weak self] (error, reference) in
			if error == nil {
				self?.view?.popToViewController()
			}
		})
	}
	
	func joinToFamily(familyID: String?, rights: Rights) {
		guard let familyID = familyID else { return }
	
		let ref = Database.database().reference()
		ref.observe(DataEventType.value, with: { [weak self] (families) in
			
			let familiesDict = families.value as? [String : AnyObject] ?? [:]
			let familiesData = familiesDict["families"] as? [String : AnyObject] ?? [:]
			let familyById = familiesData["\(familyID)"] as? [String : AnyObject] ?? [:]
			let family = Family(name: familyById["name"] as? String,
													ownerID: familyById["ownerID"] as? String,
													familyID: familyById["familyID"] as? String ?? "",
													members: familyById["members"] as? [String],
													avaterURL: familyById["avatarURL"] as? String,
													logoURL: familyById["logoURL"] as? String)
			self?.family = family
			self?.updateUserFamily(familyID: family.familyID, rights: rights)
		})
	}
}

// MARK: - JoinFamilyTablePresenterDelegate
extension JoinFamilyTablePresenter: JoinFamilyTablePresenterDelegate {
	
}
