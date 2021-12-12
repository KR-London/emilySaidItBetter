//
//  PrivacyPolicyView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("Privacy Policy").font(.titleOne)
            Spacer()
            Text("Your thoughts belong to you. This app does not send any personal information off your device. ").font(.body)
            Spacer()
            Text("The AI matching is done locally. It saves your name, poems and logon stats on your handset, but not your words").font(.body)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }.padding(20)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
