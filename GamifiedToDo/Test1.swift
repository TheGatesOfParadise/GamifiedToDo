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
                Text(Date().addingTimeInterval(-4 * 24 * 60 * 60) < Date.now.startOfDay ? "overdue" : "normal")
                    .frame(width: shadeAreaWidth)
                    .border(.blue, width: 5)
                
                Text(Date().addingTimeInterval(4 * 24 * 60 * 60) < Date.now.startOfDay ? "overdue" : "normal")
                    .frame(width: shadeAreaWidth)
                    .border(.blue, width: 5)
           
                Spacer()
            }
        }
        //end
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
