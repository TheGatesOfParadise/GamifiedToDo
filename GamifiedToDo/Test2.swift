//
//  Test2.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct Test2: View {
    var body: some View {
        NavigationStack {
                    List {
                        Text("Hello, SwiftUI!")
                    }
                    .navigationTitle("Navigation Title")
                    .toolbarBackground(
                        Color.pink,
                        for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)

                }
    }
}





struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
