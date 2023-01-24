///
///
///
///

import SwiftUI

struct Overview: View {
    
    @State var selectedTab = "TODos"
    @EnvironmentObject var userModel : UserModel
        
    var body: some View {
        ZStack {
            TabView (selection: $selectedTab){
                Group {
                    ToDoView()
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
        Overview().environmentObject(UserModel())
    }
}
