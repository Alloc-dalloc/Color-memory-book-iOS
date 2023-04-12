//
//  HomeViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let tagSearchTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "태그를 검색하세요."
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "search"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
        return imageView
    }()
    
    let searchView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
       return view
    }()
        
    let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floating_button"), for: .normal)
        return button
    }()
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        // Set navigation bar background color
        navigationController?.navigationBar.barTintColor = .white
        
        // Add logo image view to navigation bar
        let logoBarButtonItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItems = [logoBarButtonItem]
        
        // Add profile button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        // Layout the profile button
        profileButton.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        // Layout the logo image view
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(32)
        }
        
        // Set left view of text field to search icon image view
        searchView.addSubview(searchImageView)
        tagSearchTextField.leftView = searchView
        tagSearchTextField.leftViewMode = .always

        // Add text field to view and layout
        self.view.addSubview(tagSearchTextField)
        tagSearchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MemoryBookCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tagSearchTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()

        }
        
        self.view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-11)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-11)
        }
        
    }
}

 
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemoryBookCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: 211)
    }
    
}


#if DEBUG
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = HomeViewController()
        return viewController.getPreview()
    }
}

#endif
