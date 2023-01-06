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
    
    @Published var productVM: [ProductViewModel] = []
    @Published var productDisplayVM: [ProductViewModel] = []
    private var color: [ColorModel] = []
    
    func getAllProduct() async {
        do {
            self.color = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
            let products = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
            self.productVM = products.map(ProductViewModel.init)
            self.productDisplayVM = productVM
        } catch {
            print(error)
        }
    }
    
    func getAllColor() async -> [ColorModel] {
        return try await Webservice().getAllColors(url: Constants.Urls.urlColors)
    }
    
}



struct ProductViewModel {
    
    fileprivate var product: ProductModel
    
    var id: Int {
        product.id ?? 0
    }
    
    var name: String {
        product.name ?? ""
    }
    
    var errorDescription: String {
        product.errorDescription ?? ""
    }
    
    
    var sku: String {
        product.sku ?? ""
    }
    
    var image: String {
        product.image ?? ""
    }
    
    var color: Int {
        product.color ?? 0
    }
}
