//
//  HomeViewController.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/12.
//

import PhotosUI
import BackgroundRemoval

import RxCocoa
import RxSwift

class HomeViewController: BaseViewController{
    
    let viewModel = MemoryListViewModel(searchRepository: DefaultSearchRepository())
    
    
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
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floating_blue"), for: .normal)
        button.setImage(UIImage(named: "floating_black"), for: .selected)
        button.addTarget(self, action: #selector(floatingButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let colorFilterButton = HiddenButton(title: "컬러 필터")
    private let memoryRecordButton = HiddenButton(title: "메모리 기록")
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: .zero, left: .zero, bottom: 60, right: .zero)
        collectionView.delegate = self
        collectionView.register(cell: MemoryBookCell.self)
        
        return collectionView
    }()

    private let listPublisher = PublishSubject<[MemoryDTO]>()
    private let reload = PublishSubject<Void>()

    private var list: [MemoryDTO] = [] {
        didSet {
            listPublisher.onNext(list)
        }
    }
    
    override func setLayouts() {
        self.view.addSubviews(tagSearchTextField, collectionView, floatingButton, colorFilterButton, memoryRecordButton)
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
        
        memoryRecordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-10)
        }
        
        colorFilterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(memoryRecordButton.snp.top).offset(-10)
        }
    }
    
    override func setProperties() {
        setNavigationBar()
        setTagSearchTextField()
        colorFilterButton.addTarget(self, action: #selector(colorFilterButtonDidTap), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        memoryRecordButton.addTarget(self, action: #selector(memoryRecordButtonDidTap), for: .touchUpInside)
        
    }
    
    override func bind() {
        reload
            .debug()
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        rx.viewWillAppear
            .take(1)
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)

        tagSearchTextField.rx.text
            .skip(1)
            .compactMap { $0 }
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchTextSubject)
            .disposed(by: disposeBag)

        viewModel.list
            .asObservable()
            .subscribe(onNext: { [weak self] list in
                self?.list = list
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        listPublisher
            .bind(to: collectionView.rx.items(cellIdentifier: "MemoryBookCell", cellType: MemoryBookCell.self)) { row, memory, cell in
                cell.tag = memory.id
                cell.configure(with: memory.imageUrl)
            }
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let vc = MemoryBookViewController(postID: self.list[indexPath.item].id)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
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
    }
    
    @objc private func floatingButtonDidTap(_ sender: UIButton){
        floatingButton.isSelected.toggle()
        colorFilterButton.isHidden = !sender.isSelected
        memoryRecordButton.isHidden = !sender.isSelected
    }
    
    @objc private func colorFilterButtonDidTap(){
        let cameraVC = CameraViewController()
        cameraVC.modalPresentationStyle = .fullScreen
        self.present(cameraVC, animated: true)
    }
    
    @objc private func clearButtonDidTap(){
        self.tagSearchTextField.text = ""
    }
    
    @objc private func memoryRecordButtonDidTap(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: 211)
    }
}

extension HomeViewController: PHPickerViewControllerDelegate{
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) {[weak self] data, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        guard let removeBackgroundImage = BackgroundRemoval().removeBackground(image: image, maskOnly: false).pngData() else { return }
                        let nextVC = RecordMemoryViewController(imageData: removeBackgroundImage)
                        nextVC.delegate = self
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}

extension HomeViewController: RecordMemoryViewControllerDelegate {
    func didUploaded(_ viewController: RecordMemoryViewController) {
        self.reload.onNext(())
    }
}

#if DEBUG
import SwiftUI
import Moya

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = HomeViewController()
        return viewController.getPreview()
    }
}

#endif
