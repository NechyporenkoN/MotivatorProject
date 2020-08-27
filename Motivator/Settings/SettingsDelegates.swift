//
//  SettingsDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol SettingsPresenterDelegate: class {

	var currentUser: User? { get }
	var dataSource: [[SectionType]] { get }
}

protocol SettingsViewDelegate: class {

	func tableViewReloadData()
}
