//
//  UserFeed.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct UserFeed: View {
    @State var results: AllData
    
    var body: some View {
        ScrollView {
        ForEach(results.data) { result in
            MatchView(firstName: "Eric", lastName: "Jognson", likes: result.likeCount, comments: result.commentCount, clubName: result.course.name, uploadDate: result.createdAt, description: result.datumDescription ?? "", isLiked: result.liked, isCommented: result.commented)
             }
        }.onAppear(perform: loadData)
            
    }
    func loadData() {
        guard let url = URL(string: "https://api.wearematchplay.com/v2/matches") else {
            print("Invalid URL")
            return
        }
        let savedToken = "Bearer " + (UserDefaults.standard.object(forKey: "savedToken") as! String)
        var request = URLRequest(url: url)
        request.setValue((savedToken ), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
              do {
                let decodedResponse = try JSONDecoder().decode(AllData.self, from: data)
                DispatchQueue.main.async {
                    print(decodedResponse)
                    results = decodedResponse
                 }
              } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
              
                
              return
            }

               }.resume()
    }
}

struct UserFeed_Previews: PreviewProvider {
    static var previews: some View {
        UserFeed(results: AllData(data: []))
    }
}
