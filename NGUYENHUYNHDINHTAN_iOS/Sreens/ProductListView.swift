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
                        if product.id == productVM.productDisplayVM.last?.id {
                            loadNextPage(product)
                        }
                    }
                    if self.isLoading && product.id == productVM.productDisplayVM.last?.id && product.id != productVM.productVM.last?.id   {
                        Text("Loading ...")
                            .padding(.vertical)
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

extension ProductListView {
    func loadNextPage(_ item: ProductViewModel) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.currentPage += 1
            let moreItems = self.getMoreItems(page: self.currentPage, pageSize: self.pageSize)
            self.productVM.productDisplayVM.append(contentsOf: moreItems)
            self.isLoading = false
        }
    }
    
    private func getMoreItems(page: Int,
                              pageSize: Int) -> [ProductViewModel] {
        let maximum =  ((page * pageSize) + pageSize) - 1
        let nextItemIndexPage = (productVM.productVM.count - productVM.productDisplayVM.count) <= pageSize ? productVM.productVM.count - 1 : maximum
        print("productDisplayVM.count \(productVM.productDisplayVM.count)")
        print("pageSize \(pageSize)")
        print("page \(page)")
        print("maximum \(maximum)")
        print("nextItemIndexPage \(nextItemIndexPage)")
        let moreItems: [ProductViewModel] = Array(productVM.productDisplayVM.count..<nextItemIndexPage).map {
            print("Index \($0)")
            return productVM.productVM[$0]
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
