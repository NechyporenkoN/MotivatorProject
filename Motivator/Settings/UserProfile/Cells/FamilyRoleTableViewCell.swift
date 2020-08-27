//
//  FamilyRoleTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/27/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class FamilyRoleTableViewCell: UITableViewCell {

	private let roleTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Your family role"
		return label
	}()
	
	private let selectedRoleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.textColor = .gray
		
		return label
	}()
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [roleTitleLabel, selectedRoleLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillEqually
		stack.axis = .horizontal
		
		return stack
	}()
	
	
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			
			configureView()
			setConstraints()
		}
	
	private func configureView() {
		accessoryType = .disclosureIndicator
		selectionStyle = .none
		contentView.addSubview(stackView)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
	}
	
	func configure(role: FamilyRoleRow?) {
		guard let role = role else { return }
		selectedRoleLabel.text = role.rawValue
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
