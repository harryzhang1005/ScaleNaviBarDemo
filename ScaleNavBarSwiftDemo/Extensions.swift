//
//  Extensions.swift
//  ScaleNavBarSwiftDemo
//
//  Created by Hongfei Zhang on 9/19/17.
//  Copyright © 2017 HappyGuy. All rights reserved.
//

import UIKit

extension UIColor {
	
	static func aRandomColor() -> UIColor
	{
		let r = CGFloat(arc4random() % 255)
		let g = CGFloat(arc4random() % 255)
		let b = CGFloat(arc4random() % 255)
		
		return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
	}
	
}

extension CGFloat {
	
	var string1: String {
		return String(format: "%.1f", self)
	}
	var string2: String {
		return String(format: "%.2f", self)
	}
	var string3: String {
		return String(format: "%.3f", self)
	}
	
}
