//
//  CustomTextField.swift
//  OnTheMap
//
//  Created by David on 8/18/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

	// For rounded corder
	override func awakeFromNib() {
		layer.cornerRadius = 2.0
	}
	
	// For Placeholder text indentation
	override func textRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 0)
	}
	
	// For editible text indentation
	override func editingRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 0)
	}
}

// For placeholder text color
extension UITextField {
	
	@IBInspectable var placeHolderColor: UIColor? {
		get {
			return self.placeHolderColor
		}
		set {
			self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
		}
	}
}