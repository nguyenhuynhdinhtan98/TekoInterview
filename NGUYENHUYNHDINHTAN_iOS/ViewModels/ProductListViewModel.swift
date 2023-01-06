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
    
    @Published var productDisplayListVM: [ProductViewModel] = []
    
    @Published var productListVM: [ProductViewModel] = []

    @Published var colorVM: [ColorViewModel] = []
    
    func getAllProduct() async {
        async let colors = try await Webservice().getAllColors(url: Constants.Urls.urlColors)
        
        async let products = try await Webservice().getAllProducts(url: Constants.Urls.urlProducts)
        
        do {
            self.colorVM = try await colors.map(ColorViewModel.init)
            
            self.productListVM = try await products.map({ item in
                let color = colorVM.first(where: {$0.id == item.color})
                return ProductViewModel(productModel: item, color: color?.name ?? "")
            })
            
            self.productDisplayListVM = productListVM.prefix(10).map{$0}
        } catch {
            
            print(error)
            
        }
    }
    
    func getAllColor() async {
      
        do {
            let colors =  try await Webservice().getAllColors(url: Constants.Urls.urlColors)
            
            self.colorVM =  colors.map(ColorViewModel.init)

        } catch {
            
            print(error)
            
        }
    }
    
    
    func getColorByName(colorName: String) -> ColorViewModel {
        return colorVM.first(where: {$0.name.lowercased() == colorName.lowercased()}) ?? ColorViewModel(color: ColorModel(id: 0, name: "Clear"))
    }
    
}

struct ColorViewModel {
    
    fileprivate var color: ColorModel
    
    var id: Int {
        color.id ?? 0
    }
    
    var name: String {
        color.name ?? ""
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
