import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            HomeViewBase()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            SearchView(searchTerm: "")
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            CartView()
                .tabItem {
                    Label("", systemImage: "cart")
                }
            ProfileView()
                .tabItem {
                    Label("", systemImage: "person.circle.fill")
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
                Image("home_logo_cropped")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider().padding(.horizontal)
            
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(1))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                    
                    Text("Trending Now")
                        .font(.custom("Arial", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                }
                
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
            
            Divider().padding(.horizontal)

            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(1))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    Text("Exclusive Collections")
                        .font(.custom("Arial", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                }
                
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
               // .font(.headline)
                .font(.custom("Arial", size: 15))
                .fontWeight(.bold)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                Text("LKR \(product.price)")
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


