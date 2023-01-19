///
///
///
///
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
