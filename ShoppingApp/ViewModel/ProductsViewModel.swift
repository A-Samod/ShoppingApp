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
        guard let url = URL(string: "http://localhost:4000/product/items") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                print("productResponse +++>>>",  data)
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                
                print("productResponse +++>>>",  productResponse)
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
