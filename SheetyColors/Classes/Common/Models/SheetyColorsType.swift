//
//  SheetyColorsType.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 02.02.19.
//

/// An enum used for specifying the color model of the SheetyColors view.
public enum SheetyColorsType: Equatable, CaseIterable {

    /// The grayscale color model.
    case grayscale
    
    /// The HSB color model.
    case hsb
    
    /// The RGB color model.
    case rgb
}
