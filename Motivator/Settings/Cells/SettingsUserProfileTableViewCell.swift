//
//  SettingsUserProfileTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 12/3/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import SDWebImage

class SettingsUserProfileTableViewCell: UITableViewCell {

	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "UserAvatarHolder")
		imageView.contentMode = .scaleAspectFill
		imageView.tintColor = GeneralColors.globalColor
		imageView.layer.cornerRadius = 20
		imageView.layer.borderColor = GeneralColors.globalColor.cgColor
		imageView.layer.borderWidth = 1
		imageView.layer.masksToBounds = true
		
		return imageView
	}()
	
	private let roleTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		
		return label
	}()
	
	private let nameTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		
		return label
	}()
	
	private let separator = SeparatorView()
	
	private let infoStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		
		return stack
	}()
	
	private var helperBackgroundView = UIView()
	private var currentAvatarURL: String?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
//		helperBackgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.frame.height)
//		helperBackgroundView.roundCorners(corners: [.topLeft], size: 30)
		
//		guard let currentAvatarURL = currentAvatarURL else { return }
////		avatarImageView.sd_setImage(with: URL(string: currentAvatarURL), completed: nil)
//		avatarImageView.sd_setImage(with: URL(string: currentAvatarURL)) { (_, _, _, _) in
//			self.avatarImageView.roundCorners(corners: [.bottomRight, .topLeft], size: 20)
//		}
	}
	
	func configure(user: User?) {
		guard let user = user else { return }
		roleTitleLabel.text = user.role
		nameTitleLabel.text = user.name
		guard let imageStr = user.avatar  else { avatarImageView.layer.borderWidth = 1; avatarImageView.roundCorners(corners: [.bottomRight, .topLeft], size: 20); return }
		avatarImageView.sd_setImage(with: URL(string: imageStr), completed: nil)
		avatarImageView.layer.borderWidth = 0
		currentAvatarURL = imageStr
	}
	
	private func configureView() {
		contentView.backgroundColor = .clear
		self.backgroundColor = .darkGray
//		helperBackgroundView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.frame.height)
//		helperBackgroundView.roundCorners(corners: [.bottomRight, .topLeft], size: 35)
//		helperBackgroundView.backgroundColor = GeneralColors.navigationBlueColor
		addSubview(helperBackgroundView)
		
//		avatarImageView.roundCorners(corners: [.bottomRight, .topLeft], size: 30)
//		self.roundCorners(corners: [.bottomRight, .topLeft], size: 35)
//		self.backgroundColor = GeneralColors.navigationBlueColor
		separator.translatesAutoresizingMaskIntoConstraints = false
		selectionStyle = .none
		infoStackView.addArrangedSubview(roleTitleLabel)
		infoStackView.addArrangedSubview(separator)
		infoStackView.addArrangedSubview(nameTitleLabel)
		contentView.addSubview(infoStackView)
		contentView.addSubview(avatarImageView)
//		accessoryType = .disclosureIndicator
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			avatarImageView.heightAnchor.constraint(equalToConstant: 88),
			avatarImageView.widthAnchor.constraint(equalToConstant: 88),
			avatarImageView.centerYAnchor.constraint(equalTo: helperBackgroundView.centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
		])
		
		NSLayoutConstraint.activate([
			infoStackView.heightAnchor.constraint(equalToConstant: 100),
			infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			infoStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
			infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
		
		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 0.5),
			separator.widthAnchor.constraint(equalToConstant: infoStackView.frame.width),
		
		])
		
//		avatarImageView.roundCorners(corners: [.bottomRight, .topLeft], size: 30)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
