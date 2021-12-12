//
//  SwiftUIView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 08/12/2021.
//

import SwiftUI
import Combine




struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL

    var body: some View {
        NavigationView{
        VStack(alignment: .leading)  {
           // Spacer().frame(height: 20)
            Streak().frame(minHeight: 100, idealHeight: 150, maxHeight: 200)
            Spacer()
            VStack{
                 NavigationLink(destination: UnlockedPoemsView()){
                     SettingsButton(title: "Unlocked Poems", subtitle: "__ of 1,800")
                }
                Divider()
                
                NavigationLink(destination: CreditsView()){
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
                    SettingsButton(title: "Developer Website", subtitle: "SaLTformySquid.com", imageName: "rectangle.portrait.and.arrow.right")
                }
                )
                Divider()
            }
            Spacer()
            Spacer()
            HStack{
                Spacer()
                Text("**A** **gift** **for** **Heidi**  \n who heard my words, \n and gave me so many new ones.").font(Font.system(size: 14).smallCaps()) .multilineTextAlignment(.center).foregroundColor(Color("gray1"))
                Spacer()
            }
        }.padding(20).padding(.top, -60).navigationBarItems(leading:
            Button(
                action: { presentationMode.wrappedValue.dismiss() },
                label: {
                    Image(systemName: "xmark").foregroundColor(Color("gray1"))
                }).frame(width: 24, height: 24, alignment: .leading).font(.system(size: 14)
                                                                        )
        ).navigationTitle("")
        }
    }
}

struct Streak: View {
    @State var name: String = (UserDefaults.standard.object(forKey: "Name") as? String ) ?? "You"
    
    let logins = UserDefaults.standard.integer(forKey: "launchedBefore")
    
    var body: some View {
        Color.settingsGray.overlay(
            VStack(alignment: .leading) {
                Spacer()
            Text("\(name) and Emily have been talking for —").font(.system(size: 14)).foregroundColor(Color("gray1"))
                Spacer()
                Text("\(logins) Days").font(.system(size: 32)).foregroundColor(Color("gray1"))
                Spacer()
                Spacer()
            Text("Current streak - _ days").font(.system(size: 14)).foregroundColor(Color("gray1"))
                Text("Longest streak - _ days").font(.system(size: 14)).foregroundColor(Color("gray2"))
                Spacer()
        })
    }
}

struct SettingsButton: View {
   // typealias Body = <#type#>
    
    @State var title: String
    @State var subtitle: String
    @State var imageName : String?
    
    var body: some View {
        HStack{
        VStack(alignment: .leading) {
            Text(title).fontWeight(.light).font(.system(size: 18)).foregroundColor(Color("gray1"))
                //.font(name: "SFProText-Light", size: 18)
                //.font(.system(size: 18)).foregroundColor(.gr)
            Spacer().frame(height: 8)
            Text(subtitle).fontWeight(.light).font(.system(size: 14)).foregroundColor(Color("gray2"))
        }
            Spacer()
            Image(systemName: imageName ?? "chevron.right").foregroundColor(Color("gray1")).font(.system(size: 14))
        }.foregroundColor(.black)
    }
}



extension Color {
    static let settingsGray = Color("settingsGray")
    static let gray1 = Color("gray1")
    static let gray2 = Color("gray2")
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}



