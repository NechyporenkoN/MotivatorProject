//
//  EnterCodeDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/22/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol EnterCodePresenterDelegate: class {

	var verificationCode: String { get set }
	var phoneNumber: String? { get }
	func checkPhoneCode()
}

protocol EnterCodeViewDelegate: class {

	func showAlert(message: String?)
//	func showGeneralController()
	func showSelectFamilyRoleController(familyRights: Rights?, authType: AuthType?)
	func showSelectFamilyRoleForAddPerson(familyRights: Rights?, authType: AuthType?)
//	func popToViewController()
	func setAndShowGeneralController()
}
