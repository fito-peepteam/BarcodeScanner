//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Fito Toledano on 12/7/20.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var barcodeText: String {
        scannedCode.isEmpty ? "Nothing yet" : scannedCode
    }
    
    var barcodeTextColor: Color {
        scannedCode.isEmpty ? .gray : .green
    }
    
    var statusText: String {
        scannedCode.isEmpty ? "Scanning" : "Scanned barcode"
    }
}
