//
//  UnlockedPoemsView.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import SwiftUI
import MessageUI

struct UnlockedPoemsView: View {
    
    @State private var showingMail = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Unlocked Poems").font(.titleOne)
            Spacer()
            Text("Future releases plan to add ability to browse your unlocked poems and other special features.").font(.body)
            Spacer()
            Text("Please boost our morale with ... ").font(.body)
                VStack{
                    Spacer()
                    Divider()
                    Button(action: {
                                if let writeReviewURL = URL(string: "https://apps.apple.com/app/id1591017862?action=write-review")
                                { openURL(URL(string: "writeReviewURL")!)}
                             
                        }, label: {
                            SettingsButton(title: "A nice review", subtitle: "", imageName: "rectangle.portrait.and.arrow.right")
                        }
                    )
                    Divider()
                    Spacer()
                }
             VStack{
                    Spacer()
                    Divider()
                    Button(action: {
                        self.showingMail.toggle()
                    }, label: {
                        SettingsButton(title: "Get in touch", subtitle: "What extra features would you like?", imageName: "envelope")
                    }
                    )
                    Divider()
                    Spacer()
                }
                .sheet(isPresented: $showingMail) {
                    MailComposeViewController(toRecipients: ["emily@saltformysquid.com"], mailBody: "We'd love to hear what you think!") { }  }
            VStack{
                    Spacer()
                    Divider()
                    Button(action: {
                            openURL(URL(string: "https://www.justgiving.com/fundraising/emilyapp")!)
                        }, label: {
                                SettingsButton(title: "Donate to our preferred charity", subtitle: "", imageName: "rectangle.portrait.and.arrow.right")
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


//struct GetInTouchButton: View {
//
//    @State var title: String
//
//    var body: some View {
//        HStack{
//            VStack(alignment: .leading) {
//                Text(title).fontWeight(.light).font(.system(size: 18)).foregroundColor(Color("gray1"))
//            }
//            Spacer()
//            Image(systemName:  "envelope").foregroundColor(Color("gray1")).font(.system(size: 14))
//        }.foregroundColor(.black)
//    }
//



struct MailComposeViewController: UIViewControllerRepresentable {
    
    var toRecipients: [String]
    var mailBody: String
    
    var didFinish: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: true)
        
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var parent: MailComposeViewController
        
        init(_ mailController: MailComposeViewController) {
            self.parent = mailController
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
        
    }
}
