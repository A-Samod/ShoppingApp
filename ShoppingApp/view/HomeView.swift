import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            HomeViewBase()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SearchView(searchTerm: "")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        .navigationBarHidden(true)
        .accentColor(.primary)
    }
}

struct HomeViewBase: View {
    @ObservedObject var viewModel = ProductsViewModel()
    
    var body: some View {
        ScrollView {
            VStack{
                Image("banana")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text("Welcome to orel !")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                
            }
            
            VStack {
                Text("Featured Products")
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(viewModel.products) { product in
                            ProductTileView(product: product)
                                .frame(width: 200)
                        }
                    }
                    .padding()
                }
                .frame(height: 300)
                
            }
            VStack {
                Text("latets Products")
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(viewModel.products) { product in
                            ProductTileView(product: product)
                                .frame(width: 200)
                        }
                    }
                    .padding()
                }
                .frame(height: 300)
                
            }
        }
    }
}

struct ProductTileView: View {
    @State private var showDetail = false
    let product: Product
    
    var body: some View {
        VStack {
            Button(action: {
                showDetail.toggle()
            }) {
                AnimatedImage(url: URL(string: product.image))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(10)
            }
            Text(product.name)
                .font(.headline)
            Text("$\(product.price)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
        .sheet(isPresented: $showDetail) {
            ProductDetailView(product: product)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


