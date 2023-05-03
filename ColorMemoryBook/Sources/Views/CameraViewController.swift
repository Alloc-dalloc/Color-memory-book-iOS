//
//  File.swift
//  ColorMemoryBook
//
//  Created by 김윤서 on 2023/04/14.
//

import AVFoundation

class CameraViewController: BaseViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    let videoDataOutput = AVCaptureVideoDataOutput()

    private let buttons = [ColorFilterButton(color: .red), ColorFilterButton(color: .green), ColorFilterButton(color: .blue)]

    private let titleBackgroundView = UIView().then{
        $0.backgroundColor = .black
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "카메라"
        $0.textColor = .white
    }
    
    private let dismissButton = UIButton().then{
        $0.setImage(UIImage(named: "dismiss_button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    
    private let previewBackgroundView = UIView().then{
        $0.backgroundColor = .black
    }
    
    private lazy var colorStackView = UIStackView().then {
        $0.alignment = .center 
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 40
        $0.backgroundColor = UIColor.ohsogo_Charcol
        $0.layer.cornerRadius = 20
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    private let captureBackgroundView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.9
    }
    
    private let galleryButton = UIButton().then{
        $0.setImage(UIImage(named: "gallery_button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    private let captureButton = UIButton().then{
        $0.setImage(UIImage(named: "capture_button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    private let capturedImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCaptureSession()
        dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
    }
    
    private func setupColorFilterButtons(){
        for button in buttons{
            button.addTarget(self, action: #selector(colorFilterButtonDidTap), for: .touchUpInside)
            colorStackView.addArrangedSubview(button)
        }
    }
    
    override func setLayouts() {
        
        self.view.addSubviews(previewBackgroundView,titleBackgroundView, colorStackView, captureBackgroundView)
        titleBackgroundView.addSubviews(titleLabel, dismissButton)
        captureBackgroundView.addSubviews(galleryButton, captureButton)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        titleBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(44)
        }
        
        previewBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleBackgroundView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        setupColorFilterButtons()
        
        colorStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleBackgroundView.snp.bottom).offset(14)
            $0.width.equalTo(226)
            $0.height.equalTo(38)
        }
        
        galleryButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(36)
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        
        captureButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(66)
            $0.height.equalTo(66)
        }
        
        captureBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(139)
        }
    }
    
    
    @objc private func colorFilterButtonDidTap(_ sender: UIButton){
        for button in buttons {
            if button.isSelected && button == sender {
                button.isSelected = false
            } else {
                button.isSelected = (button == sender)
            }
        }
    }
    
    @objc private func dismissButtonDidTap(){
        self.dismiss(animated: true)
    }
    
    private func setupCaptureSession() {
        captureSession.beginConfiguration()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
        captureSession.addOutput(videoDataOutput)
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("카메라가 사용 불가능합니다.")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(photoOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(photoOutput)
                setupPreview()
            }
        } catch let error {
            print("캡쳐 세션을 설정할 수 없습니다. 오류: \(error.localizedDescription)")
        }
            captureSession.commitConfiguration()
        }
    
    
    private func setupPreview() {
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.videoOrientation = .portrait
            previewBackgroundView.layer.addSublayer(previewLayer)
        
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                DispatchQueue.main.async {
                    self.previewLayer.frame = self.previewBackgroundView.bounds
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate{
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("이미지 데이터를 가져올 수 없습니다.")
            return
        }
        let image = UIImage(data: imageData)
        capturedImageView.image = image
        capturedImageView.isHidden = false
        capturedImageView.isHidden = true
    }
}


#if DEBUG
import SwiftUI

struct CameraViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewController = CameraViewController()
        return viewController.getPreview()
    }
}
#endif