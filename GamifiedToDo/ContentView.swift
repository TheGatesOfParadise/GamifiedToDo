///
///
///
///
import SwiftUI

struct ContentView: View {
    var body: some View {
        Overview()
            .environmentObject(DataModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DataModel())
    }
}
