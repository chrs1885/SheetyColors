//
//  PreviewColorViewDelegate.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 04.04.20.
//

import Foundation

protocol PreviewColorViewDelegate: AnyObject {
    func previewColorView(_ previewColorView: PreviewColorView, didEditHexValue value: String)
}
