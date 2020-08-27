//
//  TaskNameTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class TaskNameTableViewCell: UITableViewCell {
	
	let taskNameTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.attributedPlaceholder = NSAttributedString(string: "Enter name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
		textField.textColor = .lightGray
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
		addSubview(taskNameTextField)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			taskNameTextField.topAnchor.constraint(equalTo: topAnchor),
			taskNameTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
			taskNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			taskNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
	}
	
	func requestUpdatedName() -> String? {
		if taskNameTextField.text == "" || taskNameTextField.text == nil || taskNameTextField.text?.count ?? 0 < 1 {
			shake()
			return nil
		}
		return taskNameTextField.text
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
