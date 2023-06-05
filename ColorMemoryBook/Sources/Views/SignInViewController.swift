//
//  SignInViewController.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/04/13.
//

import AuthenticationServices
import Moya

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
    
    
    override func bind() {
        signInButton.rx.tap
            .bind {
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest()
                request.requestedScopes = [.fullName, .email]
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                authorizationController.delegate = self
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
            }.disposed(by: disposeBag)
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(
        controller _: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let identityToken = appleIDCredential.identityToken,
            let token = String(data: identityToken, encoding: .utf8)
        else {
            return
        }
        print(token)
        let provider = MoyaProvider<AuthService>()
        provider.request(.login(idToken: token)){ result in
            switch result {
            case let .success(response):
                let result = try? response.map(Token.self)
                print(result)
                UserDefaultHandler.shared.accessToken = result?.accessToken ?? "access token is nil"
                UserDefaultHandler.shared.refreshToken = result?.refreshToken ?? "refresh token is nil"
            case let .failure(error):
                print(error.localizedDescription)
            }
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


