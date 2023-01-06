//
//  ProductListView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productListVM = ProductListViewModel()
    @State private var isLoading: Bool = false
    @State private var currentPage: Int = 0
    private let pageSize: Int = 10
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(productListVM.productDisplayListVM, id: \.id) { product in
                    ProductItemView(product: product).onAppear {
                        if product.id == productListVM.productDisplayListVM.last?.id && product.id != productListVM.productListVM.last?.id && !isLoading  {
                            loadNextPage()
                        }
                    }
                }
                .task {
                    await productListVM.getAllProduct()
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
    func loadNextPage() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.currentPage += 1
            let moreItems = self.getMoreItems(pageSize: self.pageSize)
            self.productListVM.productDisplayListVM.append(contentsOf: moreItems)
            self.isLoading = false
        }
    }
    
    private func getMoreItems(
                              pageSize: Int) -> [ProductViewModel] {
        let currentIndex = productListVM.productDisplayListVM.count - 1
        let maximumIndex = productListVM.productListVM.count - 1
        let maximum =  currentIndex + pageSize
        let nextItemIndexPage = maximum >= maximumIndex ? maximumIndex : maximum
        let moreItems: [ProductViewModel] = Array(productListVM.productDisplayListVM.count...nextItemIndexPage).map { index in
            productListVM.productListVM[index]
        }
        return moreItems
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
