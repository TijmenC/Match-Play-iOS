//
//  ContentView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var email = "ioscase"
    @State var password = "iOSCase"
    @State var isActive = false
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        NavigationView {
        VStack(alignment: .leading) {
            
            Text("Username").padding(.trailing)
            TextField("Enter username", text: $email)
                .padding()
            Text("Password").padding(.trailing)
            TextField("Enter password", text: $password)
                .padding()
            NavigationLink(destination: UserFeed(results: AllData(data: [])), isActive: $isActive) {
            Button(action: {
                postLogin()
                
            }) {
                
                Text("Login")
                
            }
            }
            .padding()
        }.padding()
        }
    }
    
    
    func postLogin() {
        let user: LoginUser = .init(email: email, password: password)
        let userData = try! JSONEncoder().encode(user)
        let url = URL(string: "https://api.wearematchplay.com/v2/auth/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = userData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedUser = try? JSONDecoder().decode(Token.self, from: data) {
                print(decodedUser.api_token)
                UserDefaults.standard.set(decodedUser.api_token, forKey: "savedToken")
                self.isActive = true
                
              
                
            } else {
                print("Invalid response from server")
             //   print(data)
            }
        }.resume()
    }
   
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
