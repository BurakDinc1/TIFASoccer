//
//  BaseView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

struct BaseView: View {
    
    @StateObject var baseViewModel: BaseViewModel = BaseViewModel()
    @StateObject var playersViewModel: PlayersViewModel = PlayersViewModel()
    @StateObject var matchsViewModel: MatchsViewModel = MatchsViewModel()
    
    var body: some View {
        TabView(selection: self.$baseViewModel.selection) {
            MatchsView()
                .environmentObject(self.matchsViewModel)
                .tabItem {
                    Image(systemName: "sportscourt")
                }.tag(1)
            PlayersView()
                .environmentObject(self.playersViewModel)
                .tabItem {
                    Image(systemName: "person.3")
                }.tag(2)
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }.tag(3)
        }
        .environmentObject(self.baseViewModel)
        .accentColor(Color.orange)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
