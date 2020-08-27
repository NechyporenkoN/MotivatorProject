//
//  User.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

enum Rights: String {
	case parent = "parent"
	case child = "child"
}

enum FamilyRole: String {
	case dad = "dad"
	case mom = "mom"
	case son = "son"
	case daughter = "daughter"
}

final class User {
	var name: String?
	var userID: String?
	var role: String?
	var avatar: String?
	var familyID: String?
	var rights: String?
	var tasks: [String]?
	
	convenience init(name: String?, userID: String?, role: String, avatar: String?, familyID: String?, rights: String?, tasks: [String]?) {
		self.init()
		self.name = name
		self.userID = userID
		self.role = role
		self.avatar = avatar
		self.familyID = familyID
		self.rights = rights
		self.tasks = tasks
	}
}
