//
//  EnterPhoneNumberTablePresenter.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/21/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import FirebaseAuth

final class EnterPhoneNumberPresenter {
	
	public typealias FireabaseAuthCompletion = ((_ status: Bool, _ message: String?, _ verificationID: String?) -> Void)?
	private weak var view: EnterPhoneNumberViewDelegate?
//	var verificationID: String?

	
	init(view: EnterPhoneNumberViewDelegate) {
		self.view = view
		configureCoreSerivces()
	}
	private func configureCoreSerivces() {
		//	authCoreSerivce = AuthCoreServices()
	}
}



// MARK: - EnterPhoneNumberTablePresenterDelegate
extension EnterPhoneNumberPresenter: EnterPhoneNumberPresenterDelegate {
	
	func sendPhoneNumber(phoneNumber: String, with completion: FireabaseAuthCompletion) {
		
		PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
			if let error = error {
				completion?(false, error.localizedDescription, nil)
				return
			}
//			self.verificationID = verificationID
//			UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
			completion?(true, nil, verificationID)
		}
	}
}
