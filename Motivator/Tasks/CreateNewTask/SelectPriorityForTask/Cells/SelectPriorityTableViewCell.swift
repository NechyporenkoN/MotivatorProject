//
//  SelectPriorityTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SelectPriorityTableViewCell: UITableViewCell {
	
	private let priorityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .lightGray
		label.text = "Deadline"
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	func configure(priority: PriorityType?) {
		guard let priority = priority else { return }
		priorityLabel.text = priority.rawValue
	}
	
	private func configureView() {
//		accessoryType = .disclosureIndicator
		selectionStyle = .none
		backgroundColor = .darkGray
		addSubview(priorityLabel)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			priorityLabel.topAnchor.constraint(equalTo: topAnchor),
			priorityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			priorityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			priorityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
