//
//  SelectPerformerTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import Firebase

final class SelectPerformerTablePresenter {
	
	private weak var view: SelectPerformerTableViewDelegate?
	
	var ref: DatabaseReference!
	var family: Family?
	var dataSource = [User]()
	var currentUser: User?
	
	init(view: SelectPerformerTableViewDelegate, currentUser: User?) {
		self.view = view
		self.currentUser = currentUser
		configureObserve()
	}
	
	private func configureDataSource() {
		
		guard let members = family?.members else { return }
		dataSource = []
		for member in members {
			ref.child("users").child(member).observeSingleEvent(of: .value, with: { [weak self] (user) in
				let value = user.value as? NSDictionary
				let name = value?["name"] as? String
				let userID = value?["userID"] as? String
				let role = value?["role"] as? String ?? ""
				let avatar = value?["avatarURL"] as? String
				let familyID = value?["familyID"] as? String
				let rights = value?["rights"] as? String
				let user = User(name: name, userID: userID, role: role, avatar: avatar, familyID: familyID, rights: rights, tasks: nil)
				dump(user)
				if user.userID != self?.currentUser?.userID {
				self?.dataSource.append(user)
				self?.view?.tableViewReloadData()
				}
				print(self?.dataSource.count)
			}) { (error) in
				print(error.localizedDescription)
			}
		}
		
	}
	
	private func configureObserve() {
		
		guard let currentUser = view?.previousController?.presenter?.currentUser else { return }

		ref = Database.database().reference()
		ref.observe(DataEventType.value, with: { [weak self] (families) in
			let familiesDict = families.value as? [String : AnyObject] ?? [:]
			if let familyID = currentUser.familyID {
				let familiesData = familiesDict["families"] as? [String : AnyObject] ?? [:]
				let familyById = familiesData["\(familyID)"] as? [String : AnyObject] ?? [:]
				let family = Family(name: familyById["name"] as? String,
														ownerID: familyById["ownerID"] as? String,
														familyID: familyById["familyID"] as? String ?? "",
														members: familyById["members"] as? [String],
														avaterURL: familyById["avatarURL"] as? String,
														logoURL: familyById["logoURL"] as? String)
				self?.family = family
				
			}
			self?.configureDataSource()
		})
	}
}

// MARK: - SelectPerformerTablePresenterDelegate
extension SelectPerformerTablePresenter: SelectPerformerTablePresenterDelegate {
	
}
