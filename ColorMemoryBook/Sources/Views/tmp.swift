import UIKit
import AVFoundation
import SnapKit

class CustomCameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var previewView = UIView()
    var imageView = UIImageView()
    var captureButton = UIButton()
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 미리보기 뷰
        view.addSubview(previewView)
        previewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 이미지 뷰
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 촬영 버튼
        view.addSubview(captureButton)
        captureButton.backgroundColor = .white
        captureButton.setTitle("촬영", for: .normal)
        captureButton.setTitleColor(.black, for: .normal)
        captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        captureButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("카메라가 사용 불가능합니다.")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        } catch let error {
            print("캡쳐 세션을 설정할 수 없습니다. 오류: \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let previewLayer = videoPreviewLayer {
            previewLayer.videoGravity = .resizeAspect
            previewLayer.connection?.videoOrientation = .portrait
            previewView.layer.addSublayer(previewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
                
                DispatchQueue.main.async {
                    previewLayer.frame = self.previewView.bounds
                }
            }
        }
    }
    
    @objc func captureButtonTapped() {
        let settings = AVCapturePhotoSettings()
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("이미지 데이터를 가져올 수 없습니다.")
            return
        }
        
        let image = UIImage(data: imageData)
        imageView.image = image
        imageView.isHidden = false
        videoPreviewLayer.isHidden = true
        
    }
}
