//
//  TaskRewardTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class TaskRewardTableViewCell: UITableViewCell {
	
	let rewardTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.attributedPlaceholder = NSAttributedString(string: "Enter reward amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
		textField.textColor = .lightGray
		textField.keyboardType = .numberPad
		
		return textField
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .darkGray
		addSubview(rewardTextField)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			rewardTextField.topAnchor.constraint(equalTo: topAnchor),
			rewardTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
			rewardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			rewardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
	}
	
	func requestUpdatedReward() -> String? {
		if rewardTextField.text == "0" || rewardTextField.text == nil {
			shake()
			return nil
		}
		return rewardTextField.text
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
