//
//  UIViewController+.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/13.
//

import Foundation
import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    
    func getPreview() -> some View {
        UIViewControllerPreview(self)
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
