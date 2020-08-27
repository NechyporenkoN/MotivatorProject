//
//  SettingsFamilyTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 12/3/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SettingsFamilyTableViewCell: UITableViewCell {
	
	private let familyTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .black
	  label.text = "Family"
		
		return label
	}()
	
	private let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "Family")
		
		return imageView
	}()
	
	private var helperBackgroundView = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		helperBackgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.frame.height)
	}
	
	private func configureView() {
		
		contentView.backgroundColor = .clear
		self.backgroundColor = .clear
//		helperBackgroundView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.frame.height)
//		helperBackgroundView.roundCorners(corners: [.topLeft], size: 35)
		helperBackgroundView.backgroundColor = GeneralColors.navigationBlueColor
		contentView.addSubview(helperBackgroundView)
		
//		imageView?.tintColor = .white
//		imageView?.backgroundColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
//		imageView?.layer.cornerRadius = 4
//		textLabel?.text = "Family"
		selectionStyle = .none
		helperBackgroundView.addSubview(iconImageView)
		helperBackgroundView.addSubview(familyTitleLabel)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			familyTitleLabel.topAnchor.constraint(equalTo: helperBackgroundView.topAnchor),
			familyTitleLabel.bottomAnchor.constraint(equalTo: helperBackgroundView.bottomAnchor),
			familyTitleLabel.trailingAnchor.constraint(equalTo: helperBackgroundView.trailingAnchor, constant: -16),
			familyTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16)
		])
		
		NSLayoutConstraint.activate([
			iconImageView.centerYAnchor.constraint(equalTo: helperBackgroundView.centerYAnchor),
			iconImageView.widthAnchor.constraint(equalToConstant: 32),
			iconImageView.heightAnchor.constraint(equalToConstant: 32),
			iconImageView.leadingAnchor.constraint(equalTo: helperBackgroundView.leadingAnchor, constant: 16)
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
