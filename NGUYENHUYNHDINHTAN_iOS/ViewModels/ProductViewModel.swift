//
//  ProductListViewModel.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation
import SwiftUI


@MainActor
class ProductListViewModel: ObservableObject {
    
    
    @Published var productDisplayVM: [ProductViewModel] = []
    
    var productVM: [ProductViewModel] = []
    
    private var currentPage: Int = 0
    private var pageSize: Int = 0
    
    func getAllProduct() async {
        async let colors = try await Webservice().getAllColors(url: Constants.Urls.urlColors)
        
        async let products = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
        
        do {
            let colorModels = try await colors
            self.productVM = try await products.map({ item in
                ProductViewModel(productModel: item, colors: colorModels)
            })
            pageSize = productVM.count
            productDisplayVM = productVM
        } catch {
            print(error)
        }
    }
    
    func loadNextPage(_ item: ProductViewModel) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.page += 1
            let moreItems = self.getMoreItems(page: self.page, pageSize: self.pageSize)
            self.productDisplayVM.append(contentsOf: moreItems)
        }
    }
    
    private func getMoreItems(page: Int,
                              pageSize: Int) -> [ProductViewModel] {
        let maximum = ((page * pageSize) + pageSize) - 1
        let moreItems: [ProductViewModel] = Array(productDisplayVM.count...maximum).map {
//            print($0)
//            productVM[$0]
        }
        return moreItems
    }
    
    
}


struct ProductViewModel {
    
    fileprivate var productModel: ProductModel
    
    fileprivate var colors: [ColorModel]
    
    var id: Int {
        productModel.id ?? 0
    }
    
    var name: String {
        productModel.name ?? ""
    }
    
    var errorDescription: String {
        productModel.errorDescription ?? ""
    }
    
    
    var sku: String {
        productModel.sku ?? ""
    }
    
    var image: String {
        productModel.image ?? ""
    }
    
    var color: Color {
        let color = colors.first(where: {$0.id == productModel.color})
        return Color(name: color?.name ?? "") ?? Color.clear
    }
    
}
