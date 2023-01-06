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

    func getAllProduct() async {
        async let colors = try await Webservice().getAllColors(url: Constants.Urls.urlColors)
        
        async let products = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
        
        do {
            let colorModels = try await colors
            self.productVM = try await products.map({ item in
                let color = colorModels.first(where: {$0.id == item.color})
                return ProductViewModel(productModel: item, color: color?.name ?? "")
            })
            productDisplayVM = productVM.prefix(10).map{$0}
        } catch {
            print(error)
        }
    }
}


struct ProductViewModel {
    
    fileprivate var productModel: ProductModel
    
    fileprivate var color: String
    
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
    
    var colorName: String {
        return color
    }
    
}
