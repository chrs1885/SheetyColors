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

    // A color picker view that can be used with SwiftUI.
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

        /// Defines all aspects of the view such as a color model type, alpha value support, texts, initial colors, or haptical feedback.
        var config: SheetyColorsConfig

        /// A binding for the color that has been selected within the color picker.
        @Binding var color: UIColor

        public func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        public func makeUIViewController(context: UIViewControllerRepresentableContext<SheetyColorsView>) -> SheetyColorsViewController {
            return SheetyColorsViewFactory.createView(withConfig: config, delegate: context.coordinator)
        }

        public func updateUIViewController(_: SheetyColorsViewController, context _: UIViewControllerRepresentableContext<SheetyColorsView>) {}
    }

#endif
