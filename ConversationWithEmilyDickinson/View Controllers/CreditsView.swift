//
//  CreditsView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import SwiftUI

struct CreditsView: View {
    
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        VStack{
        VStack(alignment: .leading){
            Text("Credits").font(.titleOne).foregroundColor(Color("gray1"))
            Spacer().frame(height: 32)
            Text("Poetry by Emily Dickinson").font(.bodyBold).foregroundColor(Color("gray1"))
            Spacer().frame(height: 24)
            Text("Emily Elizabeth Dickinson (December 10, 1830 – May 15, 1886) was an American poet. Little-known during her life, she has since been regarded as one of the most important figures in American poetry.").font(.body).foregroundColor(Color("gray1")).fontWeight(.light)
            Divider()
            Button(action: {
                openURL(URL(string: "https://www.poetryfoundation.org/poets/emily-dickinson")!)
            }, label: {
                MoreButton(title: "Learn more about Emily Dickinson")
            }
            )
            Divider()
        }
        Spacer()
        VStack(alignment: .leading){
            Text("Source of Text").font(.bodyBold).foregroundColor(Color("gray1")).scaledToFit()
            Spacer().frame(height: 24)
            Text("Project Gutenberg is a volunteer effort to digitize and archive cultural works.").font(.body).foregroundColor(Color("gray1")).fontWeight(.light)
            Divider()
            Button(action: {
                openURL(URL(string: "https://www.gutenberg.org/policy/license.html")!)
            }, label: {
                MoreButton(title: "Learn more about Project Gutenberg")
            }
            )
            Divider()
        }
            Spacer()
            Spacer()
        }.padding(20).foregroundColor(Color("gray1"))
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}


struct MoreButton: View {

    @State var title: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(title).fontWeight(.light).font(.system(size: 18)).foregroundColor(Color("gray1"))
            }
            Spacer()
            Image(systemName:  "rectangle.portrait.and.arrow.right").foregroundColor(Color("gray1")).font(.system(size: 14))
        }.foregroundColor(.black)
    }
}


struct CreditsView14: View {
    
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Credits").font(.titleOne).foregroundColor(Color("gray1"))
                Spacer().frame(height: 16)
                Text("Poetry by Emily Dickinson").font(.bodyBold).foregroundColor(Color("gray1")).scaledToFit()
                Spacer().frame(height: 16)
                Text("One of the most important figures in American poetry. Lived 1830 -1886.").font(.body).foregroundColor(Color("gray1")).fontWeight(.light).lineLimit(3)
                Divider()
                Button(action: {
                    openURL(URL(string: "https://www.poetryfoundation.org/poets/emily-dickinson")!)
                }, label: {
                    MoreButton14(title: "Learn more about Emily Dickinson")
                }
                )
                Divider()
            }
            Spacer()
            VStack(alignment: .leading){
                Text("Source of Text").font(.bodyBold).foregroundColor(Color("gray1")).scaledToFit()
                Spacer().frame(height: 16)
                Text("Project Gutenberg is a volunteer effort to digitize cultural works.").font(.body).foregroundColor(Color("gray1")).fontWeight(.light).lineLimit(3)
                Divider()
                Button(action: {
                    openURL(URL(string: "https://www.gutenberg.org/policy/license.html")!)
                }, label: {
                    MoreButton14(title: "Learn more about Project Gutenberg")
                }
                )
                Divider()
            }
            Spacer()
            Spacer()
        }.padding(20).foregroundColor(Color("gray1"))
    }
}

struct CreditsView14_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView14()
    }
}


struct MoreButton14: View {
    
    @State var title: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(title).fontWeight(.light).font(.system(size: 18)).foregroundColor(Color("gray1")).scaledToFit().minimumScaleFactor(0.5)
            }
            Spacer()
            Image(systemName:  "chevron.right").foregroundColor(Color("gray1")).font(.system(size: 14))
        }.foregroundColor(.black)
    }
}
