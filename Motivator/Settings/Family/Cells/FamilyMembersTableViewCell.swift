//
//  FamilyMembersTableViewCell.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 20.12.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol FamilyMembersTableViewCellDelegate: class {
	func deleteButtonDidTap(user: User)
	func inviteFamilyMember(rights: Rights)
}

class FamilyMembersTableViewCell: UITableViewCell {
	
	weak var delegate: FamilyMembersTableViewCellDelegate?
	private var familyCollectionView: UICollectionView!
	private var dataSource: [User] = [] { didSet { familyCollectionView.reloadData() }}
	private var isEdit: Bool = false { didSet { familyCollectionView.reloadData() }}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	func configure(dataSource: [User]?, isEditing: Bool) {
		isEdit = isEditing
		guard let dataSource = dataSource else { return }
		self.dataSource = dataSource
		//		let addMember = User(name: "Add" + " " + (familyRights?.rawValue ?? ""), userID: nil, role: "", avatar: nil, familyID: nil, rights: nil)
		//		self.dataSource.append(addMember)
		//		dump(dataSource)
		//		familyCollectionView.reloadData()
	}
	
	private func configureView() {
		
		selectionStyle = .none
		backgroundColor = .darkGray
		contentView.backgroundColor = .clear
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		familyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		familyCollectionView.translatesAutoresizingMaskIntoConstraints = false
		familyCollectionView.backgroundColor = .clear
		familyCollectionView.dataSource = self
		familyCollectionView.delegate = self
		familyCollectionView.alwaysBounceHorizontal = true
		familyCollectionView.showsHorizontalScrollIndicator = false
		addSubview(familyCollectionView)
		
		familyCollectionView.register(FamilyMemberCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FamilyMemberCollectionViewCell.self))
	}
	
	private func setConstraints() {
		
		NSLayoutConstraint.activate([
			familyCollectionView.topAnchor.constraint(equalTo: topAnchor),
			familyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			familyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			familyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
	}
	
}

extension FamilyMembersTableViewCell: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FamilyMemberCollectionViewCell.self), for: indexPath) as! FamilyMemberCollectionViewCell
		cell.delegate = self
		cell.configure(user: dataSource[indexPath.row], isEditing: isEdit)
		return cell
	}
}

extension FamilyMembersTableViewCell: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("TAP")
		if let cell = collectionView.cellForItem(at: indexPath) as? FamilyMemberCollectionViewCell {
			if cell.user?.userID == nil {
				if cell.user?.rights == Rights.parent.rawValue {
					delegate?.inviteFamilyMember(rights: .parent)
				} else if cell.user?.rights == Rights.child.rawValue {
					delegate?.inviteFamilyMember(rights: .child)
				}
			}
		}
	}
}

extension FamilyMembersTableViewCell: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 120, height: 120)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 10)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

extension FamilyMembersTableViewCell: FamilyMemberCollectionViewCellDelegate {
	
	func deleteButtonDidTap(user: User) {
		delegate?.deleteButtonDidTap(user: user)
	}
}
