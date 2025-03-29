//
//  NotesApp.swift
//  Slidey
//
//  Created by Himanshu Jaswal on 2/20/25.
//

import SwiftUI
import UIKit
import PencilKit

struct NotesApp: View {
    
    @State var canvas = PKCanvasView()
    @State var canvasTool = PKInkingTool(.pen, width: 4)
    @State var defaultCanvasColor = Color.black
    
    var body: some View {
        HStack(spacing: 0) {
            // Notes Sidebar
            VStack {
                Button {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeNotes"), object: self, userInfo: nil)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(red: 0.93, green: 0.38, blue: 0.41))
                        .font(.system(size: 32, weight: .regular, design: .default))
                }
                .padding(.trailing, 80)
                .padding(.top)

                VStack(alignment: .leading, spacing: 5) {
                    Text("iCloud")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .bold()
                    HStack {
                        Image(systemName: "Folder")
                        Text("Notes")
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 4)
                    .foregroundColor(.white)
                    .background(Color(red: 0.94, green: 0.77, blue: 0.32))
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    
                }
                .padding(.top)
                Spacer()
            }
            .frame(width: 150)
            .background(.thinMaterial)
            
            // Main notes content
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Spacer()
                    Button {
                        canvas.tool = PKInkingTool(.pen, color: UIColor(defaultCanvasColor), width: 6)
                    } label: {
                        Image(systemName: "pencil.tip")
                            .foregroundColor(Color(red: 0.71, green: 0.70, blue: 0.71))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding(.vertical)
                    
                    Button {
                        canvas.tool = PKInkingTool(.marker, color: UIColor(defaultCanvasColor), width: 20)
                    } label: {
                        Image(systemName: "highlighter")
                            .foregroundColor(Color(red: 0.71, green: 0.70, blue: 0.71))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding(.vertical)
                    
                    Button {
                        canvas.tool = PKEraserTool(.vector)
                    } label: {
                        Image(systemName: "eraser.line.dashed")
                            .foregroundColor(Color(red: 0.71, green: 0.70, blue: 0.71))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding(.vertical)
                    
                    Button {
                        canvas.tool = PKLassoTool()
                    } label: {
                        Image(systemName: "lasso")
                            .foregroundColor(Color(red: 0.71, green: 0.70, blue: 0.71))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding(.vertical)

                    Divider()
                        .frame(maxHeight: 40)

                    Button {
                        canvas.drawing = PKDrawing()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(Color(red: 0.71, green: 0.70, blue: 0.71))
                            .font(.system(size: 20, weight: .regular, design: .default))
                    }
                    .padding(.trailing)
                        
                }
                .padding(.leading)
                .frame(height: 70)
                .background(.thickMaterial)
                
                // Drawing Canvas
                Canvas(canvas: canvas, canvasTool: canvasTool)
                
            }
            .background(.white)
  
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct NotesApp_Previews: PreviewProvider {
    static var previews: some View {
        NotesApp()
    }
}

// Use a UIViewRepresentable to bring in PKCanvasView

struct Canvas: UIViewRepresentable {
    var canvas: PKCanvasView
    var canvasTool: PKInkingTool
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.tool = canvasTool
        canvas.drawingPolicy = .pencilOnly

        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        canvas.drawingPolicy = .pencilOnly
        
        DispatchQueue.main.async {
            self.canvas.becomeFirstResponder()
            uiView.becomeFirstResponder()
            
        }
    }
}
