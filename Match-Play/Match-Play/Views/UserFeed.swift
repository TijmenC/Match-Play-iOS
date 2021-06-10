//
//  UserFeed.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct UserFeed: View {
    @State var results = [Response]()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    func loadData() {
        guard let url = URL(string: "https://api.wearematchplay.com/v2/matches") else {
            print("Invalid URL")
            return
        }
        let savedToken = UserDefaults.standard.object(forKey: "savedToken")
        var request = URLRequest(url: url)
        request.setValue((savedToken as! String), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Response].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                        print(response)
                    }
                    return
                }
                print(data)
            }
        }.resume()
    }
}

struct UserFeed_Previews: PreviewProvider {
    static var previews: some View {
        UserFeed()
    }
}
