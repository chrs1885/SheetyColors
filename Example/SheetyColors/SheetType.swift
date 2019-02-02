//
//  SheetType.swift
//  SheetyColors_Example
//
//  Created by Christoph Wendt on 25.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

enum SheetType {
    case createColor
    case editColor(item: Int)

    var title: String {
        switch self {
        case .createColor:
            return "Create a color"
        case .editColor:
            return "Edit Color"
        }
    }
}
