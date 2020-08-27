//
//  SelectFamilyRoleTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/28/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

enum FamilyRoleSection {
	case parents(rows: [FamilyRoleRow])
	case childs(rows: [FamilyRoleRow])
	var rows: [FamilyRoleRow] {
		switch self {
		case .parents(let rows), .childs(let rows):
			return rows
		}
	}
}

enum FamilyRoleRow: String {
	case father = "Father"
	case mother = "Mother"
	//	case other = "Other"
	case son = "Son"
	case daughter = "Daughter"
}

final class SelectFamilyRoleTablePresenter {
	
	private weak var view: SelectFamilyRoleTableViewDelegate?
	var ref: DatabaseReference?
	var familyRole: FamilyRoleRow?
	var familyRights: Rights?
	var authType: AuthType?
	var dataSource = [FamilyRoleSection]()
	
	init(view: SelectFamilyRoleTableViewDelegate, familyRights: Rights?, authType: AuthType?) {
		self.view = view
		self.familyRights = familyRights
		self.authType = authType
		
		configureDataSource()
	}
	
	private func configureDataSource() {
		if authType == .registration {
			dataSource = [
				FamilyRoleSection.parents(rows: [.father, .mother]),
				FamilyRoleSection.childs(rows: [.son, .daughter])
			]
		}
		else if authType == .addPerson {
			if familyRights == .parent {
				dataSource = [
					FamilyRoleSection.parents(rows: [.father, .mother])
				]
			}
			else if familyRights == .child {
				dataSource = [
					FamilyRoleSection.childs(rows: [.son, .daughter])
				]
			}
		}
	}
	
	private func roleMaker() -> String {
		guard let familyRole = familyRole else { return ""}
		switch familyRole {
		case .father:
			return FamilyRole.dad.rawValue
		case .mother:
			return FamilyRole.mom.rawValue
		case .son:
			return FamilyRole.son.rawValue
		case .daughter:
			return FamilyRole.daughter.rawValue
		}
	}
	
	
	func createUsers() {
		
		view?.spinnerStartAnimate()
		//		ref = Database.database().reference()
		
		guard let userID = Auth.auth().currentUser?.uid else { view?.spinnerStopAnimate(); return }
		
		if authType == .registration {
			//			if ref?.child("users").child(userID) == userID {
			//
			//			}
			guard let userID = Auth.auth().currentUser?.uid else { return }
			ref = Database.database().reference().child("users").child(userID)
			var post = [AnyHashable : Any]()
			
			post = ["role": roleMaker() as Any,
							"userID": userID as Any,
				] as [AnyHashable : Any]
			
			ref?.updateChildValues(post)
			view?.setAndShowGeneralController()
			view?.spinnerStopAnimate()
			//			ref?.child("users").child(userID).setValue(["role": roleMaker(), "userID": userID]) { [weak self] (error: Error?, ref: DatabaseReference) in
			//				if let error = error {
			//					print("Data could not be saved: \(error).")
			//				} else {
			//					print("Data saved successfully!")
			//					self?.view?.setAndShowGeneralController()
			//					self?.view?.spinnerStopAnimate()
			//				}
			//			}
		}
		else if authType == .addPerson {
			
			guard let userID = Auth.auth().currentUser?.uid else { return }
			
			ref = Database.database().reference().child("users").child(userID)
			var post = [AnyHashable : Any]()
			post = ["role": roleMaker() as Any,
							"userID": userID as Any,
							"familyID": userID as Any
				] as [AnyHashable : Any]
			
			ref?.updateChildValues(post)
			
			ref = Database.database().reference().child("families").child(userID)
			
			post = [AnyHashable : Any]()
			post = ["ownerID": userID as Any,
							"familyID": userID as Any,
							"members": ["userID", userID]
				] as [AnyHashable : Any]
			
			ref?.updateChildValues(post)
			
			view?.spinnerStopAnimate()
			
			view?.popToViewController()
			//			ref?.child("families").child(userID).setValue(["name": "Nechyporenko", "ownerID": userID, "members": "userID"]) { [weak self] (error: Error?, ref: DatabaseReference) in
			//				if let error = error {
			//					print("Data could not be saved: \(error).")
			//				} else {
			//					print("Data saved successfully!")
			//					self?.view?.spinnerStopAnimate()
			//					self?.view?.popToViewController()
			//				}
			//			}
		}
	}
}

// MARK: - SelectFamilyRoleTablePresenterDelegate
extension SelectFamilyRoleTablePresenter: SelectFamilyRoleTablePresenterDelegate {
	
}
