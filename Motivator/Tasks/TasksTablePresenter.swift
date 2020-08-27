//
//  TasksTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

final class TasksTablePresenter {
	
	private weak var view: TasksTableViewDelegate?
	var currentUser: User?
	var tasksList: [String] = []
	var dataSource: [Task] = []
	
	init(view: TasksTableViewDelegate) {
		self.view = view
		configureObserve()
	}
	
	private func configureDataSource() {
		
		dataSource.removeAll()
		let ref = Database.database().reference()
		for taskID in tasksList {
			ref.child("tasks").child(taskID).observeSingleEvent(of: .value, with: { [weak self] (task) in
				guard let self = self else { return }
				print("xxx task", task.key)
				let value = task.value as? NSDictionary
				let taskID = value?["taskID"] as? String
				let taskName = value?["taskName"] as? String
				let taskBody = value?["taskBody"] as? String
				let comment = value?["comment"] as? String
				let price = value?["price"] as? String
				let deadline = value?["deadline"] as? String
				let status = value?["status"] as? String
				let imageURL = value?["imageURL"] as? String
				let createdAt = value?["createdAt"] as? Int
				let performerID = value?["performerID"] as? String
				let priority = value?["priority"] as? String
				let ownerID = value?["ownerID"] as? String
				let performerAvatar = value?["performerAvatar"] as? String
				let performerName = value?["performerName"] as? String
				let ownerAvatar = value?["ownerAvatar"] as? String
				let ownerName = value?["ownerName"] as? String
				let task = Task(taskID: taskID, taskName: taskName, taskBody: taskBody, comment: comment, price: price, deadline: deadline, status: status, imageURL: imageURL, createdAt: createdAt, performerID: performerID, priority: priority, ownerID: ownerID, performerAvatar: performerAvatar, performerName: performerName, ownerAvatar: ownerAvatar, ownerName: ownerName)
				
				if !self.dataSource.contains(where: { $0.taskID == task.taskID}) {
					self.dataSource.append(task)
					self.view?.tableViewReloadData()
				}
			}) { (error) in
				print(error.localizedDescription)
			}
		}
		
	}
	
	private func configureObserve() {
		
		let ref = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
		ref.observe(DataEventType.value, with: { [weak self] (user) in
			self?.tasksList = []
			let userData = user.value as? [String : AnyObject] ?? [:]
			let user = User(name: userData["name"] as? String, userID: userData["userID"] as? String, role: userData["role"] as? String ?? "", avatar: userData["avatarURL"] as? String, familyID: userData["familyID"] as? String, rights: userData["rights"] as? String, tasks: nil)
			self?.currentUser = user
			
			let tasksList = userData["tasks"] as? [String : AnyObject] ?? [:]
			print(tasksList)
			for task in tasksList {
				print(task.key)
				self?.tasksList.append(task.key)
			}
			self?.view?.configureAddTaskButton()
			self?.configureDataSource()
		})
	}
	
	
}

// MARK: - TasksPresenterDelegate
extension TasksTablePresenter: TasksTablePresenterDelegate {
	
}
