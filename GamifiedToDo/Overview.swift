//
//  Overview.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct Overview: View {
    
    @State var selectedTab = "Dailies"
    @StateObject var userModel = UserModel(user: User.getASampleUser())
    
    init() {
        Rules.initRules()
    }
    
    var body: some View {
        ZStack {
            TabView (selection: $selectedTab){
                Group {
                    DailiesView(user: $userModel.user)
                        .tabItem {
                            Label("Dailies", systemImage: "calendar")
                        }
                        .tag("Dailies")
                    ToDoView(user: $userModel.user)
                        .tabItem {
                            Label("To Do's", systemImage: "checkmark.square.fill")
                        }
                        .tag("TODos")
                    AvatarSelectionView()
                        .tabItem {
                            Label("Rewards", systemImage: "envelope.fill")
                        }
                        .tag("Rewards")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            }
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
