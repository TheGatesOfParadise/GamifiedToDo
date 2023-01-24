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
        VStack{
            Text(testString)
            Button("Show Credits") {
                showingCredits.toggle()
            }
            .sheet(isPresented: $showingCredits) {
               sheetView(testString: $testString)
                    .presentationDetents([.medium])
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
