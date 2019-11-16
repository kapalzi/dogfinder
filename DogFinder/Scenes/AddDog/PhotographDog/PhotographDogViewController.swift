//
//  PhotographDogViewController
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit
import AVFoundation

class PhotographDogViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {

    //    var captureSession: AVCaptureSession?
    //    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    @IBOutlet weak var previewView: UIImageView!
    @IBOutlet var takePhotoBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    var capturedImage: UIImage?
    private let viewModel: PhotographDogViewModel = PhotographDogViewModel()

    let session = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    let sessionQueue = DispatchQueue(label: "session queue",
                                     attributes: [],
                                     target: nil)

    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoDeviceInput: AVCaptureDeviceInput!
    var setupResult: SessionSetupResult = .success

    enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.checkUserSession()
        self.checkAuthorization()
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        self.setupButtons()
        self.setupPreview()
        self.navigationController?.isToolbarHidden = true

        self.addTmpPinch()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillLayoutSubviews() {

        let orientation: UIDeviceOrientation = UIDevice.current.orientation

        switch (orientation) {
        case .portrait:
            previewLayer?.connection?.videoOrientation = .portrait
        case .landscapeRight:
            previewLayer?.connection?.videoOrientation = .landscapeLeft
        case .landscapeLeft:
            previewLayer?.connection?.videoOrientation = .landscapeRight
        default:
            previewLayer?.connection?.videoOrientation = .portrait
        }
    }

    func setupButtons() {

        let takePhotoImage = UIImage(named: "icons8-round")?.withRenderingMode(.alwaysTemplate)
        self.takePhotoBtn.setBackgroundImage(takePhotoImage, for: .normal)
        self.takePhotoBtn.contentMode = .scaleToFill
        self.takePhotoBtn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    func checkAuthorization() {

        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            break

        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [unowned self] granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })

        default:
            setupResult = .notAuthorized
        }
    }

    func setupPreview() {

        sessionQueue.async {
            switch self.setupResult {
            case .success:
                // Only start the session running if setup succeeded.
                DispatchQueue.main.async { [unowned self] in
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                    self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    self.previewLayer.frame = self.view.layer.bounds
                    self.previewView.layer.addSublayer(self.previewLayer)
                    self.session.startRunning()
                }

            case .notAuthorized:
                DispatchQueue.main.async { [unowned self] in
                    let changePrivacySetting = "AVCam doesn't have permission to use the camera, please change privacy settings"
                    let message = NSLocalizedString(changePrivacySetting, comment: "Alert message when the user has denied access to the camera")
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)

                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))

                    alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                            style: .`default`,
                                                            handler: { _ in
                                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }))

                    self.present(alertController, animated: true, completion: nil)
                }

            case .configurationFailed:
                DispatchQueue.main.async { [unowned self] in
                    let alertMsg = "Alert message when something goes wrong during capture session configuration"
                    let message = NSLocalizedString("Unable to capture media", comment: alertMsg)
                    let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)

                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                            style: .cancel,
                                                            handler: nil))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    private func configureSession() {
        if setupResult != .success {
            return
        }

        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo

        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?

            // Choose the back dual camera if available, otherwise default to a wide angle camera.
            let dualCameraDeviceType: AVCaptureDevice.DeviceType
            if #available(iOS 11, *) {
                dualCameraDeviceType = .builtInDualCamera
            } else {
                dualCameraDeviceType = .builtInDuoCamera
            }

            if let dualCameraDevice = AVCaptureDevice.default(dualCameraDeviceType, for: AVMediaType.video, position: .back) {
                defaultVideoDevice = dualCameraDevice
            } else if let backCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .back) {
                // If the back dual camera is not available, default to the back wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                defaultVideoDevice = frontCameraDevice
            }

            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)

            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput

            } else {
                print("Could not add video device input to the session")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Could not create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }

        // Add photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)

            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }

        session.commitConfiguration()
    }

    func captureImage() {

        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        if self.videoDeviceInput.device.isFlashAvailable {
            photoSettings.flashMode = .auto
        }

        if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
        }

        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard let data = photo.fileDataRepresentation(),
            let image =  UIImage(data: data)  else {
                return
        }
        self.capturedImage = image
        self.recognizeImage(image.rotate(radians: 270) ?? image)
    }

    func recognizeImage(_ image: UIImage) {

        self.viewModel.recognizeImage(image) { (results) in
            self.presentConfirmDog(results: results)
        }
    }

    func checkUserSession() {

        self.viewModel.checkUserSession {

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AuthHomeViewController") as! AuthHomeViewController
            self.navigationController?.present(self.createNavController(rootViewController: vc), animated: true, completion: nil)
        }
    }

    func presentConfirmDog(results: [DogPrediction]) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        vc.initViewModel(predictions: results, dogPhoto: self.capturedImage!)

        self.navigationController?.show(self.createNavController(rootViewController: vc), sender: nil)
    }

    func createNavController(rootViewController: UIViewController) -> UINavigationController {

        let navCont = UINavigationController(rootViewController: rootViewController)
        navCont.navigationBar.tintColor = #colorLiteral(red: 0.9567165971, green: 0.8978132606, blue: 0.7615829706, alpha: 1)
        navCont.navigationBar.barTintColor = #colorLiteral(red: 0.1609984934, green: 0.3689207435, blue: 0.305126965, alpha: 1)
        navCont.modalPresentationStyle = .fullScreen
        return navCont
    }

    @IBAction func takePhotoDidTap(_ sender: UIButton) {

        self.captureImage()
    }
    @IBAction func deleteDidTap(_ sender: UIButton) {

    }

    //tmp
    func addTmpPinch() {

        let tap: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        self.previewView.addGestureRecognizer(tap)
    }

    @objc func pinch() {
        SessionController.sharedInstance.logout()
        self.checkUserSession()
    }
}
