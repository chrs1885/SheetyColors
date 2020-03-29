//
//  SheetyColorsView.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 30.03.20.
//

#if canImport(SwiftUI)

import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct SheetyColorsView: UIViewControllerRepresentable {
    public class Coordinator: NSObject, SheetyColorsDelegate {
        var parent: SheetyColorsView

        init(_ parent: SheetyColorsView) {
            self.parent = parent
        }
        
        public func didSelectColor(_ color: UIColor) {
            parent.color = color
        }
    }
    
    var config: SheetyColorsConfig
    @Binding var color: UIColor
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<SheetyColorsView>) -> SheetyColorsViewController {
        return SheetyColorsViewFactory.createView(withConfig: config, delegate: context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: SheetyColorsViewController, context: UIViewControllerRepresentableContext<SheetyColorsView>) {
    }
}

#endif
