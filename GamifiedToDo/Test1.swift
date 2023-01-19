//
//  Test1.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/19/23.
//

import SwiftUI

struct Test1: View {
    var body: some View {
        VStack {
            List {
                Section(header: Spacer(minLength: 0)) {
                    Text(verbatim: "First Section")
                }

                Section {
                    Text(verbatim: "Second Section")
                }
            }
            .listStyle(GroupedListStyle())
            //.listStyle(PlainListStyle())
        }
       
    }
}

struct Test1_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}
