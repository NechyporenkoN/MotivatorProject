//
//  PrizesPresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
//import TopTalkCore

final class PrizesPresenter {

	private weak var view: PrizesViewDelegate?

	// private var authCoreSerivce: AuthCoreService?

	init(view: PrizesViewDelegate) {
		self.view = view
		configureCoreSerivces()
	}
	private func configureCoreSerivces() {
		//	authCoreSerivce = AuthCoreServices()
	}
}

// MARK: - PrizesPresenterDelegate
extension PrizesPresenter: PrizesPresenterDelegate {

}
