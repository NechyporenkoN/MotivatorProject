//
//  EnterCodeViewController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/22/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
//import FirebaseAuth

final class EnterCodeViewController: UIViewController {
	
	let enterCodeTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "We have sent you an SMS with the code"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		return label
	}()
	
	let backgroundImageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		view.image = UIImage(named: "BackgroundGradient")
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	private let codeStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 10
		return stack
	}()
	
	var nextButton: UIBarButtonItem?
	
	private var presenter: EnterCodePresenterDelegate?
	private var codeCounter = 6
	private var codeFields = [CodeTextField]()
	private var authType: AuthType?
	
	init(_ familyRights: Rights? = nil, authType: AuthType?, phoneNumber: String?, verificationID: String?) {
		super.init(nibName: nil, bundle: nil)
		self.authType = authType
		presenter = EnterCodePresenter(view: self, phoneNumber: phoneNumber, verificationID: verificationID, authType: authType, familyRights: familyRights)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		configureSubviews()
	}
	
	private func configureView() {
		
		navigationItem.title = presenter?.phoneNumber
		
		nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
		navigationItem.rightBarButtonItem = nextButton
		nextButton?.isEnabled = false
		
		view.addSubview(backgroundImageView)
		
		configureCodeValidation(of: codeCounter)
		
		codeFields.forEach {
			codeStackView.addArrangedSubview($0)
		}
		
		view.addSubview(enterCodeTitleLabel)
		view.addSubview(codeStackView)
	}
	
	private func configureSubviews() {
		
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
		
		NSLayoutConstraint.activate([
			codeStackView.heightAnchor.constraint(equalToConstant: 50),
			codeStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/1.3),
			codeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			codeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70)
		])
		
		NSLayoutConstraint.activate([
			enterCodeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
			enterCodeTitleLabel.heightAnchor.constraint(equalToConstant: 100),
			enterCodeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			enterCodeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
		])
	}
	
	private func configureCodeValidation(of count: Int) {
		for i in 0..<count {
			let codeField = CodeTextField(position: i)
			codeField.font = UIFont.boldSystemFont(ofSize: 22)
			codeField.textColor = .black
			codeField.textAlignment = .center
			codeField.keyboardType = .numberPad
			codeField.backgroundColor = .white
			codeField.layer.cornerRadius = 10
			codeField.layer.borderColor = UIColor.white.cgColor
			codeField.layer.borderWidth = 1
			codeField.text = "" //codeField.text = " "
			codeField.delegate = self
			codeField.keyboardType = .numberPad
			codeFields.append(codeField)
		}
	}
	
	@objc func nextButtonPressed() {
		
		if authType == .registration {
			
		} else {
			navigationItem.hidesBackButton = true
		}
		presenter?.checkPhoneCode()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - EnterCodeViewDelegate
extension EnterCodeViewController: EnterCodeViewDelegate {
	
	func setAndShowGeneralController() {
		let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
		appDel.setGeneralRootViewController()
		let destination = GeneralTabBarController()
		navigationController?.show(destination, sender: self)
	}
	
	func showAlert(message: String?) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(ok)
		present(alert, animated: true)
	}
	
	func showSelectFamilyRoleController(familyRights: Rights?, authType: AuthType?) {
		let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
		appDel.setSelectRoleRootViewController()
		let destination = SelectFamilyRoleTableViewController(familyRights: familyRights, authType: authType ?? .registration)
		navigationItem.title = nil
		navigationController?.show(destination, sender: self)//(destination, sender: self)
	}
	
	func showSelectFamilyRoleForAddPerson(familyRights: Rights?, authType: AuthType?) {
		let destination = SelectFamilyRoleTableViewController(familyRights: familyRights, authType: authType ?? .addPerson)
		navigationItem.title = nil
		navigationController?.show(destination, sender: self)
	}
	
	//	func popToViewController() {
	//		navigationController?.popToRootViewController(animated: true)
	//	}
	
	//	func showGeneralController() {
	//		let destination = GeneralTabBarController()
	//		navigationItem.title = nil
	//		self.navigationController?.show(destination, sender: self)
	//	}
}

extension EnterCodeViewController: UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		if string.count != 1 && string.count != 0 {
			fillWithPastedCode(string)
			return false
		} else {
			let tempText = textField.text
			textField.text = string
			codeFieldChanged(textField as! CodeTextField, previousText: tempText ?? " ")
			return false
		}
	}
	
	private func fillWithPastedCode(_ code: String) {
		guard code.count != 0 else { return }
		var fullCode = code
		let fillBorder = (fullCode.count > codeCounter) ? codeCounter : fullCode.count
		for i in 0..<fillBorder {
			if let nextCodeField = codeFields.first(where: { $0.codePosition == i }) {
				nextCodeField.text = "\(fullCode.remove(at: fullCode.startIndex))"
			}
		}
	}
	
	@objc func codeFieldChanged(_ sender: CodeTextField, previousText: String) {
		
		if sender.text == "" {
			sender.text = " "
			let prevPos = sender.codePosition - 1
			if let prevCodeField = codeFields.first(where: { $0.codePosition == prevPos }), previousText == " " {
				prevCodeField.text = " "
				prevCodeField.becomeFirstResponder()
			}
		} else {
			
			let pos = sender.codePosition + 1
			if let nextCodeField = codeFields.first(where: { $0.codePosition == pos }) {
				nextCodeField.becomeFirstResponder()
			} else {
				
				sender.resignFirstResponder()
				
				codeStackView.arrangedSubviews.forEach {
					if let codeTextField = $0 as? CodeTextField {
						if let text = codeTextField.text, text != " " {
							presenter?.verificationCode += text
						}
					}
				}
				nextButton?.isEnabled = true
			}
		}
	}
}
