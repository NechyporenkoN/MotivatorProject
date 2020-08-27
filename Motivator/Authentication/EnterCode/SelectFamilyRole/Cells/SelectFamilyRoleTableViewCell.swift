//
//  SelectFamilyRoleTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/28/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SelectFamilyRoleTableViewCell: UITableViewCell {
	
	private let roleTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
//	var isSelectedRole = false
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	private func configureView() {
		contentView.addSubview(roleTitleLabel)
		selectionStyle = .none
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			roleTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			roleTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			roleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			roleTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
	}
	
	func configure(role: FamilyRoleRow) {
		roleTitleLabel.text = role.rawValue
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
//		isSelectedRole = false
		accessoryType = .none
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
