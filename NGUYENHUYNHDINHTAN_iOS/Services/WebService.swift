//
//  WebService.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
}

class Webservice {
    

    func getAllProducts(url: URL) async throws -> [ProductModel] {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let products = try? JSONDecoder().decode([ProductModel].self, from: data)
        
        return products ?? []
        
    }
    

    
}
