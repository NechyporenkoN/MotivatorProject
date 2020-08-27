//
//  SelectPerformerTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SelectPerformerTableViewCell: UITableViewCell {

    private let userNameLabel: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
//			label.textAlignment = .center
			label.textColor = .lightGray
			label.text = "Username"
			return label
		}()
	
	let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
		
		return imageView
	}()
		
		override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			
			configureView()
			setConstraints()
		}
	
	func configure(user: User?) {
		
		userNameLabel.text = user?.name
		if let avatar = user?.avatar {
			avatarImageView.sd_setImage(with: URL(string: avatar), completed: nil)
			avatarImageView.layer.borderWidth = 0
		}else {
			avatarImageView.image = UIImage(named: "UserAvatarHolder")
			avatarImageView.layer.borderColor = GeneralColors.globalColor.cgColor
			avatarImageView.layer.borderWidth = 4
		}
	}
		
		private func configureView() {
			selectionStyle = .none
			backgroundColor = .darkGray
			addSubview(userNameLabel)
			addSubview(avatarImageView)
		}
		
		private func setConstraints() {
			
			NSLayoutConstraint.activate([
				userNameLabel.topAnchor.constraint(equalTo: topAnchor),
				userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
				userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
				userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
			])
			
			NSLayoutConstraint.activate([
				avatarImageView.heightAnchor.constraint(equalToConstant: 50),
				avatarImageView.widthAnchor.constraint(equalToConstant: 50),
				avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
				avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
			])
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

}
