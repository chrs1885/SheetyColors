//
//  SheetyColorsViewModelDelegate.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

protocol SheetyColorsViewModelDelegate: AnyObject {
    func didUpdateColorComponent(in viewModel: SheetyColorsViewModelProtocol)
}
