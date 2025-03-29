//
//  OSView.swift
//  Slidey
//
//  Created by Himanshu Jaswal on 2/20/25.
//

import SwiftUI

struct OSView: View {
    
    @State var showingBootView = false
    let hideBootView = NotificationCenter.default.publisher(for: NSNotification.Name("closeBoot"))
    
    @State var showingDesktop = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            if showingBootView {
                BootupView()
            }
            
            if showingDesktop {
                DesktopView()
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    showingBootView = true
                }
            }
        }
        .onReceive(hideBootView) {_ in
            withAnimation(.easeIn(duration: 0.7)) {
                showingBootView = false
                showingDesktop = true
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct OSView_Previews: PreviewProvider {
    static var previews: some View {
        OSView()
    }
}

struct BootupView: View {
    
    @State var bootTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var bootTimerAmount = 0.0
    
    var body: some View {
        VStack {
            Image(systemName: "apple.logo")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
            ProgressView("", value: bootTimerAmount, total: 100)
                .tint(.white)
                .scaleEffect(x: 1, y: 1.3, anchor: .center)
                .padding(.vertical)
        }
        .foregroundColor(.white)
        .onReceive(bootTimer) {_ in
            if bootTimerAmount < 100 {
                bootTimerAmount += 0.50
            } else {
                bootTimer.upstream.connect().cancel()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeBoot"), object: self, userInfo: nil)
            }
        }
        .frame(maxWidth: 260)
    }
}
