//
//  TasksTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol TasksTablePresenterDelegate: class {

	var dataSource: [Task] { get }
	var currentUser: User? { get }
}

protocol TasksTableViewDelegate: class {

	func tableViewReloadData()
	func configureAddTaskButton()
}
