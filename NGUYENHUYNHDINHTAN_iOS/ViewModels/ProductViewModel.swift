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
            guard let url = Constants.Urls.urlProducts else {
                throw NetworkError.badUrl
            }
            let products = try await Webservice().getAllProducts(url: url)
            self.productVM = products.map(ProductListViewModel.init)
        
            }
        } catch {
            print(error)
        }
    }
}

struct ProductViewModel {
    
    let product: ProductModel
    
    var id: String {
        product.id ?? ""
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
