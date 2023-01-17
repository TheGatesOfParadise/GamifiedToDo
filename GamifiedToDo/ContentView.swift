//
//  ContentView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel : UserModel
    
    //tobe deleted
    init() {
        let rules = Rules()
        Rules.printRules()
    }
    //end
    
    var body: some View {
       Overview()
            .environmentObject(UserModel(user: User.getASampleUser(), rules: Rules()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserModel(user: User.getASampleUser(), rules: Rules()))
    }
}
