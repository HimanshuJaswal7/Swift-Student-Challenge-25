//
//  MessageApp.swift
//  Slidey
//
//  Created by Himanshu Jaswal on 2/20/25.
//

import SwiftUI

struct MessageApp: View {
    
    @State var message2Animation = false
    @State var message3Animation = false
    @State var message4Animation = false
    @State var message5Animation = false
    @State var message6Animation = false
    @State var keynoteSendMessage = false
    @State var message7Animation = false
    @State var message8Animation = false
    @State var message9Animation = false
    @State var hasCompletedInitialMessage: Bool
    
    let keynoteOnTop = NotificationCenter.default.publisher(for: NSNotification.Name("keynoteOnTop"))
    
    var body: some View {
        HStack(spacing: 0) {
            // Messages Sidebar
            VStack {
                Button {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeMessages"), object: self, userInfo: nil)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(red: 0.93, green: 0.38, blue: 0.41))
                        .font(.system(size: 32, weight: .regular, design: .default))
                }
                .padding(.trailing, 40)
                .padding(.top)
                
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .padding(.top, 10)
                    .padding(.bottom, -8)
                
                ScrollView {
                    ZStack {
                        Color.blue
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                        Group {
                            Color(red: 0.76, green: 0.75, blue: 0.99)
                                .clipShape(Circle())
                            Text("🍎")
                                .foregroundColor(Color(red: 0.92, green: 0.30, blue: 0.27))
                                .font(.system(size: 30, weight: .bold))
                        }
                        .frame(maxWidth: 55, maxHeight: 55)
                    }
                    .padding([.leading, .trailing, .bottom])
                    .padding(.top, 8)
                }
                Spacer()
            }
            .background(.thinMaterial)

            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Text("To: ")
                        .foregroundColor(.gray)
                    + Text ("Apple Event Group Chat")
                    
                    Spacer()
                    
                    Image(systemName: "video")
                        .foregroundColor(.gray)
                        .font(.system(size: 20, weight: .medium))
                        .padding()
                }
                .padding(.leading)
                .frame(height: 60)
                .background(.thickMaterial)
                
                ScrollViewReader { value in
                    ZStack {
                        Color.white
                        ScrollView {
                            HStack {
                                VStack {
                                    VStack(alignment: .leading) {
                                        SingleMessageView(contactName: "Craig Federighi", contactImage: "C", messageContents: "Hey \(personName)! We need your help!")
                                        
                                        if message2Animation {
                                            
                                            SingleMessageView(contactName: "Tim", contactImage: "T", messageContents: "We're getting ready for WWDC25 and we forgot the slides!")
                                        }
                                        
                                        if message3Animation {
                                            
                                            ContMessageView(contactName: "Craig Federighi", messageContents: "\(personName), I think the Keynote is on your desktop.")
                                        }
                                        
                                        if message4Animation {
                                            ContMessageView(contactName: "", messageContents: "Could you send over the file?")
                                        }
                                        
                                        if message5Animation {
                                            SingleMessageView(contactName: "", contactImage: "C", messageContents: "Drag and drop the file into the Messages app to send the Keynote over.")
                                        }
                                        
                                    }
                                    .padding()
                                    
                                    Spacer()
                                    
                                    if message6Animation {
                                        Group {
                                            Image(systemName: "cursorarrow.and.square.on.square.dashed")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 50, weight: .medium))
                                            Text("Drag and drop the WWDC25 Keynote file into Messages")
                                                .foregroundColor(.gray)
                                        }
                                        .id(6)
                                    }
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if keynoteSendMessage {
                                        KeynoteMessage()
                                        
                                        Text("Here is the Keynote!")
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(.white)
                                            .padding(7.0)
                                            .background(Color(red: 0.04, green: 0.46, blue: 1.00))
                                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                    }
                                }
                            }
                            .padding(.trailing)
                            
                            HStack {
                                VStack {
                                    VStack(alignment: .leading) {
                                        if message7Animation {
                                            SingleMessageView(contactName: "Craig Federighi", contactImage: "C", messageContents: "Yep, those are the slides!")
                                                .id(7)
                                        }
                                        
                                        if message8Animation {
                                            SingleMessageView(contactName: "Tim", contactImage: "T", messageContents: "Thanks \(personName)!")
                                                .id(8)
                                        }
                                        
                                        if message9Animation {
                                            SingleMessageView(contactName: "Craig Federighi", contactImage: "C", messageContents: "Thanks for saving WWDC! Since we still have time, feel free to play around! If you ever get lost, tap on spotlight (magnifying glass) in the menu bar to see a list of all apps!")
                                                .padding(.bottom, 60)
                                                .id(9)
                                        }
                                        
                                        if message9Animation {
                                            // A backup to scroll past the last message
                                            Text("")
                                                .frame(height: 20)
                                                .id(10)
                                        }
                                    }
                                    .padding()
                                }
                                Spacer()
                            }
                        }
                    }
                    .onReceive(keynoteOnTop) {_ in
                        hasCompletedInitialMessage = true
                        withAnimation {
                            value.scrollTo(7)
                            message6Animation = false
                            keynoteSendMessage = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                                message6Animation = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    message7Animation = true
                                }
                                value.scrollTo(7)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                                withAnimation {
                                    message8Animation = true
                                }
                                value.scrollTo(8)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateZValKeynote"), object: self, userInfo: nil)
                                withAnimation {
                                    message9Animation = true
                                }
                                value.scrollTo(9)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.7) {
                                value.scrollTo(10)
                            }
                        }
                    }
                    .onAppear {
                        if !hasCompletedInitialMessage {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    message2Animation = true
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                withAnimation {
                                    message3Animation = true
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                withAnimation {
                                    message4Animation = true
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                                withAnimation {
                                    message5Animation = true
                                    message6Animation = true
                                }
                                value.scrollTo(6)
                            }
                            
                        } else {
                            message2Animation = true
                            message3Animation = true
                            message4Animation = true
                            message5Animation = true
                            message6Animation = false
                            keynoteSendMessage = true
                            message7Animation = true
                            message8Animation = true
                            message9Animation = true
                        }
                    }
                    
                }
                
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct MessageApp_Previews: PreviewProvider {
    static var previews: some View {
        MessageApp(hasCompletedInitialMessage: true)
    }
}


