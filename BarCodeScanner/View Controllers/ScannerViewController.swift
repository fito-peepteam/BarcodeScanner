//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by Fito Toledano on 12/7/20.
//

import UIKit
import AVFoundation

protocol ScannerViewControllerDelegate: class {
    func didFind(barcode: String)
    func didSurfaceError(error: CameraError)
}

final class ScannerViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: ScannerViewControllerDelegate?
    
    init(scannerDelegate: ScannerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            delegate?.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print(metadataObjects[0])
        guard
            let object = metadataObjects.first,
            let machineReadableObject = object as? AVMetadataMachineReadableCodeObject,
            let barcode = machineReadableObject.stringValue
              else {
                delegate?.didSurfaceError(error: .invalidScannedValue)
                return
              }
        captureSession.stopRunning()
        delegate?.didFind(barcode: barcode)
    }
}
