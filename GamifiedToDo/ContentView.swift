//
//  ContentView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Overview()
            .environmentObject(UserModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserModel())
    }
}
