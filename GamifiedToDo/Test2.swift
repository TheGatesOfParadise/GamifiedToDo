//
//  Test2.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct Test2: View {
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            Text("1")
            Text("--")
            Text("4")
        }
        .font(.system(size: 10))
        .bold()

    }
}




struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
