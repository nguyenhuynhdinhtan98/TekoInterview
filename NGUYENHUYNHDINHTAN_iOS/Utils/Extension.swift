//
//  Extension.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import Foundation
import SwiftUI

extension Color {
    init?(name: String) {
        switch name {
        case "clear":
            self = .clear
        case "black":
            self = .black
        case "white":
            self = .white
        case "gray":
            self = .gray
        case "red":
            self = .red
        case "green":
            self = .green
        case "blue":
            self = .blue
        case "orange":
            self = .orange
        case "yellow":
            self = .yellow
        case "pink":
            self = .pink
        case "purple":
            self = .purple
        default:
            self = .clear
        }
    }
}
