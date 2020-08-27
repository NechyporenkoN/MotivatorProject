//
//  SelectPerformerTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol SelectPerformerTablePresenterDelegate: class {

	var dataSource: [User] { get }
}

protocol SelectPerformerTableViewDelegate: class {

	var previousController: CreateNewTaskTableViewController? { get }
	func tableViewReloadData()
}
