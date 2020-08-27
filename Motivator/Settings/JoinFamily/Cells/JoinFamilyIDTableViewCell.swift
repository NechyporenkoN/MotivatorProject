//
//  JoinFamilyIDTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 03.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class JoinFamilyIDTableViewCell: UITableViewCell {

	 let titleFamilyID: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.text = "Plase enter family ID"
		label.textColor = .lightGray
		return label
	}()

	 let familyIDTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.textAlignment = .center
//		textField.placeholder = "family ID"
		textField.attributedPlaceholder = NSAttributedString(string: "family ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
		textField.textColor = .lightGray
		return textField
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			
			configureView()
			setConstraints()
		}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func familyIDRequest() -> String? {
		if familyIDTextField.text?.count ?? 0 < 10 {
			shake()
			return nil
		}
		return familyIDTextField.text
	}
	
	private func configureView() {

		backgroundColor = .darkGray
		selectionStyle = .none
		contentView.addSubview(titleFamilyID)
		contentView.addSubview(familyIDTextField)
		
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			titleFamilyID.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleFamilyID.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleFamilyID.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleFamilyID.bottomAnchor.constraint(equalTo: familyIDTextField.topAnchor),
			
			familyIDTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			familyIDTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			familyIDTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			familyIDTextField.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
