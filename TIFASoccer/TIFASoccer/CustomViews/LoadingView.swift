//
//  LoadingView.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
                .scaleEffect(CGSize(width: 2, height: 2), anchor: .center)
        }
        .fillAll()
        .background(Color.white.opacity(0.5))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
