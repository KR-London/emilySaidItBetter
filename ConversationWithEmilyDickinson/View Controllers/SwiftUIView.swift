//
//  SwiftUIView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 08/12/2021.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading)  {
            Button(action: { presentationMode.wrappedValue.dismiss() }, label: {Image(systemName: "xmark").foregroundColor(Color("gray1"))}).frame(width: 24, height: 24, alignment: .leading).font(.system(size: 14))
            Spacer().frame(height: 20)
            Streak().frame(minHeight: 100, idealHeight: 150, maxHeight: 200)
            Spacer()
            VStack{
                Button(action: {
                    print("Action goes here")
                }, label: {
                    SettingsButton(title: "Unlocked Poems", subtitle: "18 of 1,800")
                }
                )
                Divider()
                Button(action: {
                    print("Action goes here")
                }, label: {
                    SettingsButton(title: "Credits", subtitle: "Emily Dickinson & Project Gutenberg")
                }
                )
                Divider()
                Button(action: {
                    print("Action goes here")
                }, label: {
                    SettingsButton(title: "Privacy Policy", subtitle: "How we handle your data")
                }
                )
                Divider()
                Button(action: {
                    print("Action goes here")
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
        }.padding(20)
     
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}

//struct Streak<Content: View>: View {
struct Streak: View {
    //var content: () -> Content
    
    var body: some View {
        Color.settingsGray.overlay(
            VStack(alignment: .leading) {
                Spacer()
            Text("Andrew and Emily have been talking for —").font(.system(size: 14)).foregroundColor(Color("gray1"))
                Spacer()
                Text("20 Days").font(.system(size: 32)).foregroundColor(Color("gray1"))
                Spacer()
                Spacer()
            Text("Current streak - 3 days").font(.system(size: 14)).foregroundColor(Color("gray1"))
                Text("Longest streak - 5 days").font(.system(size: 14)).foregroundColor(Color("gray2"))
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
           // Image(uiImage: #imageLiteral(resourceName: "Pasted Graphic.png"))
        }.foregroundColor(.black)
    }
}


extension Color {
    static let settingsGray = Color("settingsGray")
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        
        SwiftUIView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}

