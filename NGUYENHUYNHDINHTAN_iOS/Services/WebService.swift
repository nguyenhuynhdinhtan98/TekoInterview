//
//  WebService.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation

class Webservice {
    
    func getAllProducts(url: URL?) async throws -> [ProductModel] {
        
        guard let url = url else { return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let products: [ProductModel] = try JSONDecoder().decode([ProductModel].self, from: data)

        return products
        
    }
    
    
    func getAllColors(url: URL?) async throws -> [ColorModel] {
        
        guard let url = url else { return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let colors: [ColorModel] = try JSONDecoder().decode([ColorModel].self, from: data)

        return colors
        
    }

    
}
