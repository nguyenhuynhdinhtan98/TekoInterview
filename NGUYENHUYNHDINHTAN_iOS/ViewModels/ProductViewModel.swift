//
//  ProductListViewModel.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation


@MainActor
class ProductListViewModel: ObservableObject {
    
    @Published var productVM: [ProductViewModel] = []
    
    func getAllProduct() async {
        do {
            let products = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
            self.productVM = products.map(ProductViewModel.init)
        } catch {
            print(error)
        }
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
