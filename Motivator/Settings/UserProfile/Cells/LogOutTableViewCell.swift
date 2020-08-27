//
//  LogOutTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 23.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol LogOutTableViewCellDelegate {
	func logOutDidTap()
}
class LogOutTableViewCell: UITableViewCell {
    
	private let logOutButton: UIButton = {
		let button = UIButton()
		button.setTitle("Log Out", for: .normal)
		button.setTitleColor(.red, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}()
	
//	var helperBackgroundView: UIView = {
//		let view = UIView()
//		view.layer.cornerRadius = 4
//		view.backgroundColor = GeneralColors.navigationBlueColor
//
//		return view
//	}()
	
	var delegate: LogOutTableViewCellDelegate?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureView() {
		selectionStyle = .none
//		contentView.backgroundColor = .clear
		backgroundColor = .darkGray
		
//		contentView.addSubview(helperBackgroundView)
		addSubview(logOutButton)
		logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			logOutButton.topAnchor.constraint(equalTo: topAnchor),
			logOutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
			logOutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			logOutButton.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
//		helperBackgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: self.frame.height)
//		helperBackgroundView.roundCorners(corners: [.bottomRight], size: 30)
	}
	
	@objc func logOutButtonPressed() {
		delegate?.logOutDidTap()
	}
}
