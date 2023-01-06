//
//  EditProductScreen.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 06/01/2023.
//

import Foundation
import SwiftUI

struct DetailProductScreen: View {
    
    let productVM: ProductViewModel
    
    @StateObject private var productListVM: ProductListViewModel = ProductListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValidName: Bool = false
    @State private var isValidSku: Bool = false
    @State private var showingSheet = false
    
    var body: some View {
        Form(content: {
            CustomTextField(hint: "Enter name",text: productVM.name, characterLimit: 50, typeErrorMessage: .maxLengthName , isValid: $isValidName)
            
            CustomTextField(hint: "Enter sku", text: productVM.sku, characterLimit: 20, typeErrorMessage: .maxLengthSKU , isValid: $isValidSku)
            
            Button("Color \(productVM.colorName.isEmpty ? "Clear" : productVM.colorName )") {
                showingSheet = true
            }
            HStack {
                Spacer()
                Button("Save") {
                    if isValidSku && isValidName {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
        }).sheet(isPresented: $showingSheet) {
            SheetColorView()
        }
    }
}

struct SheetColorView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}
