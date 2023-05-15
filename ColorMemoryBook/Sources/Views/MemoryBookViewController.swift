//
//  MemoryBookViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/05/04.
//

import UIKit


class MemoryBookViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: .zero, left: .zero, bottom: 60, right: .zero)
        collectionView.register(cell: MemoryBookCell.self)
        return collectionView
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
    
    private let tagLabel = UILabel().then{
        $0.text = "태그"
    }
    
    private let memoLabel = UILabel().then{
        $0.text = "메모"
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: kebabButton)
        title = "상세보기"
    }
    
    
    override func setLayouts() {
        setNavigationBar()

        self.view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height) //질문

        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.scrollView.addSubviews( memoryImageView, tagLabel, memoLabel)//memoryTextView
        
        memoryImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(470)
            $0.width.equalTo(scrollView.snp.width)
            /*
             
             일반적으로 leading과 trailing만 설정하면, 가로에 대한 오토레이아웃은 잡히게 됩니다. 그러나 이미지 뷰의 contentMode에 따라서, 이미지 뷰가 실제로 가로 폭을 채우는지 여부가 결정될 수 있습니다.

             예를 들어, 이미지 뷰의 contentMode가 scaleAspectFit인 경우, 이미지는 가로 세로 비율을 유지하면서 이미지 뷰에 꽉 차도록 확대/축소되기 때문에, leading과 trailing만으로는 이미지 뷰의 가로 폭이 제한될 수 있습니다.

             따라서, 이미지 뷰의 contentMode에 따라서 width를 추가적으로 설정해주어야 할 수도 있습니다.
             */
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalTo(memoryImageView.snp.bottom).offset(14)
        }
    }
    
    override func setProperties() {
    }
}

extension MemoryBookViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 1:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 2:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case 3:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        default:
            let cell: TagCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: 211)
    }
}



#if DEBUG
import SwiftUI

struct MemoryBookViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = MemoryBookViewController()
        return viewController.getPreview()
    }
}

#endif
