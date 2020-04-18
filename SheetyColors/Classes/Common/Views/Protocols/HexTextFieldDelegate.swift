//
//  HexTextFieldDelegate.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 05.04.20.
//

import Foundation

protocol HexTextFieldDelegate: AnyObject {
    func hexTextField(_ hextTextField: HexTextField, didEditHexValue value: String)
}
