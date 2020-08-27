//
//  CreateNewTaskDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol CreateNewTaskPresenterDelegate: class {

	var dataSource: [NewTaskCellType] { get }
	var currentUser: User? { get }
	func createNewTask()
}

protocol CreateNewTaskViewDelegate: class {

	var deadline: String? { get }
	var priority: PriorityType? { get }
	var selectedUser: User? { get }
	func taskNameDidRequest() -> String?
	func descriptionDidRequest() -> String?
	func rewardDidRequest() -> String?
	func popToViewController()
}
