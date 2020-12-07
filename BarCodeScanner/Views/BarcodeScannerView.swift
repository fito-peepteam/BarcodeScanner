//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Fito Toledano on 12/7/20.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $viewModel.scannedCode,
                            alertItem: $viewModel.alertItem)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
                Spacer()
                    .frame(height: 100)
                Label(viewModel.statusText, systemImage: "barcode.viewfinder")
                    .font(.title)
                Text(viewModel.barcodeText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(viewModel.barcodeTextColor)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title),
                      message: Text(alertItem.message),
                      dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
