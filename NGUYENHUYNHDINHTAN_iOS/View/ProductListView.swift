//
//  ProductListView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productVM = ProductListViewModel()
    @State private var isLoading: Bool = false
    @State private var currentPage: Int = 0
    private let pageSize: Int = 10
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(productVM.productDisplayVM, id: \.id) { product in
                    ProductItemView(product: product).onAppear {
                        if product.id == productVM.productDisplayVM.last?.id && product.id != productVM.productVM.last?.id && !isLoading  {
                            loadNextPage(product)
                        }
                    }
                }
                .task {
                    await productVM.getAllProduct()
                }
                if self.isLoading {
                    ProgressView().background(.clear)
                        .padding(.vertical).frame(maxWidth: .infinity,maxHeight: 50,alignment: .center)
                }
            }
            .navigationBarTitle(Text("Product")).toolbar {
                Button("Submit") {
                    
                }
            }
        }
    }
}

extension ProductListView {
    func loadNextPage(_ item: ProductViewModel) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.currentPage += 1
            let moreItems = self.getMoreItems(pageSize: self.pageSize)
            self.productVM.productDisplayVM.append(contentsOf: moreItems)
            self.isLoading = false
        }
    }
    
    private func getMoreItems(
                              pageSize: Int) -> [ProductViewModel] {
        let maximum =  productVM.productDisplayVM.count - 1 + pageSize
        let nextItemIndexPage = maximum >= productVM.productVM.count - 1 ? productVM.productVM.count - 1 : maximum
        let moreItems: [ProductViewModel] = Array(productVM.productDisplayVM.count...nextItemIndexPage).map { index in
            productVM.productVM[index]
        }
        return moreItems
    }
    
}



struct ProductItemView: View {
    @State private var page: Int = 0
    
    var product: ProductViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.image))
                .scaledToFit()
                .frame(width: 100, height: 100).cornerRadius(16)
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name).padding(4)
                Text(product.errorDescription).padding(4)
                Text(product.sku).padding(4)
                if !product.colorName.isEmpty {
                    HStack {
                        Text("\(product.colorName)")
                        Rectangle()
                            .fill(Color(name: product.colorName ) ?? .clear)
                            .frame(width: 25, height: 25).padding(4)
                    }
                }
                NavigationLink(destination: DetailProductScreen(productVM: product)) {
                    Image(systemName: "square.and.pencil") .font(.system(size: 20, weight: .bold)).frame(width: 35, height: 35).foregroundColor(.red)
                }.buttonStyle(.plain)
                
            }
        }
        .background(Color.clear)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
