//
//  FamilyAvatarTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 03.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol FamilyAvatarTableViewCellDelegate: class {
	func editButtonDidTap()
}

class FamilyAvatarTableViewCell: UITableViewCell {
	
	private let editAvatarButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor(white: 0, alpha: 0.4)
		button.layer.cornerRadius = 30
		button.imageView?.tintColor = .white
		button.imageView?.contentMode = .scaleAspectFit
		button.imageView?.sizeToFit()
		button.setImage(UIImage(named: "Edit"), for: .normal)
		return button
	}()
	
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.image = UIImage(named: "BackgroundGradient")
		
		return imageView
	}()
	
	private let labelStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .bottom
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		return stack
	}()
	
	private let fullNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
		label.textColor = .white
		label.textAlignment = .right
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOpacity = 0.40
		label.layer.shadowOffset = CGSize(width: 1, height: 1)
		label.layer.masksToBounds = false
		
		return label
	}()
	
	private let phoneNumberLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.textAlignment = .right
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOpacity = 0.40
		label.layer.shadowOffset = CGSize(width: 1, height: 1)
		label.layer.masksToBounds = false
		
		return label
	}()
	
	private let editAvatarView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
		
		return view
	}()
	
	weak var delegate: FamilyAvatarTableViewCellDelegate?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureView() {
		
		labelStackView.addArrangedSubview(fullNameLabel)
		labelStackView.addArrangedSubview(phoneNumberLabel)
		addSubview(avatarImageView)
		addSubview(labelStackView)
		
		avatarImageView.addSubview(editAvatarView)
		avatarImageView.addSubview(editAvatarButton)
		editAvatarView.isHidden = true
		editAvatarButton.isHidden = true
		selectionStyle = .none
		self.backgroundColor = .clear
		contentView.backgroundColor = .clear
		editAvatarButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: topAnchor),
			avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			labelStackView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -15),
			labelStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -15),
			labelStackView.leadingAnchor.constraint(greaterThanOrEqualTo: avatarImageView.leadingAnchor, constant: 15)
		])
		
		NSLayoutConstraint.activate([
			editAvatarButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
			editAvatarButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
			editAvatarButton.heightAnchor.constraint(equalToConstant: 60),
			editAvatarButton.widthAnchor.constraint(equalToConstant: 60)
		])
		
		NSLayoutConstraint.activate([
			editAvatarView.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			editAvatarView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			editAvatarView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
			editAvatarView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor)
		])
	}
	
	private func attributeStringMaker(_ phoneNumber: String?, _ email: String?, _ lang: String?) -> NSAttributedString {
		let lang = lang?.capitalized
		let spacing = lang == nil ? "" : " "
		let readyString = NSMutableAttributedString()
		let boldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
		let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
		let firstPart = NSMutableAttributedString(string: phoneNumber ?? email ?? "", attributes: normalFontAttributes)
		let secondPart = NSMutableAttributedString(string: lang ?? "", attributes: boldFontAttributes)
		let space = NSMutableAttributedString(string: spacing, attributes: boldFontAttributes)
		readyString.append(firstPart)
		readyString.append(space)
		readyString.append(secondPart)
		return readyString
	}
	
	func configure(family: Family?, isEditing: Bool?) {
		fullNameLabel.text = family?.name
//		phoneNumberLabel.attributedText = attributeStringMaker("$$$$", nil, "&&&")
		guard let family = family, let urlString = family.avaterURL, let url = URL(string: urlString) else { return }
		avatarImageView.sd_setImage(with: url, placeholderImage: nil)
		
		if isEditing ?? false {
			editAvatarButton.isHidden = false
			editAvatarView.isHidden = false
			fullNameLabel.alpha = 0.5
		} else {
			editAvatarButton.isHidden = true
			editAvatarView.isHidden = true
			fullNameLabel.alpha = 1
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
	}
	
	@objc func editButtonPressed() {
		delegate?.editButtonDidTap()
	}
}
