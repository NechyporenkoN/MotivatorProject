//
//  Extensions.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 11/22/19.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit

extension UIView {
	
	func shake(for duration: TimeInterval = 0.35, withTranslation translation: CGFloat = 7) {
		
		let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
		notificationFeedbackGenerator.prepare()
		
		
		let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
			self.transform = CGAffineTransform(translationX: translation, y: 0)
		}
		
		propertyAnimator.addAnimations({
			self.transform = CGAffineTransform(translationX: 0, y: 0)
		}, delayFactor: 0.2)
		
		propertyAnimator.startAnimation()
		notificationFeedbackGenerator.notificationOccurred(.error)
	}
	
	//	func shapeWave() -> UIView {
	//
	//		let view = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
	//
	//		let path = UIBezierPath()
	//		path.move(to: CGPoint(x: 0.0, y: 200))
	//		path.addCurve(to: CGPoint(x: 200, y:150),
	//									controlPoint1: CGPoint(x: 50, y: 350),
	//									controlPoint2: CGPoint(x:150, y: 0))
	//		path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height))
	//		path.addLine(to: CGPoint(x: 0.0, y: view.frame.size.height))
	//		path.close()
	//
	//		let shapeLayer = CAShapeLayer()
	//		shapeLayer.path = path.cgPath
	//
	//		view.backgroundColor = UIColor.black
	//		view.layer.mask = shapeLayer
	////		self.view.addSubview(view)
	//		return view
	//	}
	
	func asImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(bounds: bounds)
		return renderer.image { rendererContext in
			layer.render(in: rendererContext.cgContext)
		}
	}
}

enum DirectionGradient {
	case rightBottomToLeftTop
	case leftBottomToRightTop
	case rightTopToLeftBottom
	case leftATopToRightBottom
	case fromBottomToTop
	case fromTopToBottom
}

extension UIColor {
	
	static func gradientWithDirection(frame: CGRect, colors: [UIColor] = GeneralColors.orangeColors,
																		direction: DirectionGradient) -> UIColor {
		
		let backgroundGradientLayer = CAGradientLayer()
		backgroundGradientLayer.frame = frame
		
		switch direction {
		case .rightBottomToLeftTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 0)
		case .leftBottomToRightTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 0)
		case .rightTopToLeftBottom:
			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 0)
			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 1)
		case .leftATopToRightBottom:
			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
		case .fromBottomToTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
		case .fromTopToBottom:
			backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
			backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		}
		
		let cgColors = colors.map({$0.cgColor})
		
		backgroundGradientLayer.colors = cgColors
		
		UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
		
		if let context = UIGraphicsGetCurrentContext() {
			backgroundGradientLayer.render(in: context)
		}
		
		let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
		
		
		UIGraphicsEndImageContext()
		
		return UIColor(patternImage: backgroundColorImage ?? UIImage())
	}
	
	//	static func generalStyleColor() -> UIColor {
	//		return UIColor(red: 0, green: 0.33, blue: 0.58, alpha: 1.0)
	//	}
}

//extension UINavigationController {
//	func setNavigationShadowHidden(_ state: Bool) {
//
//		if state {
//			if #available(iOS 13.0, *) {
//				navigationBar.standardAppearance.shadowColor = .clear
//				navigationBar.compactAppearance?.shadowColor = .clear
//				navigationBar.scrollEdgeAppearance?.shadowColor = .clear
//			}
//		}
//
//		navigationBar.setValue(state, forKey: "hidesShadow")
//	}
//}

extension UIView {
	
	func navigationRoundCorners(corners: UIRectCorner, size: CGFloat){
		
		let rect = CGRect(x: bounds.origin.x, y: bounds.origin.y - UIApplication.shared.statusBarFrame.height, width: bounds.width, height: bounds.height + UIApplication.shared.statusBarFrame.height)
		let path = UIBezierPath(roundedRect: rect,
														byRoundingCorners:corners,
														cornerRadii: CGSize(width: size, height:  size))
		
		let maskLayer = CAShapeLayer()
		
		maskLayer.path = path.cgPath
		self.layer.mask = maskLayer
	}
	
	func roundCorners(corners: UIRectCorner, size: CGFloat){
		
		let path = UIBezierPath(roundedRect: self.bounds,
														byRoundingCorners:corners,
														cornerRadii: CGSize(width: size, height:  size))
		
		let maskLayer = CAShapeLayer()
		
		maskLayer.path = path.cgPath
		self.layer.mask = maskLayer
	}
}

extension Date {
	func toMilliseconds() -> String {
		return String(Int(self.timeIntervalSince1970 * 100000))
	}
}

func textToImage(draw text: String?, in image: UIImage, at point: CGPoint) -> UIImage {
		let textColor = UIColor.white
	let textFont = UIFont.systemFont(ofSize: 12, weight: .medium)
	
	let scale = UIScreen.main.scale
	UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
	
	let style = NSMutableParagraphStyle()
	style.alignment = NSTextAlignment.center
	
	let textFontAttributes = [
		NSAttributedString.Key.font: textFont,
		NSAttributedString.Key.foregroundColor: textColor,
		NSAttributedString.Key.paragraphStyle: style
		] as [NSAttributedString.Key: Any]
	
	image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
	let rect = CGRect(origin: point, size: image.size)
	text?.draw(in: rect, withAttributes: textFontAttributes)
	
	let newImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	
	return newImage!
}

