//
//  UIColor+Utility.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/15/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) { // simplfys UIColor
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

}
