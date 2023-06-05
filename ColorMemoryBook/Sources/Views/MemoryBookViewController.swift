//
//  MemoryBookViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/04.
//

import UIKit


class MemoryBookViewController: BaseViewController {
        
    private(set) lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
            $0.showsVerticalScrollIndicator = false
            $0.register(cell: MemoryImageCell.self)
            $0.register(cell: TagCell.self)
            $0.register(cell: TextViewCell.self)
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryName")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryColor")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryMemo")
            $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "memoryDefault")
            $0.delegate = self
            $0.dataSource = self
        }
    }()
    
    private let kebabButton = UIButton().then{
        $0.setImage(UIImage(named: "kebab_button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    private let memoryImageView = UIImageView().then{
        $0.image = UIImage(named: "tmp1")
        $0.contentMode =  .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .black
    }
    
    private let memoryTextView = UITextView().then{
        $0.backgroundColor = UIColor.ohsogo_Gray
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: kebabButton)
        title = "상세보기"
    }

    private let postID: Int
    private let viewModel: MemoryBookViewModel
    private var detail: MemoryDetailDTO?
    
    init(postID: Int) {
        self.postID = postID
        self.viewModel = MemoryBookViewModel(postRepository: DefaultPostRepository())
        super.init()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayouts() {
        setNavigationBar()
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func bind() {
        rx.viewWillAppear
            .take(1)
            .map {[weak self] _ -> Int? in
                return self?.postID
            }
            .compactMap { $0 }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        viewModel.detail
            .asObservable()
            .subscribe(onNext: { [weak self] detail in
                dump(detail)
                self?.detail = detail
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex{
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.collectionView.frame.height * 470 / 690))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(91), heightDimension: .estimated(38))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .continuous  // 가로 스크롤
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)  // 좌우 여백 설정
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(91), heightDimension: .estimated(38))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
                return section
                
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
                
                return section
                
            default:
                return nil
            }
        }
        return layout
    }
}


extension MemoryBookViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let detail = detail else { return 0 }
        switch section {
        case 0:
            return 1
        case 1:
            return detail.tags.count
        case 2:
            return detail.tags.count
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detail = detail else { return UICollectionViewCell() }

        let section = indexPath.section
        switch section {
        case 0:
            let cell: MemoryImageCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image(url: detail.imageURL)
            return cell
        case 1:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.tagLabel.text = detail.tags[indexPath.item].tagName
            return cell
        case 2:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.tagLabel.text = detail.tags[indexPath.item].tagName
            return cell
        case 3:
            let cell: TextViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.textView.text = detail.description
            return cell
        default:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
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
}
