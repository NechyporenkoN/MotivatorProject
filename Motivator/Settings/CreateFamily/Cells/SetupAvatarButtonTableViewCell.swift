//
//  SetupAvatarButtonTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 07.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SetupAvatarButtonTableViewCell: UITableViewCell {

	private let setupAvatarLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .lightGray
		label.textAlignment = .center
		label.text = "Add Photo"
//		label.backgroundColor = .clear
//		label.layer.shadowOpacity = 0.40
//		label.layer.shadowOffset = CGSize(width: 1, height: 1)
//		label.layer.masksToBounds = false
		
		return label
	}()
	
		override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			
			configureView()
			setConstraints()
		}
		
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .darkGray
		addSubview(setupAvatarLabel)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			setupAvatarLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			setupAvatarLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -4),
			setupAvatarLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			setupAvatarLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -4)
		])
	}
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
}
