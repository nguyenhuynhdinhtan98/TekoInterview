//
//  ProductItemView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 06/01/2023.
//

import Foundation
import SwiftUI

struct ProductItemView: View {
    @State private var page: Int = 0
    
    var product: ProductViewModel
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            AsyncImage(url: URL(string: product.image))
                .scaledToFit()
                .frame(width: 100, height: 100).cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(product.name).padding(4)
                
                Text(product.errorDescription).padding(4)
                
                Text(product.sku).padding(4)
                
                if !product.colorName.isEmpty {
                    
                    HStack {
                        
                        Text("\(product.colorName)")
                        
                        Rectangle()
                            .fill(Color(name: product.colorName ) ?? .clear)
                            .frame(width: 25, height: 25).padding(4)
                        
                    }
                }
                
                NavigationLink(destination: DetailProductScreen(productVM: product)) {
                    
                    Image(systemName: "square.and.pencil") .font(.system(size: 20, weight: .bold)).frame(width: 35, height: 35).foregroundColor(.red)
                    
                }.buttonStyle(.plain)
            }
        }
        .background(Color.clear)
    }
}
