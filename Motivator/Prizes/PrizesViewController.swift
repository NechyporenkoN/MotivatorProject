//
//  PrizesViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit


final class PrizesViewController: UIViewController {

	private var presenter: PrizesPresenterDelegate?

	convenience init() {
		self.init(nibName: nil, bundle: nil)
		presenter = PrizesPresenter(view: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		configureSubviews()
	}

	private func configureView() {
		
		view.backgroundColor = .darkGray
	}

	private func configureSubviews() {
		//view.addSubview
		//constraints
	}
}

// MARK: - PrizesViewDelegate
extension PrizesViewController: PrizesViewDelegate {

}
