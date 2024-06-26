//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-28.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        guard let url = URL(string: "https://shoppingapp-backend-ww3a.onrender.com/product/items") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.products = productResponse.data
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                print("error ====>>>", error)
            }
        }.resume()
    }
}
