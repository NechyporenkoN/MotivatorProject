//
//  Separator.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 06.12.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
	
	let separator: UIView = {
		let view = UIView()
		view.backgroundColor = GeneralColors.globalColor
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(separator)
		separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
		separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

