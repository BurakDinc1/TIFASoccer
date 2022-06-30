//
//  MatchsModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 13.06.2022.
//

import Foundation

struct MatchsModel: Codable, Equatable {
    
    /// Equatable
    static func == (lhs: MatchsModel, rhs: MatchsModel) -> Bool {
        return (lhs.matchID == rhs.matchID &&
        lhs.startDate == rhs.startDate &&
        lhs.finishDate == rhs.finishDate &&
        lhs.footballArea == rhs.footballArea &&
        lhs.adminMessage == rhs.adminMessage &&
        lhs.isPlanningComplete == rhs.isPlanningComplete)
    }
    
    var matchID: String? // --> UUID
    var startDate: Int64?
    var finishDate: Int64?
    var footballArea: String?
    var adminMessage: String?
    var players: [UserModel]?
    var Position: [UserPositionModel]?
    var isPlanningComplete: Bool?
    var comments: [CommentsModel]?
    
    /// Init
    init(dictionary: [String: AnyObject]) {
        self.players = []
        self.Position = []
        self.comments = []
        self.matchID = dictionary["matchID"] as? String ?? ""
        self.startDate = dictionary["startDate"] as? Int64 ?? 0
        self.finishDate = dictionary["finishDate"] as? Int64 ?? 0
        self.footballArea = dictionary["footballArea"] as? String ?? ""
        self.adminMessage = dictionary["adminMessage"] as? String ?? ""
        self.isPlanningComplete = dictionary["isPlanningComplete"] as? Bool ?? false
        let usersDict = dictionary["players"] as? [String: [String: AnyObject]] ?? [:]
        for dic in usersDict {
            let singleUserDict = dic.value
            let user = UserModel(dictionary: singleUserDict)
            self.players?.append(user)
        }
        let positionDict = dictionary["Positions"] as? [String: [String: AnyObject]] ?? [:]
        for dic in positionDict {
            let singleUserDict = dic.value
            let user = UserPositionModel(dictionary: singleUserDict)
            self.Position?.append(user)
        }
        let commentsDict = dictionary["Comments"] as? [String: [String: AnyObject]] ?? [:]
        for dic in commentsDict {
            let singleComment = dic.value
            let commentModel = CommentsModel(dictionary: singleComment)
            self.comments?.append(commentModel)
        }
    }
}

// MARK: - CommentsModel
struct CommentsModel: Codable {
    var uuid: String? // --> UUID
    var comment: String?
    var date: String?
    
    init(dictionary: [String: AnyObject]) {
        self.uuid = dictionary["uuid"] as? String ?? ""
        self.comment = dictionary["comment"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
    }
}
