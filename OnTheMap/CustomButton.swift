//
//  RoundedButton.swift
//  OnTheMap
//
//  Created by David on 8/18/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
	
	override func awakeFromNib() {
		cornerRadius = 4.0
	}
}

extension UIView {
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
		}
	}
}

