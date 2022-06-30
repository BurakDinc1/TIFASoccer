//
//  PlayersView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 10.06.2022.
//

import SwiftUI

struct PlayersView: View {
    
    @State var didAppear = false
    @EnvironmentObject var baseViewModel: BaseViewModel
    @EnvironmentObject var playersViewModel: PlayersViewModel
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: self.columns) {
                        ForEach(self.playersViewModel.userModelList, id: \.uuid) { user in
                            PlayerCardCell(user: .constant(user))
                        }
                    }
                    .fillAll()
                    .padding()
                }
                .fillAll()
                if(self.playersViewModel.isLoad) {
                    LoadingView()
                        .fillAll()
                }
                if(self.playersViewModel.showAlert) {
                    MessageDialog(title: "Hata !",
                                  message: self.playersViewModel.errorMessage,
                                  icon: .error,
                                  isShow: self.$playersViewModel.showAlert)
                }
            }
            .fillAll()
            .navigationTitle(self.baseViewModel.getNavigationTitleForBaseView())
            .navigationBarItems(trailing: self.refreshButton)
            .onAppear {
                if(!self.didAppear) {
                    if(self.playersViewModel.userModelList.isEmpty) {
                        self.playersViewModel.getAllPlayers()
                    }
                }
                self.didAppear = true
            }
        }
    }
    
    var refreshButton: some View {
        Image(systemName: "arrow.counterclockwise.circle.fill")
            .resizable()
            .foregroundColor(.black.opacity(0.5))
            .frame(width: 24, height: 24, alignment: .center)
            .padding(.all, 3)
            .onTapGestureForced {
                self.playersViewModel.getAllPlayers()
            }
    }
}

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView()
            .environmentObject(BaseViewModel())
            .environmentObject(PlayersViewModel())
    }
}
