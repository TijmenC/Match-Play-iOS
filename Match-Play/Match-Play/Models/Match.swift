//
//  Match.swift
//  Match-Play
//
//  Created by Tijmen on 10/06/2021.
//

import Foundation

struct Match: Decodable, Identifiable {
    let id: Int
    let courseID: Int
    let showCourse: Bool
    let type: Int
    let winningScore: Int
    let holesNotPlayed: Int
    let winningTeam: Int
    let isCupMatch: Bool
    let welcomeDescription: String
    let holeOrder: [Int]
    let playedAt: Date
    let createdAt: Date
    let updatedAt: Date
    let deletedAt: Date
    let verified: Date
    let liked: Bool
    let likeCount: Int
    let commented: Bool
    let commentCount: Int
}

