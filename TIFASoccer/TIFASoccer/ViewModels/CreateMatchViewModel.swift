//
//  CreateMatchViewModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 14.06.2022.
//

import Foundation
import SwiftUI
class CreateMatchViewModel: ObservableObject {
    
    @Published var isLoad: Bool = false
    @Published var matchStartDate: Date = Date()
    @Published var matchFinishDate: Date = Date()
    @Published var footballArea: String = ""
    @Published var adminMessage: String = ""
    @Published var isShowingCreateMatchView: Bool = true
    
    var errorMessage = ""
    @Published var showAlert: Bool = false {
        didSet {
            if(!showAlert) {
                self.errorMessage = ""
            }
        }
    }
    
    func createMatch() {
        self.isLoad = true
        let finishDate = self.matchFinishDate.millisecondsSince1970
        let startDate = self.matchStartDate.millisecondsSince1970
        let matchID = UUID().uuidString
        let params: [String: AnyObject] = ["adminMessage": self.adminMessage as AnyObject,
                                           "finishDate": finishDate as AnyObject,
                                           "startDate": startDate as AnyObject,
                                           "footballArea": self.footballArea as AnyObject,
                                           "matchID": matchID as AnyObject,
                                           "isPlanningComplete": false as AnyObject]
        FirebaseRepository
            .shared
            .getReference(path: "Matchs")
            .child(matchID)
            .setValue(params) { error, reference in
                if(error == nil) {
                    withAnimation {
                        self.isLoad = false
                        self.isShowingCreateMatchView = false
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
}
