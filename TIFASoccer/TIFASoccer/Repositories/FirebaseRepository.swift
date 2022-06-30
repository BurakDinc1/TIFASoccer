//
//  FirebaseRepository.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import UIKit
import Combine

class FirebaseRepository {
    
    static let shared = FirebaseRepository()
    
    init(){
        print("FirebaseRepository--> Fonksiyonlar kullanıma hazır.")
    }
    
    func getAuth() -> Auth{
        return Auth.auth()
    }
    
    func getDatabase() -> Database {
        let database: Database = Database.database()
        return database
    }
    
    func getReference(path: String) -> DatabaseReference {
        let reference: DatabaseReference = getDatabase().reference(withPath: path)
        return reference
    }
    
    func getStorageReference(path: String) -> StorageReference {
        return Storage.storage().reference(withPath: path)
    }
    
    func getCurrentUser() -> User? {
        if let currentUser = self.getAuth().currentUser {
            return currentUser
        } else {
            return nil
        }
    }
    
    func getCurrentUserID() -> String? {
        if(self.getCurrentUser() != nil) {
            return self.getCurrentUser()?.uid
        } else {
            return nil
        }
    }
    
    func getDeviceID() -> String? {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        if (deviceID != "") {
            return deviceID
        } else {
            return nil
        }
    }
    
}
