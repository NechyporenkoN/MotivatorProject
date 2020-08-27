//
//  JoinButtonTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 03.01.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol  JoinButtonTableViewCellDelegate: class {
	func joinButtonDidTap()
}

class JoinButtonTableViewCell: UITableViewCell {
	
	private let joinButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.lightGray, for: .normal)
		button.setTitle("Join", for: .normal)
		return button
	}()
	
	weak var delegate: JoinButtonTableViewCellDelegate?
	
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
		backgroundColor = .darkGray
		contentView.addSubview(joinButton)
		joinButton.addTarget(self, action: #selector(joinButtonPressed), for: .touchUpInside)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			joinButton.topAnchor.constraint(equalTo: contentView.topAnchor),
			joinButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			joinButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			joinButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}
	
	@objc func joinButtonPressed() {
		print("tap")
		delegate?.joinButtonDidTap()
	}
	
}
