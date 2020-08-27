//
//  ProgressPresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
//import TopTalkCore

final class ProgressPresenter {

	private weak var view: ProgressViewDelegate?

	// private var authCoreSerivce: AuthCoreService?

	init(view: ProgressViewDelegate) {
		self.view = view
		configureCoreSerivces()
	}
	private func configureCoreSerivces() {
		//	authCoreSerivce = AuthCoreServices()
	}
}

// MARK: - ProgressPresenterDelegate
extension ProgressPresenter: ProgressPresenterDelegate {

}
