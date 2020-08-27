//
//  GeneralColors.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 12/3/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class GeneralColors {
	
	static let globalColor = UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0)
	static let navigationBlueColor = UIColor(red:0.80, green:0.90, blue:0.98, alpha:1.0)
	
//	static let greenCellColor = UIColor(red:0.76, green:0.97, blue:0.76, alpha:1.0)
//	static let orangeCellColor = UIColor(red:0.98, green:0.86, blue:0.64, alpha:1.0)
//	static let purpleCellColor = UIColor(red:0.82, green:0.67, blue:1.00, alpha:1.0)
//	static let redCellColor = UIColor(red:1.00, green:0.50, blue:0.50, alpha:1.0)
	
	static let lightGreenCellColor = UIColor(red:0.92, green:1.00, blue:0.92, alpha:1.0)
	static let lightOrangeCellColor = UIColor(red:0.99, green:0.96, blue:0.91, alpha:1.0)
	static let lightPurpleCellColor = UIColor(red:0.95, green:0.91, blue:1.00, alpha:1.0)
	static let lightRedCellColor = UIColor(red:1.00, green:0.90, blue:0.90, alpha:1.0)
	
	static let greenCellColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
	static let orangeCellColor = UIColor(red:0.97, green:0.42, blue:0.11, alpha:1.0)
	static let purpleCellColor = UIColor(red:0.46, green:0.00, blue:1.00, alpha:1.0)
	static let redCellColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
	
	
	
	static let orangeColors = [
			UIColor(red:0.15, green:0.50, blue:0.01, alpha:1.0),
			UIColor(red:0.31, green:0.64, blue:0.04, alpha:1.0),
			UIColor(red:0.45, green:0.77, blue:0.07, alpha:1.0),
			UIColor(red:0.62, green:0.91, blue:0.11, alpha:1.0)
		]
	
	static let globalColorsArr = [
		UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0),
		UIColor(red:0.14, green:0.42, blue:0.63, alpha:1.0),
		UIColor(red:0.27, green:0.51, blue:0.68, alpha:1.0),
		UIColor(red:0.42, green:0.60, blue:0.73, alpha:1.0),
		UIColor(red:0.57, green:0.69, blue:0.79, alpha:1.0)
	]
	
	}
	
//	func gradientWithDirection(frame: CGRect, colors: [UIColor],
//														 direction: DirectionGradient) -> UIColor {
//
//		let backgroundGradientLayer = CAGradientLayer()
//		backgroundGradientLayer.frame = frame
//
//		switch direction {
//		case .rightBottomToLeftTop:
//			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 1)
//			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 0)
//		case .leftBottomToRightTop:
//			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 1)
//			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 0)
//		case .rightTopToLeftBottom:
//			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 0)
//			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 1)
//		case .leftATopToRightBottom:
//			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
//			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
//		case .fromBottomToTop:
//			backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
//			backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//		}
//
//		let cgColors = colors.map({$0.cgColor})
//
//		backgroundGradientLayer.colors = cgColors
//
//		UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
//
//		if let context = UIGraphicsGetCurrentContext() {
//			backgroundGradientLayer.render(in: context)
//		}
//
//		let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
//
//
//		UIGraphicsEndImageContext()
//
//		return UIColor(patternImage: backgroundColorImage ?? UIImage())
//	}
//}
