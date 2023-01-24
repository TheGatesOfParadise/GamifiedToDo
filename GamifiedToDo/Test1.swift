//
//  Test1.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/23/23.
//

import SwiftUI

struct Test1: View {
    @State private var showingCredits = false
    @State var testString: String = "abc"

    var body: some View {
        
        //copy
        NavigationView {
            VStack (alignment: .center){
                //show avatar
                Text("ererew")
                    .frame(width: shadeAreaWidth)
                    .offset(y:5)
                    .border(.pink, width: 5)
                
                //show award
                ZStack {
                    Text("ererew")
                        .frame(width: shadeAreaWidth, height: 70)
                        .border(.green, width: 5)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: -100, y : -50)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: 60, y : 70)
                }
                
                
                //list of todos
                Text("ererew")
                    .frame(width: shadeAreaWidth)
                    .border(.blue, width: 5)
           
                Spacer()
            }
        }
        //end
    }
}


struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

struct sheetView: View {
    @Binding var testString: String
    
    var body: some View {
        Button (action: {testString = "def"},
                label: {
                    Text("Change abc to def")
            
        })
    }
}


struct Test1_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}
