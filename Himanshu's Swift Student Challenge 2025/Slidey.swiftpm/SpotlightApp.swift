//
//  SpotlightApp.swift
//  Slidey
//
//  Created by Himanshu Jaswal on 2/20/25.
//

import SwiftUI

struct SpotlightApp: View {
    
    var body: some View {
        VStack {
            Button {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSpotlight"), object: self, userInfo: nil)
            } label: {
                Image(systemName: "xmark.circle")
                Text("Close")
            }
            .buttonStyle(.bordered)
            .padding()
            
            List {
                AppView(name: "Messages", appIcon: "MessageIcon", appDescription: "Send and Receive Messages to and from the Apple Event Group Chat")
                
                AppView(name: "Keynote", appIcon: "KeynoteIcon", appDescription: "Look through the WWDC 2025 Keynote that you sent in the Apple Event Group Chat")
                
                AppView(name: "Notes", appIcon: "NotesIcon", appDescription: "Use your Apple Pencil to draw and take notes")
                
                AppView(name: "Countdown", appIcon: "CountdownIcon", appDescription: "Count down the days until WWDC 2025")
                
                AppView(name: "AR Experience", appIcon: "ARIcon", appDescription: "An interactive AR Experience about WWDC 2025")
            }
        }
        .background(.thinMaterial)
    }
}

struct SpotlightApp_Previews: PreviewProvider {
    static var previews: some View {
        SpotlightApp()
    }
}

struct AppView: View {
    
    @State var name: String
    @State var appIcon: String
    @State var appDescription: String
    
    var body: some View {
        HStack {
            Image(appIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text(appDescription)
                    .font(.system(size: 17, weight: .regular, design: .rounded))
            }
            .padding(.leading)
            
        }
    }
}
