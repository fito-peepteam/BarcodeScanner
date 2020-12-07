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
}
