//
//  Extension.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import Foundation
import SwiftUI

// MARK: - View
extension View {
    /// Icerisinde bulundugu Viewin yuksekligi ve genisligi kadar kendi yuksekligini ve genisligini ayarlar.
    func fillAll() -> some View {
        return self.frame(minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 0,
                          maxHeight: .infinity)
    }
    
    /// Icerisinde bulundugu Viewin genisligi kadar kendi genisligini ayarlar.
    func fillWidth() -> some View {
        return self.frame(minWidth: 0,
                          maxWidth: .infinity)
    }
    
    /// Icerisinde bulundugu Viewin yuksekligi kadar kendi yuksekligini ayarlar.
    func fillHeight() -> some View {
        return self.frame(minHeight: 0,
                          maxHeight: .infinity)
    }
    
    /// Parametre olarak verilen degere gore yuvarlak bir sekil verir
    func setCircle(widthAndHeight: CGFloat, backgroundColor: Color = Color.white) -> some View {
        self.frame(width: widthAndHeight, height: widthAndHeight, alignment: .center)
            .background(backgroundColor)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            .padding(.all, 3)
    }
    
    /// Parametre olarak verilen degere gore yuvarlak bir sekil verir
    func setCircleWithBackground(widthAndHeight: CGFloat,
                                 backgroundColor: Color = Color.clear) -> some View {
        self.frame(width: widthAndHeight, height: widthAndHeight, alignment: .center)
            .background(backgroundColor)
            .cornerRadius(widthAndHeight / 2)
    }
    
    /// Sadece belirli koseleri cornerlamak icin.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// Bir View'in icerisinde Spacer oldugunda Spacer tiklanmıyor. Bu sorun icin bu method kullanilabilir.
    func onTapGestureForced(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        self.contentShape(Rectangle())
            .onTapGesture(count:count, perform:action)
    }
}

// MARK: - String
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func convertToDictionary() -> [String: AnyObject]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getPositionImageName() -> String {
        switch self {
        case Mevki.solKanat.rawValue, Mevki.sagKanat.rawValue:
            return "lungs"
        case Mevki.kaleci.rawValue:
            return "hands.sparkles"
        case Mevki.ortaSaha.rawValue:
            return "brain"
        case Mevki.sagBek.rawValue, Mevki.solBek.rawValue:
            return "bolt.heart"
        case Mevki.stoper.rawValue:
            return "shield.lefthalf.filled"
        case Mevki.joker.rawValue:
            return "tshirt"
        default:
            return "tshirt"
        }
    }
}

// MARK: - Date
extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0))
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}

// MARK: - User Model
extension UserModel {
    var asDictionary : [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
    
    func castUserPositionModel(position: String) -> UserPositionModel {
        let params = ["email": (self.email ?? "") as AnyObject,
                      "authority": (self.authority ?? "") as AnyObject,
                      "nameSurname": (self.nameSurname ?? "") as AnyObject,
                      "picture": (self.picture ?? "") as AnyObject,
                      "position": (self.position ?? "") as AnyObject,
                      "rate": (self.rate ?? 0) as AnyObject,
                      "uuid": (self.uuid ?? "") as AnyObject,
                      "positionForMatch": position as AnyObject]
        let userPositionModel = UserPositionModel(dictionary: params)
        return userPositionModel
    }
}

// MARK: - User Position Model
extension UserPositionModel {
    var asDictionary : [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
    
    func castUserModel() -> UserModel {
        let params = ["email": (self.email ?? "") as AnyObject,
                      "authority": (self.authority ?? "") as AnyObject,
                      "nameSurname": (self.nameSurname ?? "") as AnyObject,
                      "picture": (self.picture ?? "") as AnyObject,
                      "position": (self.position ?? "") as AnyObject,
                      "rate": (self.rate ?? 0) as AnyObject,
                      "uuid": (self.uuid ?? "") as AnyObject]
        let userModel = UserModel(dictionary: params)
        return userModel
    }
}

// MARK: - Custom String Convertible
extension CustomStringConvertible {
    var description: String {
        var desc = "Class Name: \(type(of: self))\n"
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let label = child.label {
                desc.append("\(label): \(child.value)\n")
            }
        }
        return desc
    }
}

// MARK: - Date
extension Date {
    var dateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        return dateFormatter.string(from: self)
    }
}
