//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Fito Toledano on 12/7/20.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    static let sampleAlert = AlertItem(title: "Uh-Oh",
                                              message: "Sample lorem ipsum.",
                                              dismissButton: .default(Text("Ok")))
    
    static let invalidDeviceInput = AlertItem(title: "Uh-Oh",
                                              message: "Something in the camera went wrong. Please, try again.",
                                              dismissButton: .default(Text("Ok")))
    
    static let invalidScannedType = AlertItem(title: "Uh-Oh",
                                              message: "The scanned value is not valid. This app only scans EAN-9 and EAN-13 barcodes.",
                                              dismissButton: .default(Text("Ok")))
}
