//
//  CreateNewTaskPresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import Firebase

enum NewTaskCellType: String {
	case taskName = "Task name"
	case description = "Description"
	case deadline = "Deadline"
	case priority = "Priority"
	case reward = "Reward"
	case performer = "Performer"
}

final class CreateNewTaskPresenter {
	
	private weak var view: CreateNewTaskViewDelegate?
	var currentUser: User?
	var ref: DatabaseReference?
	var dataSource: [NewTaskCellType] = [.taskName, .description, .deadline, .reward, .priority, .performer]
//	var timeStamp = Date().toMilliseconds()
	
	init(view: CreateNewTaskViewDelegate, currentUser: User?) {
		self.view = view
		self.currentUser = currentUser
		//		print(currentUser)
		
	}
	
	func createNewTask() {
		
		
		guard let taskName = view?.taskNameDidRequest(),
			let reward =  view?.rewardDidRequest(),
			let performer = view?.selectedUser,
			let priority = view?.priority?.rawValue
			else { return }
		
		ref = Database.database().reference().child("tasks").childByAutoId()
		
		guard let taskID = ref?.key else { return }
		
		let description = view?.descriptionDidRequest()
		let deadline = view?.deadline
		let	timeStamp = Int(Date().timeIntervalSince1970)
		
		var post = [AnyHashable : Any]()
		
		post = ["taskID": taskID as Any,
						"taskName": taskName as Any,
						"taskBody":  description as Any,
						"price": reward as Any,
						"deadline": deadline as Any,
						"createdAt": timeStamp as Any,
						"performerID": performer.userID as Any,
						"priority": priority as Any,
						"status": StatusTask.active.rawValue as Any,
						"performerAvatar": performer.avatar as Any,
						"performerName": performer.name as Any,
						"ownerAvatar": currentUser?.avatar as Any,
						"ownerName": currentUser?.name as Any,
			] as [AnyHashable : Any]
		ref?.updateChildValues(post)
		addTasktoUser(userID : performer.userID, taskID: taskID)
		addTasktoUser(userID : currentUser?.userID, taskID: taskID)
		view?.popToViewController()
	}
	
	private func addTasktoUser(userID : String?, taskID: String?) {
		guard let userID = userID, let taskID = taskID else { return }
		ref = Database.database().reference().child("users").child(userID).child("tasks")
		var post = [AnyHashable : Any]()
		post = [taskID: "1" as Any] as [AnyHashable : Any]
		ref?.updateChildValues(post)
	}
}

// MARK: - CreateNewTaskPresenterDelegate
extension CreateNewTaskPresenter: CreateNewTaskPresenterDelegate {
	
}
