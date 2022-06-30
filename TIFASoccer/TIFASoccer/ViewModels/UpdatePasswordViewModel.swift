//
//  UpdatePasswordViewModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 30.06.2022.
//

import Foundation
import SwiftUI
import FirebaseAuth

class UpdatePasswordViewModel: ObservableObject {
    
    @Published var isLoad: Bool = false
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var newPasswordRetry: String = ""
    
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
    
    func updatePassword() {
        self.isLoad = true
        if let user = FirebaseRepository.shared.getCurrentUser(),
           let userEmail = user.email {
            let credential = EmailAuthProvider.credential(withEmail: userEmail, password: self.currentPassword)
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    withAnimation {
                        self.isLoad = false
                        self.showAlert = true
                    }
                } else {
                    user.updatePassword(to: self.newPassword) { error in
                        if let err = error {
                            self.errorMessage = err.localizedDescription
                            withAnimation {
                                self.isLoad = false
                                self.showAlert = true
                            }
                        } else {
                            self.successMessage = "Şifre başarılı bir şekilde güncellendi."
                            withAnimation {
                                self.isLoad = false
                                self.showSuccessAlert = true
                            }
                        }
                    }
                }
            }
        }
    }
    
}
