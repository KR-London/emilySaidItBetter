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
            Text("Unlocked Poems").font(.title)
            Spacer()
            Text("Future releases plan to add ability to browse your unlocked poems")
            Spacer()
            Text("Please boost our morale with ... ")
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
            Text("... or ... ")
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
        }.padding(20)
    }
}

struct UnlockedPoemsView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockedPoemsView()
    }
}
