//
//  MatchCardCell.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 13.06.2022.
//

import SwiftUI

struct MatchCardCell: View {
    
    @State var match: MatchsModel
    @EnvironmentObject var baseViewModel: BaseViewModel
    @EnvironmentObject var matchsViewModel: MatchsViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            // MARK: - Date
            if let startDate = self.match.startDate,
               let finishDate = self.match.finishDate,
               let editedStartDate = Date(milliseconds: startDate).formatDate(),
               let editedFinishDate = Date(milliseconds: finishDate).formatDate() {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "calendar")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .frame(width: 23, height: 18)
                    Text("Tarih:")
                        .foregroundColor(Color.gray)
                        .font(Font.system(size: 13))
                    Text(editedStartDate)
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 12))
                    Text("-")
                        .foregroundColor(Color.gray)
                        .font(Font.system(size: 12))
                    Text(editedFinishDate)
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 12))
                    Spacer()
                }
                .fillWidth()
            }
            // MARK: - Football Area
            if let footballArea = self.match.footballArea {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "sportscourt")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .frame(width: 23, height: 18)
                    Text("Saha:")
                        .foregroundColor(Color.gray)
                        .font(Font.system(size: 13))
                    Text(footballArea)
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 12))
                    Spacer()
                }
                .fillWidth()
            }
            // MARK: - Admin Message
            if let adminMessage = self.match.adminMessage {
                HStack(alignment: .top, spacing: 15) {
                    Image(systemName: "message")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .frame(width: 23, height: 18)
                    Text("Açıklama:")
                        .foregroundColor(Color.gray)
                        .font(Font.system(size: 13))
                    Text(adminMessage)
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 12))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .fillWidth()
            }
            // MARK: - Joined Player Count
            HStack(alignment: .top, spacing: 0) {
                Image(systemName: "person.2")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .frame(width: 23, height: 18)
                Text("\(self.match.players?.count ?? 0)")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 13))
                    .padding(.horizontal)
                ProgressView(value: CGFloat(self.match.players?.count ?? 0),
                             total: CGFloat(14))
                .progressViewStyle(LinearProgressViewStyle(tint: self.getColorForProgress(count: (self.match.players?.count ?? 0))))
                .frame(height: 15, alignment: .center)
                    .fillWidth()
                Text("14")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 13))
                    .padding(.horizontal)
            }
            .fillWidth()
            // MARK: - Join, Leave Button
            if let matchID = self.match.matchID,
               let currentUser = self.baseViewModel.userModel {
                Text(Date().millisecondsSince1970 >= (self.match.finishDate ?? 00) ?
                     "Maç Oynandı" : self.currentUserIsJoined() ? "Maçtan Ayrıl" : "Maça Katıl")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 15))
                    .fillWidth()
                    .padding()
                    .background(Date().millisecondsSince1970 >= (self.match.finishDate ?? 00) ?
                                Color.gray :
                                    self.currentUserIsJoined() ? Color.red : Color.green)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    .onTapGestureForced {
                        if(Date().millisecondsSince1970 < (self.match.finishDate ?? 00)) {
                            if(self.currentUserIsJoined()) {
                                self.matchsViewModel.leaveMatches(matchsID: matchID)
                            } else {
                                self.matchsViewModel.joinMatches(matchsID: matchID,
                                                                 currentUser: currentUser)
                            }
                        }
                    }
            }
        }
        .fillWidth()
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        .overlay(self.baseViewModel.userModel?.authority == "admin" ? self.deleteButton : nil, alignment: .topTrailing)
    }
    
    // MARK: - Delete Button
    var deleteButton: some View {
        Image(systemName: "trash.circle.fill")
            .resizable()
            .frame(width: 25, height: 25, alignment: .center)
            .foregroundColor(Color.red)
            .scaledToFit()
            .padding(.all, 10)
            .onTapGestureForced {
                self.matchsViewModel.deleteMatches(matchsID: self.match.matchID ?? "")
            }
    }
    
    // MARK: - Current User Is Joined
    func currentUserIsJoined() -> Bool {
        if let currentUserID = FirebaseRepository.shared.getCurrentUserID(),
           let playerList = self.match.players {
            var isJoined: Bool = false
            for player in playerList {
                if(player.uuid == currentUserID) {
                    isJoined = true
                    break
                } else {
                    isJoined = false
                }
            }
            return isJoined
        } else {
            return false
        }
    }
    
    // MARK: - Get Color For Progress
    func getColorForProgress(count: Int) -> Color {
        if(count <= 5) {
            return Color.green
        } else if(count > 5 && count <= 10) {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

// MARK: - Previews
struct MatchCardCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardCell(match: MatchsModel(dictionary: [:]))
            .environmentObject(MatchsViewModel())
            .environmentObject(BaseViewModel())
    }
}
