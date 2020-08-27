//
//  AppDelegate.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/21/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var tabBarController: GeneralTabBarController?
	let viewController = StartViewController()
	var navigationController = UINavigationController()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		application.statusBarStyle = .lightContent
//		UIVisualEffectView.appearance(whenContainedInInstancesOf: [UIAlertController.classForCoder() as! UIAppearanceContainer.Type]).effect = UIBlurEffect(style: .dark)
		FirebaseApp.configure()
		Database.database().isPersistenceEnabled = true
		
		setRootViewController()
		
		return true
	}
	
	private func setRootViewController() {
		if isLoggedIn() {
			
			if tabBarController == nil {
				tabBarController = GeneralTabBarController()
			}

//			navigationController.navigationBar.shadowImage = UIImage()
//			navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
			
//			tabBarController?.tabBar.shadowImage = UIImage()
//			tabBarController?.tabBar.backgroundImage = UIImage()
			
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = GeneralTabBarController()
			window?.makeKeyAndVisible()

		} else {
			navigationController = UINavigationController(rootViewController: viewController)
			navigationController.navigationBar.shadowImage = UIImage()
			navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
			
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
		}

		window?.backgroundColor = .black
		UINavigationBar.appearance().tintColor = .lightGray//GeneralColors.globalColor//.white
		UINavigationBar.appearance().backgroundColor = .black//GeneralColors.globalColor
	
		
//		UITabBar.appearance().layer.borderWidth = 1.0
//		UITabBar.appearance().layer.borderColor = UIColor.red.cgColor
//		UITabBar.appearance().clipsToBounds = true
		
		if #available(iOS 13.0, *) {
//			let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
//			statusBar.backgroundColor = GeneralColors.globalColor
//			UIApplication.shared.keyWindow?.addSubview(statusBar)
		} else {
			// Fallback on earlier versions
		}
	}
	
	private func isLoggedIn() -> Bool {
		return Auth.auth().currentUser != nil
	}
	
	func setGeneralRootViewController() {
		
		window?.rootViewController = GeneralTabBarController()
		window?.makeKeyAndVisible()
		window?.backgroundColor = .white
	}
	
	func setSelectRoleRootViewController() {
		
		var navigationController = UINavigationController()
		navigationController = UINavigationController(rootViewController: SelectFamilyRoleTableViewController(familyRights: nil, authType: .registration))
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		window?.backgroundColor = .white
	}
	
	
	// MARK: UISceneSession Lifecycle
	
	//	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
	//		// Called when a new scene session is being created.
	//		// Use this method to select a configuration to create the new scene with.
	//		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	//	}
	//
	//	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	//		// Called when the user discards a scene session.
	//		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
	//		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	//	}
	
	
//	func shapeWave() {
//			
//			let view = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
//
//			let path = UIBezierPath()
//			path.move(to: CGPoint(x: 0.0, y: 200))
//			path.addCurve(to: CGPoint(x: 200, y:150),
//										controlPoint1: CGPoint(x: 50, y: 350),
//										controlPoint2: CGPoint(x:150, y: 0))
//			path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height))
//			path.addLine(to: CGPoint(x: 0.0, y: view.frame.size.height))
//			path.close()
//
//			let shapeLayer = CAShapeLayer()
//			shapeLayer.path = path.cgPath
//
//			view.backgroundColor = UIColor.black
//			view.layer.mask = shapeLayer
//	//		self.view.addSubview(view)
//		navigationController.navigationBar.addSubview(view)
//		}
//	
}

