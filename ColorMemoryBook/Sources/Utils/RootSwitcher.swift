//
//  RootSwitcher.swift
//  dandi
//
//  Created by 김윤서 on 2022/12/29.
//

import UIKit

final class RootSwitcher {
    enum Destination {
        case splash
        case login
        case main
        case custom(UIViewController)
    }

    static func update(_ destination: Destination) {
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        switch destination {
        case .splash:
            delegate.window?.rootViewController = UINavigationController(rootViewController: SignInViewController())
        case .login:
            delegate.window?.rootViewController = UINavigationController(rootViewController: SignInViewController())
        case .main:
            delegate.window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        // 테스트에만 사용할것
        case let .custom(viewController):
            delegate.window?.rootViewController = viewController
        }
    }
}
