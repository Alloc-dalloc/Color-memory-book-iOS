//
//  SignInViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/13.
//

import UIKit


class SignInViewController : UIViewController{
    
    let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Apple로 시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.layer.cornerRadius = 4
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo_white"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.ohsogo_Blue
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-54)
        }
        self.view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
