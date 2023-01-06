//
//  ColorModel.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation

struct ColorModel: Decodable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

