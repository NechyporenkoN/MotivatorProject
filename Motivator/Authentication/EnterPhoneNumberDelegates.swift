//
//  EnterPhoneNumberTableDelegates.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/21/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol EnterPhoneNumberPresenterDelegate: class {

//	var verificationID: String? { get }
	func sendPhoneNumber(phoneNumber: String, with completion: EnterPhoneNumberPresenter.FireabaseAuthCompletion)
}

protocol EnterPhoneNumberViewDelegate: class {

}
