//
//  JoinFamilyTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 03.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol JoinFamilyTablePresenterDelegate: class {

	var currentUser: User? { get }
	func joinToFamily(familyID: String?, rights: Rights)
}

protocol JoinFamilyTableViewDelegate: class {

	func showFamilyViewController()
	func popToViewController() 
}
