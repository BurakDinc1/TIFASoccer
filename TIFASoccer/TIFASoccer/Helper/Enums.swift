//
//  Enums.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 29.06.2022.
//

import Foundation

enum Mevki: String, CaseIterable {
    case joker = "Joker"
    case stoper = "Stoper"
    case solBek = "Sol Bek"
    case sagBek = "Sağ Bek"
    case ortaSaha = "Orta Saha"
    case sagKanat = "Sağ Kanat"
    case solKanat = "Sol Kanat"
    case kaleci = "Kaleci"
}

enum PlayerPosition: String, CaseIterable {
    case A0 = "A0"
    case A1 = "A1"
    case A2 = "A2"
    case A3 = "A3"
    case A4 = "A4"
    case A5 = "A5"
    case A6 = "A6"
    case B0 = "B0"
    case B1 = "B1"
    case B2 = "B2"
    case B3 = "B3"
    case B4 = "B4"
    case B5 = "B5"
    case B6 = "B6"
}
