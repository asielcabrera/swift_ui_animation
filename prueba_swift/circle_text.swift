//
//  circle_text.swift
//  prueba_swift
//
//  Created by Asiel Cabrera on 6/22/20.
//  Copyright © 2020 Asiel Cabrera. All rights reserved.
//

import SwiftUI
let lightBlue = Color(UIColor(red: 0.35, green: 0.80, blue: 0.93, alpha: 1.00))

struct circle_text: View {
    @State var time: Double = 0
    @State private var offsetY = 140.0
    @State private var animate = false
    @State private var label = "Downloading"
    
    
    let gradient = LinearGradient(gradient: Gradient(colors: [Color(.blue), lightBlue]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack{
            ZStack{
                CircleFluid(time: CGFloat(time + 1.2))
                    .fill(lightBlue)
                    .frame(width: 100, height: 400)
                CircleFluid(time: CGFloat(time))
                    .fill(gradient)
                    .opacity(0.5)
                    .frame(width: 100, height: 400)
                
            }
            .offset(x: 0, y: CGFloat(self.offsetY))
            .mask(Capsule().frame(width: 100, height: 400))
            
            Button(action: {
                self.animate.toggle()
                self.label = "Downloading...."
            }, label: {
                Text(label)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            })
            .disabled(animate ? true: false)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
                
                self.time += 0.01
                if self.offsetY >= (-210.0) {
                    if self.animate {
                        withAnimation(Animation.linear(duration: 0.03)){
                            self.offsetY -= 1.5
                            
                        }
                    }
                }
                else{
                    self.label = "Done"
                    
                }
            }
        }
    }
}

struct circle_text_Previews: PreviewProvider {
    static var previews: some View {
        circle_text()
    }
}


struct CircleFluid: Shape {
    var time: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return (
            Path {
                path in
                    let curveHeight: CGFloat = 10
//                    let curveLength: CGFloat = 1.5
                    path.move(to: CGPoint(x: 100, y: 800))
                    path.addLine(to: CGPoint(x: 0, y: 800))
                for i in stride(from: 0, to: CGFloat(rect.width), by: 1){
                    path.addLine(to: CGPoint(x: i, y: sin(((i / rect.height) + time) * 4 * .pi) * curveHeight + rect.midY))
                }
                path.addLine(to:  CGPoint(x: 100, y: 800))
                
            }
        )
    }
}
