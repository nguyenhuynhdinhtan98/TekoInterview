//
//  ProductListView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productVM = ProductListViewModel()
    @State private var page: Int = 0
    private var pageSize: Int = 0
    
    var body: some View {
        NavigationView {
            List(productVM.productVM, id: \.id) { product in
                ProductItemView(product: product)
            }
            .task {
                await productVM.getAllProduct()
            }
        }
    }
}


struct ProductItemView: View {
    
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
//                Text(product.color).padding(4)
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
