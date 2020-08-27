//
//  SetupFamilyAvatarTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SetupFamilyAvatarTableViewCell: UITableViewCell {
	
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.image = UIImage(named: "FamilyAvatarHolder")
		imageView.backgroundColor = .darkGray
		return imageView
	}()
		
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	func configure(avatar: UIImage?) {
		if avatar != nil {
			avatarImageView.contentMode = .scaleToFill
			avatarImageView.image = avatar
		} else {
			avatarImageView.contentMode = .scaleAspectFit
			avatarImageView.image = UIImage(named: "FamilyAvatarHolder")
		}
		
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureView() {
		
		contentView.addSubview(avatarImageView)
		selectionStyle = .none
		separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}
}
