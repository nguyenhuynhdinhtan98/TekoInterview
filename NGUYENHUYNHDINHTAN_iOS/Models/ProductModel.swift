//
//  ProductModel.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation


struct ProductModel: Codable {
    var id: Int?
    var name: String?
    var errorDescription: String?
    var sku: String?
    var image: String?
    var color: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case errorDescription = "errorDescription"
        case sku = "sku"
        case image = "image"
        case color = "color"
    }
    
}
