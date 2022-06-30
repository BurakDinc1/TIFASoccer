//
//  UpdateProfileViewModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 29.06.2022.
//

import Foundation
import SwiftUI

class UpdateProfileViewModel: ObservableObject {
    
    @Published var isLoad: Bool = false
    @Published var nameSurname: String = ""
    @Published var position: String = ""
    
    var errorMessage = ""
    @Published var showAlert: Bool = false {
        didSet {
            if(!showAlert) {
                self.errorMessage = ""
            }
        }
    }
    
    var successMessage = ""
    @Published var showSuccessAlert: Bool = false {
        didSet {
            if(!showSuccessAlert) {
                self.successMessage = ""
            }
        }
    }
    
    func updatePlayerData() {
        self.isLoad = true
        let params: [String: AnyObject] = ["nameSurname": self.nameSurname as AnyObject,
                                           "position": self.position as AnyObject]
        if let currentUserID = FirebaseRepository.shared.getCurrentUserID() {
            FirebaseRepository.shared
                .getReference(path: "Users")
                .child(currentUserID)
                .updateChildValues(params) { error, reference in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        withAnimation {
                            self.isLoad = false
                            self.showAlert = true
                        }
                    } else {
                        self.successMessage = "Profil bilgileri başarılı bir şekilde güncellendi."
                        withAnimation {
                            self.isLoad = false
                            self.showSuccessAlert = true
                        }
                    }
                }
        }
    }
    
}
