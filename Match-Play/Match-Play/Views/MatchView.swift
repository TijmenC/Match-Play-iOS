//
//  MatchView.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import SwiftUI

struct MatchView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var likes: Int
    @State var comments: Int
    @State var clubName: String
    @State var uploadDate: String
    @State var description: String
    @State var isLiked: Bool
    @State var isCommented: Bool
    @State var isVerified: String
    
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text("T. Pieters")
                    .padding()
                    .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                    .foregroundColor(Color.gray)
                Text("A. Achternaam")
                    .padding()
                    .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                    .foregroundColor(Color.gray)
            }
            Divider()
            HStack {
                ScorePointsView(circleAmount: 18)
            }
            Image("fall-leave")
                .resizable()
                .scaledToFit()
                .frame(width: 400.0, height: 250.0)
            Divider()
            HStack {
                Text(clubName)
                    .padding()
                    .frame(width: 200, height: 50, alignment: .leading)
                    .foregroundColor(Color.gray)
                Text(uploadDate)
                    .padding()
                    .frame(width: 200, height: 50, alignment: .trailing)
                    .foregroundColor(Color.gray)
            }
            Text(description)
                .frame(width: 400, height: 50)
            Divider()
            HStack {
                HStack {
                    if (!isLiked) {
                        Image(systemName: "heart")
                            .font(Font.system(size: 30))
                            .padding(.leading, 5)
                        Text(" \(likes)")
                    }
                    else {
                        Image(systemName: "heart.fill")
                            .font(Font.system(size: 30))
                            .padding(.leading, 5)
                            .foregroundColor(.red)
                        Text(" \(likes)")
                        
                        
                    }
                }.frame(width: 80, height: 50, alignment: .leading)
                
                HStack {
                    if (!isCommented) {
                    Image(systemName: "bubble.left")
                        .font(Font.system(size: 30))
                    Text(" \(comments)")
                    }
                    else {
                        Image(systemName: "bubble.left.fill")
                            .font(Font.system(size: 30))
                            .foregroundColor(.black)
                        Text(" \(comments)")
                        
                    }
                }.frame(width: 70, height: 50, alignment: .leading)
                HStack {
                    if (isVerified != "") {
                        Image(systemName: "checkmark.circle.fill")
                            .font(Font.system(size: 30))
                            .foregroundColor(.green)
                        Text("Verified")
                    }
                    else {
                        Image(systemName: "xmark.circle.fill")
                            .font(Font.system(size: 30))
                            .foregroundColor(.red)
                        Text("Not Verified")
                    }
                } .frame(width: 250, height: 50, alignment: .leading)
            }
            
            
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(likes: 5, comments: 3, clubName: "hey", uploadDate: "ey", description: "description", isLiked: true, isCommented: true, isVerified: "")
    }
}
