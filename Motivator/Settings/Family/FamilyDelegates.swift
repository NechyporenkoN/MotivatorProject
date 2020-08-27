//
//  FamilyDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 20.12.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol FamilyTablePresenterDelegate: class {

	var dataSource: [FamilySection] { get }
	var parentsDataSource: [User] { get }
	var childrenDataSource: [User] { get }
	var currentUser: User? { get }
	var family: Family? { get }
	func deleteUserFromFamily(user: User?)
	func configureDataSourceIfEditing(isEditing: Bool)
}

protocol FamilyTableViewDelegate: class {

	func tableViewReloadData()
	func setBarButton()
}
