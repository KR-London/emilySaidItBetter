//
//  UnlockedPoemsView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import SwiftUI

struct UnlockedPoemsView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Unlocked Poems").font(.titleOne)
            Spacer()
            Text("Future releases plan to add ability to browse your unlocked poems").font(.body)
            Spacer()
            Text("Please boost our morale with ... ").font(.body)
            VStack{
            Spacer()
            Divider()
            Button(action: {
                print("Action goes here")
            }, label: {
                MoreButton(title: "A nice review")
            }
            )
             Divider()
            Spacer()
            }
            Text("... or ... ").font(.body)
            VStack{
            Spacer()
            Divider()
            Button(action: {
                print("Action goes here")
            }, label: {
                MoreButton(title: "Donations to XXXXXXX charity")
            }
            )
            Divider()
            Spacer()
            }
        }.padding(20).foregroundColor(Color("gray1"))
    }
}

struct UnlockedPoemsView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockedPoemsView()
    }
}
