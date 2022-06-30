//
//  MatchsView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 13.06.2022.
//

import SwiftUI

struct MatchsView: View {
    
    @EnvironmentObject var baseViewModel: BaseViewModel
    @EnvironmentObject var matchsViewModel: MatchsViewModel
    @State var didAppear = false
    @State var isRefresh: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(self.matchsViewModel.matchsModelList, id: \.matchID) { match in
                            if let match = match {
                                NavigationLink {
                                    MatchDetailView(matchID: match.matchID ?? "")
                                } label: {
                                    MatchCardCell(match: match)
                                }
                            }
                        }
                    }
                    .fillAll()
                    .padding()
                }
                .fillAll()
                if(self.baseViewModel.isLoad || self.matchsViewModel.isLoad) {
                    LoadingView()
                        .fillAll()
                }
                if(self.matchsViewModel.showAlert) {
                    MessageDialog(title: "Hata !",
                                  message: self.matchsViewModel.errorMessage,
                                  icon: .error,
                                  isShow: self.$matchsViewModel.showAlert)
                }
                if(self.baseViewModel.showAlert) {
                    MessageDialog(title: "Hata !",
                                  message: self.baseViewModel.errorMessage,
                                  icon: .error,
                                  isShow: self.$baseViewModel.showAlert)
                }
            }
            .fillAll()
            .navigationTitle(self.baseViewModel.getNavigationTitleForBaseView())
            .navigationBarItems(leading: self.baseViewModel.userModel?.authority == "admin" ?
                                self.createMatchButton :
                                    nil,
                                trailing: self.refreshButton)
            .onAppear {
                if(!self.didAppear) {
                    if(self.matchsViewModel.matchsModelList.isEmpty) {
                        self.matchsViewModel.getAllMatchs()
                    }
                    if(self.baseViewModel.userModel == nil) {
                        self.baseViewModel.getCurrentUserData()
                    }
                }
                self.didAppear = true
            }
            .onChange(of: self.isRefresh) { newValue in
                if(newValue) {
                    self.matchsViewModel.getAllMatchs()
                }
                self.isRefresh = false
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
                self.matchsViewModel.getAllMatchs()
            }
    }
    
    var createMatchButton: some View {
        NavigationLink {
            CreateMatchView(isRefreshMatchsView: self.$isRefresh)
        } label: {
            Text("Maç oluştur")
                .foregroundColor(Color.white)
                .font(Font.system(size: 13))
                .frame(width: 100, height: 24, alignment: .center)
                .padding(.all, 3)
                .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .orange]),
                                           startPoint: .leading,
                                           endPoint: .trailing))
                .cornerRadius(12, corners: .topRight)
                .cornerRadius(12, corners: .bottomRight)
        }
    }
}

struct MatchsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchsView()
            .environmentObject(BaseViewModel())
            .environmentObject(MatchsViewModel())
    }
}
