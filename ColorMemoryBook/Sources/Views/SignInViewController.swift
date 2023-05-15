//
//  SignInViewController.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/04/13.
//

import AuthenticationServices


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

    override init(){
        super.init()
        view.backgroundColor = UIColor.ohsogo_Blue
        print(#fileID, #function, #line, "- ")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func setProperties() {
        signInButton.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func signInButtonDidTap(_ sender: UIButton){
        print("눌림")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    
}


extension SignInViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let authorizationCode = appleIDCredential.authorizationCode
            let tokeStr = String(data: idToken, encoding: .utf8)
            let toString = String(decoding: authorizationCode!, as: UTF8.self)

            UserDefaults.standard.setValue(userIdentifier, forKey: "userIdentifier")
            UserDefaults.standard.setValue(true, forKey: "isAppleLogin")
            
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            print("authorizationCode : " + toString)
            
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
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


