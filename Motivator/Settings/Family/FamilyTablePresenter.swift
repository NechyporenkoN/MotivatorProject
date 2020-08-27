//
//  FamilyTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 20.12.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

enum FamilySection {
	case avatar
	case parents
	case childs
}

final class FamilyTablePresenter {
	
	private weak var view: FamilyTableViewDelegate?
	
	var dataSource: [FamilySection] = []
	var parentsDataSource: [User] = []
	var childrenDataSource: [User] = []
	var currentUser: User?
	var family: Family?
	var ref: DatabaseReference!
	
	init(view: FamilyTableViewDelegate, currentUser: User?) {
		self.view = view
		self.currentUser = currentUser
		
		configureObserve()		
	}
	
	private func configureDataSource() {
		dataSource = [.avatar, .parents, .childs]
		
		guard let members = family?.members else { return }
		
		parentsDataSource = []
		childrenDataSource = []
		let ref = Database.database().reference().child("users")
		for member in members {
			ref.child(member).observeSingleEvent(of: .value, with: { [weak self] (user) in
				let value = user.value as? NSDictionary
				let name = value?["name"] as? String
				let userID = value?["userID"] as? String
				let role = value?["role"] as? String ?? ""
				let avatar = value?["avatarURL"] as? String
				let familyID = value?["familyID"] as? String
				let rights = value?["rights"] as? String
				let user = User(name: name, userID: userID, role: role, avatar: avatar, familyID: familyID, rights: rights, tasks: nil)
				if rights == "parent" {
					self?.parentsDataSource.append(user)
				} else if rights == "child" {
					self?.childrenDataSource.append(user)
				}
				self?.view?.tableViewReloadData()
			}) { (error) in
				print(error.localizedDescription)
			}
		}
	}
	
	private func configureObserve() {
		guard let familyID = currentUser?.familyID else  { return }
		let ref = Database.database().reference().child("families").child(familyID)
		ref.observe(DataEventType.value, with: { [weak self] (family) in
			let familyData = family.value as? [String : AnyObject] ?? [:]
			let family = Family(name: familyData["name"] as? String,
													ownerID: familyData["ownerID"] as? String,
													familyID: familyData["familyID"] as? String ?? "",
													members: familyData["members"] as? [String],
													avaterURL: familyData["avatarURL"] as? String,
													logoURL: familyData["logoURL"] as? String)
			self?.family = family
			if family.familyID == self?.currentUser?.userID {
				self?.view?.setBarButton()
			}
			self?.configureDataSource()
		})
	}
}

// MARK: - FamilyTablePresenterDelegate
extension FamilyTablePresenter: FamilyTablePresenterDelegate {
	
	func deleteUserFromFamily(user: User?) {
		guard let familyID = currentUser?.familyID else  { return }
		let ref = Database.database().reference().child("families").child(familyID)
		var post = [AnyHashable : Any]()
		if let userID = user?.userID, let members = family?.members {
			var newMembers: [String] = []
			for member in members {
				if member != userID {
					newMembers.append(member)
				}
			}
			post = ["members": newMembers as Any,
				] as [AnyHashable : Any]
		}
		ref.updateChildValues(post)
		view?.tableViewReloadData()
	}
	
	func configureDataSourceIfEditing(isEditing: Bool) {
		if isEditing {
			if parentsDataSource.last?.userID != nil {
				let user = User(name: nil, userID: nil, role: "", avatar: nil, familyID: nil, rights: Rights.parent.rawValue, tasks: nil)
				parentsDataSource.insert(user, at: 0)//append(user)
			}
			if childrenDataSource.last?.userID != nil {
				let user = User(name: nil, userID: nil, role: "", avatar: nil, familyID: nil, rights: Rights.child.rawValue, tasks: nil)
				childrenDataSource.insert(user, at: 0)//append(user)
			}
		} else {
			if parentsDataSource.last?.userID == nil {
				parentsDataSource.remove(at: 0)
			}
			if childrenDataSource.last?.userID == nil {
				childrenDataSource.remove(at: 0)
			}
			
		}
	}
}
