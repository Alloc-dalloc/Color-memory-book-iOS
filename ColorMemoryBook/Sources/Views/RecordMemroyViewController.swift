//
//  GenerateMemoryBookViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/20.
//

import UIKit
import Lottie

class RecordMemoryViewController: BaseViewController {
    
    private var selectedImage = UIImage()
    private let animationView = LottieAnimationView()
    private(set) lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
            $0.showsVerticalScrollIndicator = false
            $0.register(cell: MemoryImageCell.self)
            $0.register(cell: EditableTagCell.self)
            $0.register(cell: TextViewCell.self)
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryName")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryColor")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryMemo")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryDefault")
            $0.delegate = self
            $0.dataSource = self
        }
    }()
    
    
    private let completeButton = UIButton().then{
        $0.backgroundColor = .ohsogo_Blue
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    
    private let dismissButton = UIButton().then{
        $0.setImage(UIImage(named: "dismiss_button_black"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    override func setLayouts() {
        view.addSubviews(collectionView, completeButton, animationView)
        setNavigationBar()
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
    
    override func setProperties() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification: )),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
    }
    
    private let imageData: Data
    private let viewModel: ImageInfoViewModel
    private var detail: ImageInfo?
    
    init(imageData: Data) {
        let image = UIImage(data: imageData)
        self.imageData = imageData
        self.selectedImage = image!
        self.viewModel = ImageInfoViewModel(analysisRepository: DefaultAnalysisRepository())
        super.init()
        setAnimationView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    override func bind() {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.animationView.play()
                self?.view.isUserInteractionEnabled = false
                self?.view.alpha = 0.5
            })
            .disposed(by: disposeBag)

        rx.viewWillAppear
            .take(1)
            .map {[weak self] _ -> Data? in
                return self?.imageData
            }
            .compactMap { $0 }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.detail
            .compactMap{$0}
            .drive(onNext: { [weak self] detail in
                self?.detail = detail
                self?.animationView.stop()
                self?.view.isUserInteractionEnabled = true
                self?.view.alpha = 1
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setAnimationView() {
        animationView.animation = .named("loading")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dismissButton)
        title = "메모리 기록"
    }
    
    func updateTextViewHeight(for textView: UITextView) {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    //이미지 높이에 따라 레이아웃 다르게 줄려고 했는데 누끼따서 넣으니까 다 정사각형이네 아옼
    func calculateImageHeight() -> CGFloat {
        let aspectRatio = selectedImage.size.width / selectedImage.size.height
        let height = collectionView.frame.width / aspectRatio
        return height
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let intersection = view.frame.intersection(keyboardSize)
            if intersection.height > 0 {
                view.frame.origin.y -= intersection.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func dismissButtonDidTap(){
        navigationController?.popViewController(animated: true)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex{
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.calculateImageHeight()))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.calculateImageHeight()))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
                return section
                
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 100, trailing: 18)

                return section
                
            default:
                return nil
            }
        }
        return layout
    }
    
    
}

extension RecordMemoryViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        switch section {
        case 1:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "memoryName", for: indexPath) as! HeaderView
            headerView.titleLabel.text = "이름"
            return headerView

        case 2:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "memoryColor", for: indexPath) as! HeaderView
            headerView.titleLabel.text = "색상"
            return headerView
        case 3:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "memoryMemo", for: indexPath) as! HeaderView
            headerView.titleLabel.text = "메모"
            return headerView

        default:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "memoryDefault", for: indexPath) as! HeaderView
            headerView.titleLabel.text = "default"
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell: MemoryImageCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image = selectedImage
            collectionView.performBatchUpdates(nil, completion: nil)
            return cell
        case 1:
            let cell: EditableTagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            detail?.labels.forEach { label in
                cell.tagsField.addTag(label.name)
            }
            cell.tagsField.onDidChangeHeightTo = { [weak collectionView] _, _ in
                collectionView?.performBatchUpdates(nil, completion: nil)
            }
            return cell
        case 2:
            let cell: EditableTagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            detail?.colorAnalysis.forEach { label in
                cell.tagsField.addTag(label.colorName)
            }
            cell.tagsField.onDidChangeHeightTo = { [weak collectionView] _, _ in
                collectionView?.performBatchUpdates(nil, completion: nil)
            }
            return cell
        case 3:
            let cell: TextViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.textView.backgroundColor = .white
            cell.textView.layer.borderWidth = 1
            cell.textView.delegate = self
            cell.textView.layer.borderColor = UIColor.ohsogo_Gray?.cgColor
            cell.textView.isEditable = true
            return cell
            
        default:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
}

extension RecordMemoryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateTextViewHeight(for: textView)
    }
}
