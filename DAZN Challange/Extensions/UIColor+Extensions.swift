//
//  UIColor+Extensions.swift
//  DAZN Challange
//
//  Created by MrDark on 3.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

extension UIColor {

    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

}
