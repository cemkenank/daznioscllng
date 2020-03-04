//
//  UIButton+Extensions.swift
//  DAZN Challange
//
//  Created by MrDark on 3.03.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit

extension UIButton
{
    static func getDropdownButton(title:String) -> UIButton
    {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont(name: "System", size: 18.0)
        button.setImage(UIImage(named: "up_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: "down_arrow")?.withRenderingMode(.alwaysOriginal), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -235)
        button.backgroundColor = UIColor(r: 0, g: 84, b: 144)
        return button
    }
}
