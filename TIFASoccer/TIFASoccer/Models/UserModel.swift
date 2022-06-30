//
//  UserModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import Foundation

struct UserModel: Codable {
    var email: String?
    var nameSurname: String?
    var position: String?
    var rate: Int?
    var picture: String?
    var uuid: String?
    var authority: String?
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.nameSurname = dictionary["nameSurname"] as? String ?? ""
        self.position = dictionary["position"] as? String ?? ""
        self.rate = dictionary["rate"] as? Int ?? 0
        self.picture = dictionary["picture"] as? String ?? ""
        self.uuid = dictionary["uuid"] as? String ?? ""
        self.authority = dictionary["authority"] as? String ?? ""
    }
}

struct UserPositionModel: Codable {
    var email: String?
    var nameSurname: String?
    var position: String?
    var rate: Int?
    var picture: String?
    var uuid: String?
    var authority: String?
    var positionForMatch: String?
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.nameSurname = dictionary["nameSurname"] as? String ?? ""
        self.position = dictionary["position"] as? String ?? ""
        self.rate = dictionary["rate"] as? Int ?? 0
        self.picture = dictionary["picture"] as? String ?? ""
        self.uuid = dictionary["uuid"] as? String ?? ""
        self.authority = dictionary["authority"] as? String ?? ""
        self.positionForMatch = dictionary["positionForMatch"] as? String ?? ""
    }
}
