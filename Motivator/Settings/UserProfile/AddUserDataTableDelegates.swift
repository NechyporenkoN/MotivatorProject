//
//  CreateUserProfileTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/27/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol AddUserDataTablePresenterDelegate: class {
	
	var familyRole: FamilyRoleRow? { get set }
	var currentUser: User? { get }
	
	func uploadAvatarImage(image: UIImage?)
	func updateUserDataIfNeeded()
	func logOutRequest()
}

protocol AddUserDataTableViewDelegate: class {
	
	var avatarImage: UIImage? { get }
//	func reloadData()
	func popViewController()
	func userNameDidRequest() -> String?
	func spinnerStartAnimate()
	func spinnerStopAnimate()
}
