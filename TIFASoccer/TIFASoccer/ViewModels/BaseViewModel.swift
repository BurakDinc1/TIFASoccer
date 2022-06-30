//
//  BaseViewModel.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var selection: Int = 1
    @Published var isLoggedIn: Bool = false
    @Published var isRegisterViewShowing: Bool = false
    @Published var isLoad: Bool = false
    @Published var userModel: UserModel? = nil
    
    var errorMessage = ""
    @Published var showAlert: Bool = false {
        didSet {
            if(!showAlert) {
                self.errorMessage = ""
            }
        }
    }
    
    init() {
        if(FirebaseRepository.shared.getCurrentUser() != nil) {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    /// Ana sayfadaki navigation title'ini selectiona göre döner.
    func getNavigationTitleForBaseView() -> String {
        switch self.selection {
        case 1:
            return "Maçlar"
        case 2:
            return "Oyuncular"
        case 3:
            return "Hesabım"
        default:
            return "TIFA Soccer"
        }
    }
    
    func login(email: String, password: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getAuth()
            .signIn(withEmail: email, password: password) { result, error in
                if(error == nil) {
                    self.isLoad = false
                    self.isLoggedIn = true
                } else {
                    self.isLoad = false
                    self.isLoggedIn = false
                    self.errorMessage = error?.localizedDescription ?? "Oups!"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            }
    }
    
    func register(email: String, password: String, nameSurname: String) {
        self.isLoad = true
        FirebaseRepository
            .shared
            .getAuth()
            .createUser(withEmail: email, password: password) { result, error in
            if(error == nil) {
                if let currentUserID = FirebaseRepository.shared.getCurrentUserID() {
                    let params: [String: AnyObject] = ["email": email as AnyObject,
                                                       "nameSurname": nameSurname as AnyObject,
                                                       "position": "Joker" as AnyObject,
                                                       "rate": 0 as AnyObject,
                                                       "picture": "https://firebasestorage.googleapis.com/v0/b/tifasoccer-703cd.appspot.com/o/UsersPicture%2FT-Soft%20Player.png?alt=media&token=3175c739-ef1c-4960-a90a-c88a1e47003d" as AnyObject,
                                                       "uuid": currentUserID as AnyObject,
                                                       "authority": "user" as AnyObject]
                    FirebaseRepository
                        .shared
                        .getReference(path: "Users")
                        .child(currentUserID)
                        .setValue(params) { error, reference in
                            if(error == nil) {
                                self.isLoad = false
                                self.isLoggedIn = true
                            } else {
                                self.isLoad = false
                                self.isLoggedIn = false
                                self.errorMessage = error?.localizedDescription ?? "Oups!"
                                withAnimation {
                                    self.showAlert = true
                                }
                            }
                        }
                } else {
                    self.isLoad = false
                    self.isLoggedIn = false
                    self.errorMessage = "Bir Hata Meydana Geldi !"
                    withAnimation {
                        self.showAlert = true
                    }
                }
            } else {
                self.isLoad = false
                self.isLoggedIn = false
                self.errorMessage = error?.localizedDescription ?? "Oups!"
                withAnimation {
                    self.showAlert = true
                }
            }
        }
        
    }
    
    func signOut() {
        do {
            try FirebaseRepository.shared.getAuth().signOut()
            self.userModel = nil
            self.isLoggedIn = false
        } catch {
            print("Burak--> Çıkış Yapılamadı.")
        }
    }
    
    func getCurrentUserData() {
        self.isLoad = true
        self.userModel = nil
        if let currentUserId = FirebaseRepository.shared.getCurrentUserID() {
            FirebaseRepository
                .shared
                .getReference(path: "Users")
                .child(currentUserId)
                .getData { error, dataSnapshot in
                    if(error == nil) {
                        if let placeDict = dataSnapshot.value as? [String: AnyObject] {
                            withAnimation {
                                self.userModel = UserModel(dictionary: placeDict)
                                self.isLoad = false
                            }
                        } else {
                            withAnimation {
                                self.userModel = nil
                                self.isLoad = false
                            }
                        }
                    } else {
                        withAnimation {
                            self.userModel = nil
                            self.isLoad = false
                        }
                    }
                }
        } else {
            withAnimation {
                self.userModel = nil
                self.isLoad = false
            }
        }
    }
    
    func loadProfileImage(imageData: Data) {
        self.isLoad = true
        if let currentUserID = FirebaseRepository.shared.getCurrentUserID() {
            let reference = FirebaseRepository.shared.getStorageReference(path: "UsersPicture").child(currentUserID)
            reference.putData(imageData, metadata: nil) { (metaData, error) in
                if(error == nil) {
                    reference.downloadURL { (url, error) in
                        if let downloadURL = url {
                            FirebaseRepository
                                .shared
                                .getReference(path: "Users")
                                .child(currentUserID)
                                .child("picture")
                                .setValue(downloadURL.description) { error, _ in
                                    if(error == nil) {
                                        self.isLoad = false
                                        self.userModel?.picture = downloadURL.description
                                    } else {
                                        self.isLoad = false
                                    }
                                }
                        } else {
                            self.isLoad = false
                        }
                    }
                } else {
                    self.isLoad = false
                }
            }
        } else {
            self.isLoad = false
        }
    }
}
