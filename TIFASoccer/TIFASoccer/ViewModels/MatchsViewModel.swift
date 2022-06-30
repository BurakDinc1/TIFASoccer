//
//  MatchsViewModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 13.06.2022.
//

import Foundation
import FirebaseDatabase
import SwiftUI

class MatchsViewModel: ObservableObject {
 
    @Published var isLoad: Bool = false
    @Published var matchsModelList: [MatchsModel] = []
    @Published var selectedMatch: MatchsModel = MatchsModel(dictionary: [:])
    @Published var unselectedPlayer: [UserModel]  = []
    
    var errorMessage = ""
    @Published var showAlert: Bool = false {
        didSet {
            if(!showAlert) {
                self.errorMessage = ""
            }
        }
    }
    
    func getAllMatchs() {
        self.isLoad = true
        self.matchsModelList.removeAll()
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .getData { error, dataSnapshot in
                if(error == nil) {
                    for child in dataSnapshot.children {
                        if let snap = child as? DataSnapshot {
                            if let placeDict = snap.value as? [String: AnyObject] {
                                let matchModel = MatchsModel(dictionary: placeDict)
                                withAnimation {
                                    self.matchsModelList.append(matchModel)
                                    self.isLoad = false
                                }
                            } else {
                                withAnimation {
                                    self.matchsModelList.removeAll()
                                    self.isLoad = false
                                }
                            }
                        } else {
                            withAnimation {
                                self.matchsModelList.removeAll()
                                self.isLoad = false
                            }
                        }
                    }
                } else {
                    withAnimation {
                        self.matchsModelList.removeAll()
                        self.isLoad = false
                    }
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func joinMatches(matchsID: String, currentUser: UserModel) {
        self.isLoad = true
        if let currentUserID = currentUser.uuid {
            let dbReference = FirebaseRepository
                .shared
                .getReference(path: "Matchs")
                .child(matchsID)
                .child("players")
            dbReference.getData { error, reference in
                if(error == nil) {
                    let count = reference.childrenCount
                    print("Burak--> Maç Kadrosu: \(count)")
                    if(count == 14) {
                        self.errorMessage = "Bu maçın kadrosu tamamlandı !"
                        withAnimation {
                            self.showAlert = true
                        }
                    } else {
                        dbReference
                            .child(currentUserID)
                            .setValue(currentUser.asDictionary) { secondError, secondReference in
                                if(secondError == nil) {
                                    withAnimation {
                                        self.isLoad = false
                                    }
                                    self.getAllMatchs()
                                } else {
                                    withAnimation {
                                        self.isLoad = false
                                    }
                                    self.getAllMatchs()
                                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                                    withAnimation {
                                        self.showAlert = true
                                    }
                                }
                            }
                    }
                } else {
                    withAnimation {
                        self.isLoad = false
                    }
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
        }
    }
    
    func isUserInFootballArea(matchID: String, currentUserID: String) {
        self.isLoad = true
        FirebaseRepository.shared
            .getReference(path: "Matchs")
            .child(matchID)
            .getData { error, dataSnapshot in
                if(error == nil) {
                    if let placeDict = dataSnapshot.value as? [String: AnyObject] {
                        let matchModel = MatchsModel(dictionary: placeDict)
                        if let positions = matchModel.Position,
                           !positions.isEmpty {
                            for position in positions {
                                if(position.uuid == currentUserID) {
                                    self.isLoad = false
                                    self.deletePlayerForFootballArea(matchID: matchID, position: position.positionForMatch ?? "")
                                    return
                                }
                            }
                            self.isLoad = false
                            self.getAllMatchs()
                        } else {
                            self.isLoad = false
                            self.getAllMatchs()
                        }
                    } else {
                        self.isLoad = false
                        self.getAllMatchs()
                    }
                } else {
                    withAnimation {
                        self.isLoad = false
                    }
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func deletePlayerForFootballArea(matchID: String, position: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchID)
            .child("Positions")
            .child(position)
            .removeValue { error, reference in
                if(error == nil) {
                    self.isLoad = false
                    self.getAllMatchs()
                } else {
                    withAnimation {
                        self.isLoad = false
                    }
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func leaveMatches(matchsID: String) {
        self.isLoad = true
        if let currentUserID = FirebaseRepository.shared.getCurrentUserID() {
            FirebaseRepository
                .shared
                .getReference(path: "Matchs")
                .child(matchsID)
                .child("players")
                .child(currentUserID)
                .removeValue { error, reference in
                    if(error == nil) {
                        withAnimation {
                            self.isLoad = false
                        }
                        self.isUserInFootballArea(matchID: matchsID, currentUserID: currentUserID)
                    } else {
                        withAnimation {
                            self.isLoad = false
                        }
                        self.errorMessage = error?.localizedDescription ?? "Oups!"
                        withAnimation {
                            self.showAlert = true
                        }
                    }
                }
        }
    }
    
    func deleteMatches(matchsID: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchsID)
            .removeValue { error, reference in
                if(error == nil) {
                    withAnimation {
                        self.isLoad = false
                    }
                    self.getAllMatchs()
                } else {
                    withAnimation {
                        self.isLoad = false
                    }
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func setPlayerPositionWithMatch(matchID: String, playerPosition: String, player: UserModel) {
        self.isLoad = true
        let usserPositionModel = player.castUserPositionModel(position: playerPosition)
        let params = usserPositionModel.asDictionary
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchID)
            .child("Positions")
            .child(playerPosition)
            .setValue(params) { error, reference in
                if(error == nil) {
                    self.getMatchWithMatchID(matchID: matchID)
                    withAnimation {
                        self.isLoad = false
                    }
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.isLoad = false
                        self.showAlert = true
                    }
                }
            }
    }
    
    func deletePlayerPositionWithMatch(matchID: String, playerPosition: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchID)
            .child("Positions")
            .child(playerPosition)
            .removeValue { error, reference in
                if(error == nil) {
                    self.getMatchWithMatchID(matchID: matchID)
                    withAnimation {
                        self.isLoad = false
                    }
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.isLoad = false
                        self.showAlert = true
                    }
                }
            }
    }
    
    func getMatchWithMatchID(matchID: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchID)
            .getData { error, reference in
                if(error == nil) {
                    if let placeDict = reference.value as? [String: AnyObject] {
                        self.selectedMatch = MatchsModel(dictionary: placeDict)
                        self.unselectedPlayer = self.selectedMatch.players!
                        if let positions = self.selectedMatch.Position,
                           let players = self.selectedMatch.players {
                            for position in positions {
                                for player in players {
                                    if(position.uuid == player.uuid) {
                                        self.unselectedPlayer.removeAll(where: {$0.uuid == player.uuid})
                                    }
                                }
                            }
                        }
                    }
                    self.isLoad = false
                } else {
                    self.isLoad = false
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func setIsPlanningCompleteForMatch(matchID: String) {
        self.isLoad = true
        if let matchPlanning = self.selectedMatch.isPlanningComplete {
            FirebaseRepository
                .shared
                .getReference(path: "Matchs")
                .child(matchID)
                .child("isPlanningComplete")
                .setValue(matchPlanning ? (false as AnyObject) : (true as AnyObject)) { error, reference in
                    if(error == nil) {
                        withAnimation {
                            self.isLoad = false
                        }
                        self.getMatchWithMatchID(matchID: matchID)
                    } else {
                        self.errorMessage = error?.localizedDescription ?? "Oups!"
                        withAnimation {
                            self.isLoad = false
                            self.showAlert = true
                        }
                    }
                }
        }
    }
    
    func addComment(comment: String) {
        if let matchID = self.selectedMatch.matchID {
            self.isLoad = true
            let commentParams = ["comment": comment as AnyObject,
                                 "uuid": UUID().uuidString as AnyObject,
                                 "date": Date().dateToString as AnyObject]
            FirebaseRepository
                .shared
                .getReference(path: "Matchs")
                .child(self.selectedMatch.matchID ?? "")
                .child("Comments")
                .child(UUID().uuidString)
                .setValue(commentParams) { error, reference in
                    if(error == nil) {
                        withAnimation {
                            self.isLoad = false
                        }
                        self.getMatchWithMatchID(matchID: matchID)
                    } else {
                        self.errorMessage = error?.localizedDescription ?? "Oups!"
                        withAnimation {
                            self.isLoad = false
                            self.showAlert = true
                        }
                    }
                }
        }
    }
    
}
