//
//  CameraViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import UIKit
import AVFoundation
import Vision

final class CameraViewController: UIViewController {
    
    private var viewModel: SearchViewModel!
    private var componentsArray: [String] = []
    private var captureSession = AVCaptureSession()
    private var network = ProductsNetwork()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var name: String?
    
    private var selectedComponent: String = ""
    //FIXME: - One is to be deleted
    var didGetComponent: ((String) -> Void)?
    var didGetProduct: (([String]) -> Void)?
    
    private lazy var okBarButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(selectComponent))
    private lazy var cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelModal))

    private let belowView = ViewBuilder()
        .setBackgroundColor(with: .clear)
        .build()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = true
        picker.backgroundColor = .systemGray5
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        launchCamera()
    }
    
    private func bind(to: SearchViewModel){
        viewModel.didShowHidePickerView = {
            self.showHidePickerView()
        }
        
        viewModel.didPickerViewReloadAllComponents = {
            self.pickerView.reloadAllComponents()
        }
        
        viewModel.didPresentAlert = { errorMessage in
            self.showAlert(error: errorMessage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    private func showHidePickerView() {
        if pickerView.isHidden == true {
            pickerView.isHidden = false
            okBarButton.isEnabled = true
            cancelBarButton.isEnabled = true
        } else {
            captureSession.startRunning()
            pickerView.isHidden = true
            okBarButton.isEnabled = false
            cancelBarButton.isEnabled = false
        }
    }
    
    @objc private func cancelModal() {
        if pickerView.isHidden == true {
            self.dismiss(animated: true)
        } else {
            captureSession.startRunning()
            okBarButton.isEnabled = false
            pickerView.isHidden = true
        }
    }
    
    @objc private func selectComponent() {
        viewModel.updateComponent(component: selectedComponent)
        pickerView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Picker View Management
extension CameraViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.componentsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = viewModel.componentsArray[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedComponent = viewModel.componentsArray[row]
    }
}

// MARK: - Capture Video Data Management
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate {
    private func launchCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            
        } else {
            failed()
            return
        }
        
        captureSession.startRunning()
        captureSession.sessionPreset = .high
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    private func found(code: String) {
        viewModel.fetchProducts(with: code)
    }
    
    private func showAlert(error: Error) {
        let alert = UIAlertController(title: "Code not recognized", message: "\(error)", preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okayButton)
        self.present(alert, animated: true)
    }
    
    private func failed() {
        alert(message: "Your device does not support scanning a code from an item. Please use a device with a camera.", title: "Scanning not supported")
    }
}

// MARK: - User Interface Configuration
extension CameraViewController {
    
    private func setupUI() {
        title = "Camera"
        navigationItem.rightBarButtonItem = okBarButton
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.leftBarButtonItem?.tintColor = .label
        view.backgroundColor = .systemGray5
        okBarButton.isEnabled = false
        
        view.addSubview(belowView)
       
        belowView.addSubview(pickerView)

        belowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        belowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        belowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        belowView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        pickerView.centerXAnchor.constraint(equalTo: belowView.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: belowView.centerYAnchor).isActive = true
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill

        belowView.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds

        belowView.clipsToBounds = true
        belowView.layer.cornerRadius = 15.0
        belowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
