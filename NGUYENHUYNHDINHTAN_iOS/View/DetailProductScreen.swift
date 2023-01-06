//
//  EditProductScreen.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 06/01/2023.
//

import Foundation
import SwiftUI

struct DetailProductScreen: View {
    

    
    @StateObject private var productListVM: ProductListViewModel = ProductListViewModel()
    
   
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var productVM: ProductViewModel
    @State private var isValidName: Bool = false
    @State private var isValidSku: Bool = false
    @State private var showingSheet = false
    
    
    var body: some View {
        Form(content: {
            CustomTextField(hint: "Enter name",text: productVM.name, characterLimit: 50, typeErrorMessage: .maxLengthName , isValid: $isValidName)
            
            CustomTextField(hint: "Enter sku", text: productVM.sku, characterLimit: 20, typeErrorMessage: .maxLengthSKU , isValid: $isValidSku)
            
            Button("Color \(productVM.colorName.isEmpty ? "clear" : productVM.colorName.lowercased() )") {
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
        }).onAppear{
            Task {
                await productListVM.getAllColor()
            }
        }.sheet(isPresented: $showingSheet) {
        
            SheetColorView(colorListVM: productListVM.colorVM,productVM: $productVM)
        }
    }
}

struct SheetColorView: View {
    let colorListVM: [ColorViewModel]
    @Binding var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(colorListVM, id: \.id) { item in
            Button(action: {
                let color = colorListVM.first(where: {$0.name.lowercased() == productVM.colorName.lowercased()})
                dismiss()
            }) {
                Text(item.name).frame(maxWidth: .infinity)
            }
            .background(Color(name: item.name ) ?? .clear).frame(maxWidth: .infinity)
        }
    }
}
