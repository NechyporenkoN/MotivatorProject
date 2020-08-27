//
//  EnterCodePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/22/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

final class EnterCodePresenter {
	
	private weak var view: EnterCodeViewDelegate?
	var ref: DatabaseReference!
	var currentUser: User?
	var verificationID: String?
	var phoneNumber: String?
	var verificationCode = ""
	var authType: AuthType?
	var familyRights: Rights?
	
	init(view: EnterCodeViewDelegate, phoneNumber: String?, verificationID: String?, authType: AuthType?, familyRights: Rights?) {
		self.view = view
		self.authType = authType
		self.phoneNumber = phoneNumber
		self.verificationID = verificationID
		self.familyRights = familyRights
		configureCoreSerivces()
	}
	
	private func configureObserve(_ block: (() -> Void)?) {
		ref = Database.database().reference()
		ref.observe(DataEventType.value, with: { [weak self] (users) in
			let usersDict = users.value as? [String : AnyObject] ?? [:]
			if let userID = Auth.auth().currentUser?.uid {
				let usersData = usersDict["users"] as? [String : AnyObject] ?? [:]
				let userById = usersData["\(userID)"] as? [String : AnyObject] ?? [:]
				let user = User(name: userById["name"] as? String, userID: userById["userID"] as? String, role: userById["role"] as? String ?? "", avatar: userById["avatarURL"] as? String, familyID: userById["familyID"] as? String, rights: userById["rights"] as? String, tasks: nil)
				self?.currentUser = user
			}
			block?()
		})
	}
	
	private func configureCoreSerivces() {
		//	authCoreSerivce = AuthCoreServices()
	}
}

// MARK: - EnterCodePresenterDelegate
extension EnterCodePresenter: EnterCodePresenterDelegate {
	
	func checkPhoneCode() {
		
		guard let verificationID = verificationID, verificationCode.count == 6 else { return }
		
		let credential = PhoneAuthProvider.provider().credential(
			withVerificationID: verificationID,
			verificationCode: verificationCode)
		Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
			print(authResult?.user.displayName)
			if let error = error {
				self?.view?.showAlert(message: error.localizedDescription)
				return
			}
				//			else if authResult?.user.displayName == nil {
				//				self?.view?.showAlert(message: "no name")
				//				return
				//			}
			else {
					self?.configureObserve( { [weak self] in
						if self?.currentUser?.userID == Auth.auth().currentUser?.uid {
							self?.view?.setAndShowGeneralController()
						} else {
							self?.view?.showSelectFamilyRoleController(familyRights: self?.familyRights, authType: self?.authType)
						}
					})
//				else if self?.authType == .addPerson {
//					self?.view?.showSelectFamilyRoleForAddPerson(familyRights: self?.familyRights, authType: self?.authType)
//			}
		}
		//		}
		//		else if authType == .addPerson {
		//
		//			Auth.auth().checkActionCode(verificationCode) { [weak self] (actionCodeInfo, error) in
		//				if let error = error {
		//					self?.view?.showAlert(message: error.localizedDescription)
		//					return
		//				} else {
		//					print(actionCodeInfo)
		//					dump(actionCodeInfo)
		//					self?.view?.showSelectFamilyRoleForAddPerson(familyRights: self?.familyRights, authType: self?.authType)
		//				}
		//			}
				}
	}
}

