//
//  ProductListView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productVM = ProductListViewModel()

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(productVM.productDisplayVM, id: \.id) { product in
                    ProductItemView(product: product).onAppear {
                        if product.id ==  productVM.productDisplayVM.last?.id {
                            productVM.loadNextPage(product)
                        }
                    }
                }
                .task {
                    await productVM.getAllProduct()
                }
            }
            .navigationBarTitle(Text("Product")).toolbar {
                Button("Submit") {
                    
                }
            }
        }
    }
}


struct ProductItemView: View {
    @State private var page: Int = 0
    
    var product: ProductViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.image))
                .scaledToFill()
                .frame(width: 100, height: 100).cornerRadius(16)
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name).padding(4)
                Text(product.errorDescription).padding(4)
                Text(product.sku).padding(4)
                if product.color != .clear {
                    HStack {
                        Text("Color:")
                        Rectangle()
                            .fill(product.color)
                            .frame(width: 25, height: 25).padding(4)
                    }
                }
                Image(systemName: "square.and.pencil") .font(.system(size: 20, weight: .bold)).frame(width: 35, height: 35).foregroundColor(.red)
            }
            
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(5)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
