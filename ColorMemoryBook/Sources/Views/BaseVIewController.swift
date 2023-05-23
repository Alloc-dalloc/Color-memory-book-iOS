//
//  BaseVIewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class BaseViewController : UIViewController{
    
    var disposeBag = DisposeBag()

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayouts()
        setProperties()
        bind()
    }
    
    func setLayouts(){}
    func setProperties(){}
    func bind(){}
}

extension BaseViewController {
//    func hideKeyboard() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
//            action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
}
