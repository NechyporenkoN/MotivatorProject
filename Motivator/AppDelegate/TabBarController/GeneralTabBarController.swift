//
//  GeneralTabBarController.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/26/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
//import YXWaveView

//enum Tabs: Int {
//	case tasks = 0
//	case progress = 1
//	case prizes = 2
//	case settings = 3
//}

enum TabsTitles {
	case tasks
	case progress
	case prizes
	case settings
	
	var string: String? {
		switch self {
		case .tasks:
			return "Tasks"
		case .progress:
			return "Progress"
		case .prizes:
			return "Prizes"
		case .settings:
			return "Settings"
		}
	}
}

final class GeneralTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	private var bounceAnimation: CAKeyframeAnimation = {
		let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
		bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
		bounceAnimation.duration = TimeInterval(0.6)
		bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
		
		return bounceAnimation
	}()
	
	//	var tasksNavigationController: UINavigationController?       //= UINavigationController(rootViewController: tasksController)
	//	var progressNavigationController: UINavigationController?    //(rootViewController: progressController)
	//	var prizesNavigationController: UINavigationController?      //(rootViewController: prizesController)
	//	var settingsNavigationController: UINavigationController?    //(rootViewController: settingsController)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTabBar()
	}
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		
		guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
		
		imageView.layer.add(bounceAnimation, forKey: nil)
	}
	
	fileprivate func configureTabBar() {
		
		self.delegate = self
		
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .selected)
		
		tabBar.unselectedItemTintColor = .darkGray//UIColor(red:0.39, green:0.64, blue:0.82, alpha:1.0)//.white
		tabBar.tintColor = .lightGray//GeneralColors.globalColor
		
//		tabBar.roundCorners(corners: [.topRight], size: 35)
		//		tabBar.backgroundColor = GeneralColors.globalColor
		//		tabBar.shadowImage = UIImage()
		//		tabBar.backgroundImage = UIImage()
		//		tabBar.isOpaque = true
		//		tabBar.barTintColor = tasksNavigationController?.navigationBar.backgroundColor//.clear//GeneralColors.globalColor
		//		tabBar.shadowImage = backgroundView.asImage()
		//				tabBar.shadowImage = UIImage()
		tabBar.barTintColor = .black//GeneralColors.navigationBlueColor
		UIView.appearance().tintColor = .lightGray//GeneralColors.globalColor
		setTabs()
	}
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		
		let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
		
		if selectedIndex == 0 {
			
			
		} else if selectedIndex == 1 {
			
		} else if selectedIndex == 2 {
			
		} else if selectedIndex == 3 {
		
		}
	}
	
	
	fileprivate func setTabs() {
		
		let tasksController = TasksTableViewController()
		let progressController = ProgressViewController()
		let prizesController = PrizesViewController()
		let settingsController = SettingsViewController()
		
		tasksController.navigationItem.title = TabsTitles.tasks.string
		progressController.navigationItem.title = TabsTitles.progress.string
		prizesController.navigationItem.title = TabsTitles.prizes.string
		settingsController.navigationItem.title = TabsTitles.settings.string
		
		let tasksNavigationController = UINavigationController(rootViewController: tasksController)
		let progressNavigationController = UINavigationController(rootViewController: progressController)
		let prizesNavigationController = UINavigationController(rootViewController: prizesController)
		let settingsNavigationController = UINavigationController(rootViewController: settingsController)
		
		let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
		
		
		tasksNavigationController.navigationBar.barTintColor = .black
		tasksNavigationController.navigationBar.titleTextAttributes = textAttributes
		
		progressNavigationController.navigationBar.barTintColor = .black
		progressNavigationController.navigationBar.titleTextAttributes = textAttributes
		
		prizesNavigationController.navigationBar.barTintColor = .black
		prizesNavigationController.navigationBar.titleTextAttributes = textAttributes
		
		settingsNavigationController.navigationBar.barTintColor = .black
		settingsNavigationController.navigationBar.titleTextAttributes = textAttributes
		
		let tasksImage = UIImage(named: "TabBarTask")
		let progressImage = UIImage(named: "TabBarProgress")
		let prizesImage = UIImage(named: "TabBarPrizes")
		let settingsImage = UIImage(named: "TabBarSettings")
		
		let tasksTabItem = UITabBarItem(title: tasksController.navigationItem.title, image: tasksImage, selectedImage: nil)
		let progressTabItem = UITabBarItem(title: progressController.navigationItem.title, image: progressImage, selectedImage: nil)
		let prizesTabItem = UITabBarItem(title: prizesController.navigationItem.title, image: prizesImage, selectedImage: nil)
		let settingsTabItem = UITabBarItem(title: settingsController.navigationItem.title , image: settingsImage, selectedImage: nil)
		
		tasksController.tabBarItem = tasksTabItem
		progressController.tabBarItem = progressTabItem
		prizesController.tabBarItem = prizesTabItem
		settingsController.tabBarItem = settingsTabItem
		
		let tabBarControllers = [tasksNavigationController, progressNavigationController, prizesNavigationController, settingsNavigationController]
		
		viewControllers = tabBarControllers as? [UIViewController]
	}
}


//class Shit: UINavigationController {
//	
//
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		
//		if navigationBar.layer.mask == nil {
//			navigationBar.roundCorners(corners: [.bottomLeft], size: 35)
//		}
//	}
//}
//func blurBgImage(image: UIImage) -> UIImage? {
//		let radius: CGFloat = 20;
//		let context = CIContext(options: nil);
//		let inputImage = CIImage(cgImage: image.cgImage!);
//		let filter = CIFilter(name: "CIGaussianBlur");
//		filter?.setValue(inputImage, forKey: kCIInputImageKey);
//		filter?.setValue("\(radius)", forKey:kCIInputRadiusKey);
//
//		if let result = filter?.value(forKey: kCIOutputImageKey) as? CIImage{
//
//				let rect = CGRect(origin: CGPoint(x: radius * 2,y :radius * 2), size: CGSize(width: image.size.width - radius * 4, height: image.size.height - radius * 4))
//
//				if let cgImage = context.createCGImage(result, from: rect){
//						return UIImage(cgImage: cgImage);
//						}
//		}
//		return nil;
//}

