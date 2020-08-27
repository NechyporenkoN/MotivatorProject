//
//  SelectPriorityForTaskTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol SelectPriorityForTaskTablePresenterDelegate: class {

	var priorityTitles: [PriorityType] { get }
}

protocol SelectPriorityForTaskTableViewDelegate: class {

}
