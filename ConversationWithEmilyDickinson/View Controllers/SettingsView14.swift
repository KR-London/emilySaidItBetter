    //
    //  SwiftUIView.swift
    //  ConversationWithEmilyDickinson
    //
    //  Created by Kate Roberts on 08/12/2021.
    //

import SwiftUI
import Combine




struct SettingsView14: View {
   // @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading)  {
                    // Spacer().frame(height: 20)
                Streak().frame(minHeight: 100, idealHeight: 150, maxHeight: 200)
                Spacer()
                VStack{
                    NavigationLink(destination: UnlockedPoemsView()){
                        SettingsButton(title: "Unlocked Poems (coming soon)", subtitle: "Send us some love!")
                    }
                    Divider()
                    
                    NavigationLink(destination: CreditsView14()){
                        SettingsButton(title: "Credits", subtitle: "Emily Dickinson & Project Gutenberg")
                    }
                    Divider() // PrivacyPolicyView.
                    NavigationLink(destination: PrivacyPolicyView()){
                        SettingsButton(title: "Privacy Policy", subtitle: "How we handle your data")
                    }
                    Divider()
                    Button(action: {
                        openURL(URL(string: "https://www.saltformysquid.com")!)
                    }, label: {
                        SettingsButton(title: "Developer Website", subtitle: "SaLTformySquid.com")
                    }
                    )
                    Divider()
                }
                Spacer()
                Spacer()
                HStack{
                    Spacer()
                    Text("A gift for Heidi  \n who heard my words, \n and gave me so many new ones.").font(Font.system(size: 14).smallCaps()) .multilineTextAlignment(.center).foregroundColor(Color("gray1"))
                    Spacer()
                }
            }.padding(20).padding(.top, -60)
        }.navigationTitle("").navigationViewStyle(StackNavigationViewStyle())
    }
}


