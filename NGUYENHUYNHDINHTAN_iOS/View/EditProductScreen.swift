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
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Form(content: {
            Text("EDIT TEXT FIELDS:")
            
//            TextField("Enter name", text: productVM.name)
            //            TextField("Enter director", text: "")
            //            HStack {
            //                Text("Rating")
            //                Spacer()
            //                RatingView(rating: $productVM.rating)
            //            }
            //            DatePicker("Release Date", selection: $productVM.releaseDate)
            
            HStack {
                
                Spacer()
                Button("Save") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        })
    }
}

//struct DetailProductScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProductScreen(productVM: ProductViewModel(productModel: ProductModel(id: 1,name: "Laptop Dell Inspiron 13 5301" ,errorDescription: "Product error 101", sku: "210400693",image: "https://lh3.googleusercontent.com/C9h0wTjyE87-02b7RdbwpZvcLJwRDXoZBCtKXtwhB3TcAbffp7RQSHbihoEzf06PpgVp5peewwR-829KY7oMgoBuqxuKj7N-hw=w500-rw", color: 2), color: "Blue"))
//    }
//}
