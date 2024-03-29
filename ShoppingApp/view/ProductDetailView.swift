import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @State private var quantity = 1
    @State var selectedSize: String = "M"
    @State var selectedColor: String = ""
    @State var goTOCart = false
    let sizes = ["XS", "S", "M", "L", "XL"]
    let colors = ["Red", "Green", "Blue", "Yellow", "Black"]
    @State private var showAlert = false
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, -20)
                .padding(.horizontal)
            
            AnimatedImage(url: URL(string: product.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200) // Adjusted height here
                .cornerRadius(20)
                .padding()
            
            Text("Description:")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text(product.description)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            Spacer()
            Divider()
            VStack(alignment: .leading) {
                Text("Options:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                LazyHStack(spacing: 20) {
                    VStack {
                        Text("Sizes:")
                            .font(.subheadline)
                        Picker(selection: $selectedSize, label: Text("Sizes")) {
                            ForEach(sizes, id: \.self) { size in
                                Text(size)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .background(Color.gray)
                        .frame(height: 40)
                    
                    VStack {
                        Text("Colors:")
                            .font(.subheadline)
                        Picker(selection: $selectedColor, label: Text("Colors")) {
                            ForEach(colors, id: \.self) { color in
                                Text(color)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal)
                }
                
                QuantityView(quantity: $quantity)
                    .padding(.top)
            }
            .padding(.vertical)
            
            Spacer()
            
            Button(action: {
                goTOCart = true
                let newItem = CartItem(cartId: UUID(), pid: product.id, name: product.name, price: totalPrice, quantity: quantity, imageURL: product.image, size: selectedSize, eachPrice: product.price)
                cartItems.append(newItem)
                showAlert = true
            }, label: {
                Text(goTOCart ? "Added to Cart" : "Add to Cart")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(goTOCart ? Color.gray : Color.black)
                    .cornerRadius(15)
            })
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("Cart loaded! 🛒 Happy browsing!"), dismissButton: .default(Text("OK")))
            }
            .disabled(goTOCart)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {}) {
            Image(systemName: "arrow.left")
                .foregroundColor(.blue)
        }
        )
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
    }
    
    var totalPrice: Double {
        if let priceValue = Double(product.price) {
            return priceValue * Double(quantity)
        } else {
            return 0
        }
    }
}

struct QuantityView: View {
    @Binding var quantity: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            HStack(spacing: 8) {
                Text("Quantity:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    Image(systemName: "minus")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Text("\(quantity)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(1)
                
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1))
            
            Spacer()
        }
    }
}



