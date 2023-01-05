//
//  HomeView.swift
//  NGUYENHUYNHDINHTAN_iOS
//
//  Created by Tân Nguyễn on 05/01/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var productVM = ProductListViewModel()
    
    var body: some View {
        List(productVM.productVM, id: \.id) { product in
            Text(product.name)
        })
        
        .task {
            await todoListVM.populateTodos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
