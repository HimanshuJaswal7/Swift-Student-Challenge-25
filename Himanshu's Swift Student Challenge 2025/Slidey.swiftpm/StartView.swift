//
//  StartView.swift
//  Slidey
//
//  Created by Himanshu Jaswal on 2/20/25.
//

import SwiftUI

var personName = "WWDC attendee"

struct StartView: View {
    
    // Background colors
    let bgColorSet = [Color(red: 0.00, green: 0.00, blue: 0.18), Color(red: 0.22, green: 0.00, blue: 0.06), Color(red: 0.24, green: 0.00, blue: 0.35), Color(red: 0.00, green: 0.00, blue: 0.49)]
    @State var bgAnimate = false
    
    // Button Colors
    let buttonColorSet = [Color(red: 0.00, green: 0.13, blue: 1.00), Color(red: 0.44, green: 0.99, blue: 0.75), Color(red: 0.88, green: 0.07, blue: 1.00), Color(red: 0.14, green: 0.72, blue: 0.96), Color(red: 1.00, green: 0.00, blue: 0.52), Color(red: 0.00, green: 0.58, blue: 0.00)]
    
    // Button Animation
    let startingPos = 0.7
    @State var buttonMax = false
    
    @State var initialName = ""
    @FocusState var textFieldFocus: Bool
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: bgColorSet), startPoint: bgAnimate ? .topLeading : .bottomLeading, endPoint: bgAnimate ? .bottomTrailing : .topTrailing)
                .background(.ultraThickMaterial)
                .ignoresSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.async {
                        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: true)) {
                            bgAnimate.toggle()
                        }
                    }
                }
            
            VStack {
                
                VStack {
                    // Title & Subtitle Text
                    Group {
                        Image(systemName: "sparkles.rectangle.stack.fill")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                        
                        Text("Slidey")
                            .font(.system(size: 50, weight: .semibold, design: .rounded))
                            .padding(.bottom)
                        
                        Text("You can't have WWDC25 without the presentation. Help the Apple team out before WWDC starts!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .padding(.bottom)
                    }
                    .blur(radius: textFieldFocus ? 20 : 0)
                    
                    // Name Text Field
                    ZStack {
                        Color.white.opacity(0.75)
                        HStack {
                            ZStack(alignment: .leading) {
                                if initialName.isEmpty {
                                    Text("Enter your name (Optional)")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                                TextField("", text: $initialName)
                                    .padding()
                                    .focused($textFieldFocus)
                                    .onChange(of: initialName) {_ in
                                        DispatchQueue.main.async {
                                            personName = initialName
                                        }
                                    }
                            }
                            Spacer()
                            Button("Done") {
                                textFieldFocus = false
                            }
                            .padding(.trailing)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .foregroundColor(.black)
                    .frame(maxWidth: 400, maxHeight: 30)
                    .padding()
                }
                .padding()
                .foregroundColor(.white)
                .background(.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .frame(maxWidth: 500)
                
                NavigationLink {
                    OSView()
                        .transition(.opacity)
                } label: {
                    ZStack {
                        Circle()
                            .strokeBorder(LinearGradient(gradient: Gradient(colors: buttonColorSet), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 18)
                            .opacity(0.8)
                            .scaleEffect(buttonMax ? startingPos : 0.9)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), {
                                    buttonMax = true
                                })
                            }
                        
                        VStack {
                            Text("Start")
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 50, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        
                    }
                    .ignoresSafeArea(.keyboard)
                    .frame(maxWidth: 260, maxHeight: 260)
                }
            }
            .padding(.top, textFieldFocus ? 60: 0)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
