//
//  ProductModel.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation


struct ProductModel: Decodable {
    var id: String?
    var errorDescription: String?
    var sku: String?
    var image: String?
    var color: Int?
}
