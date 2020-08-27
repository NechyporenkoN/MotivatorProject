//
//  TaskPerformerTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class TaskPerformerTableViewCell: UITableViewCell {
	
	private let labelStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 5
		stack.alignment = .center
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		return stack
	}()
	
	let performerTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Select performer"
		return label
	}()
	
	let performerLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = .lightGray
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .right
		
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupViews()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		
		labelStackView.addArrangedSubview(performerTitleLabel)
		labelStackView.addArrangedSubview(performerLabel)
		addSubview(labelStackView)
		backgroundColor = .darkGray
		tintColor = .lightGray
		selectionStyle = .none
		let chevronImageView = UIImageView(image: UIImage(named: "Arrow"))
		accessoryView = chevronImageView
	}
	
	private func setupConstraints() {
		
		NSLayoutConstraint.activate([
			labelStackView.topAnchor.constraint(equalTo: topAnchor),
			labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
		])
	}
	
	func configure(user: User?) {
		guard let user = user else { return }
		performerLabel.text = user.name
	}
}
