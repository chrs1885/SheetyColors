//
//  SheetyColorProtocol.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 06.03.19.
//

import UIKit

/// A protocol defining a color object provided by the SheetyColors view.
public protocol SheetyColorProtocol: Codable {
    /// The UIColor representation of the color.
    var uiColor: UIColor { get }
}
