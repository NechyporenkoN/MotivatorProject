//
//  CreateFamilyTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol CreateFamilyTablePresenterDelegate: class {

	var userID: String? { get }
	var currentUser: User? { get }
	func uploadAvatarImage(image: UIImage?)
}

protocol CreateFamilyTableViewDelegate: class {

	var avatar: UIImage? { get }
	func fmilyNameDidRequest() -> String?
	func popViewController()
	func spinnerStartAnimate()
	func spinnerStopAnimate()
}
