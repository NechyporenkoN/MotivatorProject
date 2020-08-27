//
//  ProgressViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

/**
IMPORTANT:
IF YOU NEED UITableViewController or UICollectionViewController
Change the Class Name to NameTableViewController or NameCollectionViewController
Dont leave Your class name NameViewController
*/
final class ProgressViewController: UIViewController {

	private var presenter: ProgressPresenterDelegate?

	convenience init() {
		self.init(nibName: nil, bundle: nil)
		presenter = ProgressPresenter(view: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		configureSubviews()
	}

	private func configureView() {
//		self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
//    self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//    self.navigationController?.navigationBar.layer.shadowRadius = 4.0
//    self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
//    self.navigationController?.navigationBar.layer.masksToBounds = false
		view.backgroundColor = .darkGray
	}

	private func configureSubviews() {
		//view.addSubview
		//constraints
	}
}

// MARK: - ProgressViewDelegate
extension ProgressViewController: ProgressViewDelegate {

}
