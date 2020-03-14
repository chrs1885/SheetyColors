//
//  SheetyColorsDelegate.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 14.03.20.
//

import UIKit

public protocol SheetyColorsDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
}
