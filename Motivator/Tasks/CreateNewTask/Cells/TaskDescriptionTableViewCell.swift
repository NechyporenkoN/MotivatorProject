//
//  TaskDescriptionTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 04.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol TaskDescriptionTableViewCellDelegate: class {
	func updateHeightOfRow(_ cell: UITableViewCell, _ textView: UITextView)
}

class TaskDescriptionTableViewCell: UITableViewCell {
	
	let textView: UITextView = {
		let textView = UITextView()
		textView.textColor = .lightGray
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.isScrollEnabled = false
		textView.textContainerInset = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
		textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		textView.backgroundColor = .clear
		return textView
	}()
	
	let placeholderLabel: UILabel = {
		let placeholderLabel = UILabel()
		placeholderLabel.sizeToFit()
		placeholderLabel.textColor = .gray
		placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
		placeholderLabel.text = "Enter description"
		placeholderLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		return placeholderLabel
	}()
	
	weak var delegate: TaskDescriptionTableViewCellDelegate?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .darkGray
		textView.delegate = self
		addSubview(textView)
		textView.addSubview(placeholderLabel)
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			textView.topAnchor.constraint(equalTo: topAnchor),
			textView.bottomAnchor.constraint(equalTo: bottomAnchor),
			textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
			textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
		])
		
		NSLayoutConstraint.activate([
			placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 13),
			placeholderLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
			placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 4),
			placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
		])
	}
	
	func requestUpdatedDescription() -> String? {
		
		return textView.text
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension TaskDescriptionTableViewCell: UITextViewDelegate {
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		guard range.location == 0 else {
			return true
		}
		let newString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
		return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
	}
	
	func textViewDidChange(_ textView: UITextView) {
		placeholderLabel.isHidden = !textView.text.isEmpty
		if let deletate = delegate {
			deletate.updateHeightOfRow(self, textView)
		}
	}
}
