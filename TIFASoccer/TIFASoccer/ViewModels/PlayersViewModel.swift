//
//  PlayersView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 10.06.2022.
//

import Foundation
import FirebaseDatabase
import SwiftUI

class PlayersViewModel: ObservableObject {
    
    @Published var isLoad: Bool = false
    @Published var userModelList: [UserModel] = []
    
    var errorMessage = ""
    @Published var showAlert: Bool = false {
        didSet {
            if(!showAlert) {
                self.errorMessage = ""
            }
        }
    }
    
    func getAllPlayers() {
        self.isLoad = true
        self.userModelList.removeAll()
        FirebaseRepository
            .shared
            .getReference(path: "Users")
            .getData { error, dataSnapshot in
                if(error == nil) {
                    for child in dataSnapshot.children {
                        if let snap = child as? DataSnapshot {
                            if let placeDict = snap.value as? [String: AnyObject] {
                                let userModel = UserModel(dictionary: placeDict)
                                withAnimation {
                                    self.userModelList.append(userModel)
                                    self.isLoad = false
                                }
                            } else {
                                withAnimation {
                                    self.userModelList.removeAll()
                                    self.isLoad = false
                                }
                            }
                        } else {
                            withAnimation {
                                self.userModelList.removeAll()
                                self.isLoad = false
                            }
                        }
                    }
                } else {
                    withAnimation {
                        self.userModelList.removeAll()
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
