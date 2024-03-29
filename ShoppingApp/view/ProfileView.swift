import SwiftUI

struct ProfileView: View {
    @State private var isEditing = false
    @State private var userName = "user"
    @State private var email = "user@gmail.com"
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var navigateToSignIn = false
    
    var body: some View {
        VStack {
            
//            Text("")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Text(userName)
                .font(.title)
                .fontWeight(.bold)
            
            Text(email)
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical, 20)
            
            if isEditing {
                VStack(alignment: .leading, spacing: 15) {
                    TextField("New Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        newPassword = ""
                        confirmPassword = ""
                        isEditing = false
                    }) {
                        Text("Update Password")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            } else {
                Button(action: {
                    isEditing = true
                }) {
                    Text("Change Password")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            Spacer()
            
            Button(action: {
                showAlert = true
               // SignInView()
                
            }) {
                Text("Log Out")
                    .fontWeight(.semibold)
                    .frame(maxWidth: 320)
                    .frame(height: 60)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    //.padding(.bottom,1)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text("Logged out successfully"), dismissButton: .default(Text("OK")){
                            navigateToSignIn = true

                        })
                            }
            }
            .padding(.bottom, 50)
            NavigationLink(destination: SignInView(), isActive: $navigateToSignIn) {
                               EmptyView()
                           }
                           .hidden()
        }
        .padding()
        //.navigationBarTitle("Profile")
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
