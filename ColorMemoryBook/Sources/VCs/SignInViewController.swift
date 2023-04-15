//
//  SignInViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/13.
//

import UIKit


class SignInViewController : BaseViewController{
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Apple로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.layer.cornerRadius = 4
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo_white"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ohsogo_Blue
    }
    
    override func setLayouts() {
        self.view.addSubviews(signInButton, logoImageView)
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-54)
        }
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI

struct SignInViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = SignInViewController()
        return viewController.getPreview()
    }
}

#endif
