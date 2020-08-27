//
//  ViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/21/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit


class StartViewController: UIViewController {

	let backgroundImageView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "BackgroundLaunchScreen")
		view.contentMode = .scaleAspectFill
//		view.image = UIImage(named: "BackgroundGradient")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		
		
		return view
	}()
	
	let startButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("START", for: .normal)
		button.backgroundColor = .clear
		button.layer.cornerRadius = 10
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.borderWidth = 1
		
		return button
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		configureView()
		setupConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
	}

	func configureView() {
		
//		UINavigationBar.appearance().shadowImage = UIImage()
//		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
		
		view.addSubview(backgroundImageView)
		view.addSubview(startButton)
		startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
	}
	
	func setupConstraints() {
		
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
		
		NSLayoutConstraint.activate([
			startButton.heightAnchor.constraint(equalToConstant: 44),
			startButton.widthAnchor.constraint(equalToConstant: 140),
			startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
		])
	}
	
	@objc func startButtonPressed() {
		let destination = EnterPhoneNumberViewController(.registration)
		navigationController?.show(destination, sender: self)
	}
}

