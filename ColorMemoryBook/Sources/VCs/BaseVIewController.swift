//
//  BaseVIewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/15.
//

import UIKit

class BaseViewController : UIViewController{
    
    init(){
        super.init(nibName: nil, bundle: nil)
//        print(#fileID, #function, #line, "- ")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setLayouts()
//        print(#fileID, #function, #line, "- ")
    }
    
    func setLayouts(){}
    
}
