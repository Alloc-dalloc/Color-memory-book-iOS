//
//  File.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/14.
//

import AVFoundation

class CameraViewController: BaseViewController {
    
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    let videoDataOutput = AVCaptureVideoDataOutput()

    let buttons = [ColorFilterButton(color: .red), ColorFilterButton(color: .green), ColorFilterButton(color: .blue)]

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
    
    private func setupColorFilterButton(){
        for button in buttons {
            button.addTarget(self, action: #selector(colorFilterButtonDidTap), for: .touchUpInside)
            colorStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func colorFilterButtonDidTap(_ sender: UIButton){
        for button in buttons {
            if button == sender {
                button.layer.borderColor = UIColor.white.cgColor
            } else {
                button.layer.borderColor = UIColor.clear.cgColor
            }
            
            if button.isSelected && button == sender {
                button.layer.borderColor = UIColor.clear.cgColor
                button.isSelected = false
            } else {
                button.isSelected = (button == sender)
            }
        }
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

extension CameraViewController: AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    
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
    
    func applyFilterToImage(_ image: CIImage) -> CIImage? {
        let hueValue: CGFloat = 0.5 // 색상 값 (0 ~ 1)
        
        // CIHueAdjust 필터 생성
        guard let hueFilter = CIFilter(name: "CIHueAdjust") else { return nil }
        hueFilter.setValue(image, forKey: kCIInputImageKey)
        hueFilter.setValue(hueValue * CGFloat.pi, forKey: kCIInputAngleKey) // 180도 회전
        
        // 필터 적용
        guard let filteredImage = hueFilter.outputImage else { return nil }
        return filteredImage
    }

    // captureOutput(_:didOutput:from:) 메서드 내에서 필터 적용 및 화면에 표시
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let image = CIImage(cvImageBuffer: pixelBuffer)
        
        // 필터 적용
        if let filteredImage = applyFilterToImage(image) {
            // 필터가 적용된 이미지를 화면에 표시
            let context = CIContext()
            if let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
                let filteredUIImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    // UI 업데이트는 메인 스레드에서 수행되어야 함
                    self.previewLayer.contents = filteredUIImage.cgImage // imageView에 이미지 표시
                }
            }
        }
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