struct SingleMessageView: View {
    
    var contactName: String
    var contactImage: String
    var messageContents: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 0.60, green: 0.62, blue: 0.66))
                    .frame(width: 30, height: 30)
                Text(contactImage)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
            }
            .offset(y: 6)
            
            VStack(alignment: .leading, spacing: 0) {
                if contactName != "" {
                    Text(contactName)
                        .foregroundColor(.gray)
                        .font(.system(size: 11, weight: .medium))
                        .padding(.bottom, 3)
                }
                
                Text(messageContents)
                    .font(.system(size: 17, weight: .regular))
                    .padding(7.0)
                    .background(Color(red: 0.90, green: 0.90, blue: 0.91))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .padding(.leading, 2)
            
        }
    }
}

struct ContMessageView: View {
    
    var contactName: String
    var messageContents: String
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
            
                .offset(y: 6)
            VStack(alignment: .leading, spacing: 0) {
                if contactName != "" {
                    Text(contactName)
                        .foregroundColor(.gray)
                        .font(.system(size: 11, weight: .medium))
                        .padding(.bottom, 3)
                }
                
                Text(messageContents)
                    .font(.system(size: 17, weight: .regular))
                    .padding(7.0)
                    .background(Color(red: 0.90, green: 0.90, blue: 0.91))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
        }
    }
}

struct KeynoteMessage: View {
    var body: some View {
        HStack {
            Image("KeynoteThumbnail")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 45)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .padding(.leading)
                .overlay {
                    Image("KeynoteIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 25)
                        .offset(x: 40, y: 12)
                        .shadow(radius: 4)
                }
            
            VStack(alignment: .leading) {
                Text("WWDC25 Keynote")
                    .font(.system(size: 13, weight: .medium))
                Text("Keynote Presentation · 2.8 GB")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 4)
            
            Spacer()
        }
        .frame(width: 300, height: 75)
        .background(Color(red: 0.90, green: 0.90, blue: 0.91))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))   
    }
}
