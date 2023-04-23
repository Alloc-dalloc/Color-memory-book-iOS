//
//  HomeViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//


class HomeViewController: BaseViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private var tagSearchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "태그를 검색하세요."
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "search"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
        return imageView
    }()
    
    private let searchView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        return view
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear_button"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        return button
    }()
    
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floating_blue"), for: .normal)
        return button
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: .zero, left: .zero, bottom: 60, right: .zero)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: MemoryBookCell.self)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayouts() {
        self.view.addSubviews(tagSearchTextField, collectionView, floatingButton)
        profileButton.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(32)
        }
        tagSearchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tagSearchTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-11)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-11)
        }
        
        setNavigationBar()
        setTagSearchTextField()
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        let logoBarButtonItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItems = [logoBarButtonItem]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    func setTagSearchTextField(){
        searchView.addSubview(searchImageView)
        tagSearchTextField.leftView = searchView
        tagSearchTextField.leftViewMode = .always
        tagSearchTextField.rightView = clearButton
        tagSearchTextField.rightViewMode = .whileEditing
        //한번 포커싱되면 텍스트 없어도 x버튼 나타남, 다른 걸로 바꿔야
    }
    
}

 
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemoryBookCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: 211)
    }
}

#if DEBUG
import SwiftUI

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = HomeViewController()
        return viewController.getPreview()
    }
}

#endif
