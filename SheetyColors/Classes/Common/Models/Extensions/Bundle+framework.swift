//
//  Bundle+framework.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.08.19.
//

import Foundation

extension Bundle {
    class var framework: Bundle {
        return Bundle(for: RGBViewModel.self)
    }
}
