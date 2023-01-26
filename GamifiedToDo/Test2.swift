//
//  Test2.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/25/23.
//

import SwiftUI

struct Test2: View {

    @State var showDetails = false
    @State var wtfGuys = false
    @State var num: Int = 10

    var body: some View {
        VStack {
            Button(action: {
                showDetails = true
            }) {
                Text("Show sheet")
            }
        }
                .sheet(isPresented: $showDetails) {
                    ZStack {
                        if wtfGuys {
                            DetailView(showDetails: showDetails, num: $num)
                        }
                    }
                            .onAppear {
                                wtfGuys = true
                                num += 100
                            }
                            .onDisappear { wtfGuys = false }
                }
    }
}

struct DetailView: View {

    let showDetails: Bool
    @Binding var num: Int

/*    init(showDetails: Bool, num: Binding<Int>) {
        print(showDetails) // true
        self.showDetails = showDetails
        self.num = num
    }
*/
    var body: some View {
        VStack{
            Text("showDetails: \(showDetails ? "yes" : "no")")
            Text("num=\(num)")
        }
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
