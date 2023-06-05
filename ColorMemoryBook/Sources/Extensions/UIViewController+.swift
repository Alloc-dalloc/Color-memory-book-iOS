//
//  UIViewController+.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/13.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    
    func getPreview() -> some View {
        UIViewControllerPreview(self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

@available(iOS 13.0, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewController
    
    init(_ viewController: ViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Do nothing
    }
    
    typealias UIViewControllerType = ViewController
    
}


#endif
