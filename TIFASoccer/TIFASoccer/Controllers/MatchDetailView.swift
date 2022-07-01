//
//  MatchDetailView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 14.06.2022.
//

import SwiftUI
import Kingfisher
import ExytePopupView

struct MatchDetailView: View {
    
    @State var matchID: String
    @EnvironmentObject var matchsViewModel: MatchsViewModel
    @EnvironmentObject var baseViewModel: BaseViewModel
    @State var isInfoViewShowing: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 10) {
                            ForEach(self.matchsViewModel.unselectedPlayer, id: \.uuid) { player in
                                // MARK: - Top List
                                if let playerImage = player.picture,
                                   let playerName = player.nameSurname,
                                   let playerMevki = player.position {
                                    Menu {
                                        if(self.baseViewModel.userModel?.authority == "admin") {
                                            ForEach(PlayerPosition.allCases, id: \.rawValue) { position in
                                                if(!self.isActivePosition(itemPosition: position.rawValue)) {
                                                    Button {
                                                        self.matchsViewModel.setPlayerPositionWithMatch(matchID: self.matchsViewModel.selectedMatch.matchID ?? "",
                                                                                                        playerPosition: position.rawValue,
                                                                                                        player: player)
                                                    } label: {
                                                        Text(position.rawValue)
                                                    }
                                                }
                                            }
                                        }
                                    } label: {
                                        VStack(alignment: .center, spacing: 3) {
                                            KFImage.url(URL(string: playerImage))
                                                .resizable()
                                                .placeholder({
                                                    ProgressView(value: 0.7)
                                                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                                                })
                                                .loadDiskFileSynchronously()
                                                .cacheMemoryOnly()
                                                .fade(duration: 0.25)
                                                .onProgress { receivedSize, totalSize in  }
                                                .onSuccess { result in  }
                                                .onFailure { error in }
                                                .fillWidth()
                                                .frame(width: 75, height: 100, alignment: .center)
                                                .scaledToFit()
                                            Text(playerName)
                                                .foregroundColor(.black)
                                                .font(Font.system(size: 13))
                                        }.overlay(
                                            ZStack(alignment: .center) {
                                                Image(systemName: playerMevki.getPositionImageName())
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 15, height: 15, alignment: .center)
                                                    .foregroundColor(.black)
                                            }
                                            .padding(4)
                                            .background(Color.white)
                                            .cornerRadius(30)
                                            .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 0),
                                            alignment: .topTrailing
                                        )
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal, 10)
                    ZStack(alignment: .center) {
                        Image("football_area")
                            .resizable()
                            .scaledToFit()
                            .fillAll()
                        VStack(alignment: .center, spacing: 10) {
                            // MARK: - A0
                            HStack(alignment: .center, spacing: 0) {
                                if(self.isUserInThisPosition(position: PlayerPosition.A0.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A0.rawValue),
                                               position: PlayerPosition.A0.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A0.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A0.rawValue)
                                }
                            }
                            .fillWidth()
                            // MARK: - A1, A2, A3
                            HStack(alignment: .center, spacing: 30) {
                                if(self.isUserInThisPosition(position: PlayerPosition.A1.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A1.rawValue),
                                               position: PlayerPosition.A1.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A1.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A1.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.A2.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A2.rawValue),
                                               position: PlayerPosition.A2.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A2.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A2.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.A3.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A3.rawValue),
                                               position: PlayerPosition.A3.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A3.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A3.rawValue)
                                }
                            }
                            .fillWidth()
                            // MARK: - A4, A5, A6
                            HStack(alignment: .center, spacing: 30) {
                                if(self.isUserInThisPosition(position: PlayerPosition.A4.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A4.rawValue),
                                               position: PlayerPosition.A4.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A4.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A4.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.A5.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A5.rawValue),
                                               position: PlayerPosition.A5.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A5.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A5.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.A6.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.A6.rawValue),
                                               position: PlayerPosition.A6.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.A6.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.A6.rawValue)
                                }
                            }
                            .fillWidth()
                            // MARK: - B6, B5, B4
                            HStack(alignment: .center, spacing: 30) {
                                if(self.isUserInThisPosition(position: PlayerPosition.B6.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B6.rawValue),
                                               position: PlayerPosition.B6.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B6.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B6.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.B5.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B5.rawValue),
                                               position: PlayerPosition.B5.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B5.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B5.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.B4.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B4.rawValue),
                                               position: PlayerPosition.B4.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B4.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B4.rawValue)
                                }
                            }
                            .fillWidth()
                            // MARK: - B3, B2, B1
                            HStack(alignment: .center, spacing: 30) {
                                if(self.isUserInThisPosition(position: PlayerPosition.B3.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B3.rawValue),
                                               position: PlayerPosition.B3.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B3.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B3.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.B2.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B2.rawValue),
                                               position: PlayerPosition.B2.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B2.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B2.rawValue)
                                }
                                if(self.isUserInThisPosition(position: PlayerPosition.B1.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B1.rawValue),
                                               position: PlayerPosition.B1.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B1.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B1.rawValue)
                                }
                            }
                            .fillWidth()
                            // MARK: - B0
                            HStack(alignment: .center, spacing: 0) {
                                if(self.isUserInThisPosition(position: PlayerPosition.B0.rawValue)) {
                                    self.getKF(imageString: self.getPictureForPosition(position: PlayerPosition.B0.rawValue),
                                               position: PlayerPosition.B0.rawValue,
                                               playerName: self.getPlayerNameForPosition(position: PlayerPosition.B0.rawValue))
                                } else {
                                    self.getDefaultImage(position: PlayerPosition.B0.rawValue)
                                }
                            }
                            .fillWidth()
                        }
                        .fillAll()
                    }
                    .overlay(self.teamAText, alignment: .topLeading)
                    .overlay(self.teamBText, alignment: .bottomTrailing)
                    .fillWidth()
                    CommentsView(comments: .constant(self.matchsViewModel.selectedMatch.comments ?? []))
                }
            }
            if(self.matchsViewModel.isLoad) {
                LoadingView()
                    .fillAll()
            }
            if(self.matchsViewModel.showAlert) {
                MessageDialog(title: "Hata !",
                              message: self.matchsViewModel.errorMessage,
                              icon: .error,
                              isShow: self.$matchsViewModel.showAlert)
            }
            if(self.isInfoViewShowing) {
                if(self.matchsViewModel.selectedMatch.isPlanningComplete ?? false) {
                    PopUpWithAnimation(isShowing: self.$isInfoViewShowing,
                                       lottieName: "football_area_animation",
                                       title: "Maç Planı Tamamlandı",
                                       message: "Maçın planlanması admin tarafından tamamlandı.",
                                       buttonTitle: "Anladım")
                } else {
                    PopUpWithAnimation(isShowing: self.$isInfoViewShowing,
                                       lottieName: "football_area_animation",
                                       title: "Maç Planı Hazır Değil",
                                       message: "Maçın planlanması henüz admin tarafından tamamlanmadı. Planlamanın tamamlanmasını bilgi sekmesinden kontrol edebilirsin.",
                                       buttonTitle: "Anladım")
                }
            }
        }
        .fillAll()
        .navigationTitle("Maç Detayı")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                self.matchPlanIsOkButton(isOk: self.matchsViewModel.selectedMatch.isPlanningComplete ?? false)
                self.infoButton
            }
        }
        .onAppear {
            self.matchsViewModel.getMatchWithMatchID(matchID: self.matchID)
        }
        .onChange(of: self.matchsViewModel.selectedMatch) { newValue in
            if(newValue.isPlanningComplete == false) {
                withAnimation {
                    self.isInfoViewShowing = true
                }
            }
        }
    }
    
    // MARK: - Get KF Image
    func getKF(imageString: String, position: String, playerName: String) -> some View {
        return VStack(alignment: .center, spacing: 1) {
            KFImage.url(URL(string: imageString))
                .resizable()
                .placeholder({
                    ZStack {
                        ProgressView(value: 0.7)
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    }
                    .frame(width: 55, height: 80, alignment: .center)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                })
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .fillWidth()
                .frame(width: 55, height: 80, alignment: .center)
                .scaledToFit()
            Text(playerName)
                .foregroundColor(.white)
                .font(Font.system(size: 10))
                .padding(.all, 2)
                .background(Color.white.opacity(0.5))
                .cornerRadius(5)
        }
        .overlay(self.baseViewModel.userModel?.authority == "admin" ? self.deleteImage : nil, alignment: .topTrailing)
        .onTapGestureForced {
            print("Burak--> \(position)")
            if(self.baseViewModel.userModel?.authority == "admin") {
                self.matchsViewModel.deletePlayerPositionWithMatch(matchID: self.matchID,
                                                                   playerPosition: position)
            }
        }
    }
    
    // MARK: - Get Default Image
    /// Saha üzerindeki default resimi getirir.
    func getDefaultImage(position: String) -> some View {
        // Pozisyon bilgisi ileride iş yapabilir.
        return ZStack {
            Color
                .white
                .opacity(0.5)
                .frame(width: 55, height: 80, alignment: .center)
                .cornerRadius(10)
            Text(position)
                .foregroundColor(.white)
                .font(Font.system(size: 13))
        }
    }
    
    // MARK: - Is User In This Position
    /// Kullanıcının ilgili pozisyonda olup olmadığını kontrol eder.
    func isUserInThisPosition(position: String) -> Bool {
        var value: Bool = false
        if let positions = self.matchsViewModel.selectedMatch.Position {
            for player in positions {
                if(player.positionForMatch == position) {
                    value = true
                    break
                }
            }
        }
        return value
    }
    
    // MARK: - Get Picture For Position
    /// İlgili pozisyon için oyuncu resmini getirir.
    func getPictureForPosition(position: String) -> String {
        var picture: String = ""
        if let positions = self.matchsViewModel.selectedMatch.Position {
            for player in positions {
                if(player.positionForMatch == position) {
                    picture = player.picture ?? ""
                    break
                }
            }
        }
        return picture
    }
    
    // MARK: - Get Player Name For Position
    /// İlgili pozisyon için oyuncu ismini getirir.
    func getPlayerNameForPosition(position: String) -> String {
        var playerName: String = ""
        if let positions = self.matchsViewModel.selectedMatch.Position {
            for player in positions {
                if(player.positionForMatch == position) {
                    playerName = player.nameSurname ?? ""
                    break
                }
            }
        }
        return playerName
    }
    
    // MARK: - Is Active Position
    /// TopList' te bulunan kullanıcı kartlarına tıklanınca çıkan
    /// menu butonlarından dolan pozisyonları çıkartır.
    func isActivePosition(itemPosition: String) -> Bool {
        var isActive = false
        if let positions = self.matchsViewModel.selectedMatch.Position {
            for position in positions {
                if(position.positionForMatch == itemPosition) {
                    isActive = true
                    break
                }
            }
        }
        return isActive
    }
    
    // MARK: - Delete Image
    var deleteImage: some View {
        Image(systemName: "minus.circle.fill")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 12, height: 12, alignment: .center)
            .padding(.all, 3)
            .background(Color.white)
            .cornerRadius(6)
    }
    
    // MARK: - Info Button
    var infoButton: some View {
        Image(systemName: "info.circle.fill")
            .resizable()
            .foregroundColor(.black.opacity(0.5))
            .frame(width: 24, height: 24, alignment: .center)
            .padding(.all, 3)
            .onTapGestureForced {
                withAnimation {
                    self.isInfoViewShowing = true
                }
            }
    }
    
    // MARK: - Match Plan Is Ok Button
    func matchPlanIsOkButton(isOk: Bool) -> some View {
        return Image(systemName: isOk ? "checkmark.seal.fill" : "checkmark.seal")
            .resizable()
            .foregroundColor(isOk ? .green.opacity(0.5) : .red.opacity(0.5))
            .frame(width: 24, height: 24, alignment: .center)
            .padding(.all, 3)
            .onTapGestureForced {
                if(self.baseViewModel.userModel?.authority == "admin") {
                    self.matchsViewModel.setIsPlanningCompleteForMatch(matchID: self.matchID)
                }
            }
    }
    
    // MARK: - Team A Text
    var teamAText: some View {
        Text("Takım A")
            .foregroundColor(.white)
            .frame(height: 24, alignment: .center)
            .font(Font.system(size: 13))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color.blue)
            .cornerRadius(12, corners: .topRight)
            .cornerRadius(12, corners: .bottomRight)
            .padding(.top)
    }
    
    // MARK: - Team B Text
    var teamBText: some View {
        Text("Takım B")
            .foregroundColor(.white)
            .frame(height: 24, alignment: .center)
            .font(Font.system(size: 13))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color.red)
            .cornerRadius(12, corners: .topLeft)
            .cornerRadius(12, corners: .bottomLeft)
            .padding(.bottom)
    }
    
}

// MARK: - Previews
struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(matchID: "")
            .environmentObject(MatchsViewModel())
            .environmentObject(BaseViewModel())
    }
}
