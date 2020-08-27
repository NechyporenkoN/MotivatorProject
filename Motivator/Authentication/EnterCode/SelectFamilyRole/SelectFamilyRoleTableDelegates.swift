//
//  SelectFamilyRoleTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/28/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol SelectFamilyRoleTablePresenterDelegate: class {

	var familyRole: FamilyRoleRow? { get set }
	var dataSource: [FamilyRoleSection] { get }
	func createUsers()
}

protocol SelectFamilyRoleTableViewDelegate: class {

	func setAndShowGeneralController()
	func spinnerStartAnimate()
	func spinnerStopAnimate()
	func popToViewController()
}
