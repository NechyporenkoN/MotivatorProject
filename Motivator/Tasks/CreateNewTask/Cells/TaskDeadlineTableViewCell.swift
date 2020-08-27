//
//  TaskDeadlineTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class TaskDeadlineTableViewCell: UITableViewCell {
	
	private let deadlineLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .gray
		label.text = "Deadline"
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	func configure(date: String?) {
		if date != nil {
			deadlineLabel.text = date
			deadlineLabel.textColor = .lightGray
		} else {
			deadlineLabel.text = "Enter deadline"
			deadlineLabel.textColor = .gray
		}
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .darkGray
		addSubview(deadlineLabel)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			deadlineLabel.topAnchor.constraint(equalTo: topAnchor),
			deadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			deadlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			deadlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
