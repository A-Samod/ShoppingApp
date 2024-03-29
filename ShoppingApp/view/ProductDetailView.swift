import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @State private var quantity = 1
    @State var selectedSize: String = "M"
    @State var goTOCart = false
    let sizes = ["XS", "S", "M", "L", "XL"]
    @State private var showAlert = false
    
    let product: Product
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    AnimatedImage(url: URL(string: product.image))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(product.category)
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("Color: \(product.color)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        HStack {
                            ForEach(sizes, id: \.self) { size in
                                Button(action: {
                                    selectedSize = size
                                    print(selectedSize)
                                }) {
                                    Text(size)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(selectedSize == size ? Color.blue : Color.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Qty:")
                                .foregroundColor(.black)
                            Button(action: {
                                if quantity > 1 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                            }
                            Text("\(quantity)")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Button(action: {
                                quantity += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        .foregroundColor(.blue)
                        
                        Text("Price: LKR \(totalPrice, specifier: "%.2f")")
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .foregroundColor(.black)
                        
                        Text("Description:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(product.description)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
            Button(action: {
                goTOCart = true
                let newItem = CartItem(cartId: UUID(), pid: product.id, name: product.name, price: totalPrice, quantity: quantity, imageURL: product.image, size: selectedSize, eachPrice: product.price)
                cartItems.append(newItem)
                showAlert = true
            }, label: {
                Text("Add to Cart")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
            })
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text("Item added to cart successfully"), dismissButton: .default(Text("OK")))
            }
            .disabled(goTOCart)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
        }) {
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
