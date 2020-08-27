//
//  SelectPriorityForTaskTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

enum PriorityType: String {
	case high = "high"
	case medium = "medium"
	case low = "low"
}

final class SelectPriorityForTaskTablePresenter {

	private weak var view: SelectPriorityForTaskTableViewDelegate?
	var priorityTitles = [PriorityType.high, PriorityType.medium, PriorityType.low]

	init(view: SelectPriorityForTaskTableViewDelegate) {
		self.view = view
	}
	
}

// MARK: - SelectPriorityForTaskTablePresenterDelegate
extension SelectPriorityForTaskTablePresenter: SelectPriorityForTaskTablePresenterDelegate {

}
