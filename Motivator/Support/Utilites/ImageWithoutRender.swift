//
//  ImageWithoutRender.swift
//  Motivator
//
//  Created by Nikita Nechyporenko on 10.02.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class ImageWithoutRender: UIImage {
	override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
		return self
	}
}
