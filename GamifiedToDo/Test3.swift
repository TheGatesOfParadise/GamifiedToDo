//
//  Test3.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/11/23.
//

import SwiftUI

struct Test3: View {
    @Binding var toDo: Todo
    @State private var datePopOverPresented = false
    var body: some View {
        Form{
            Section (header: Text("Due Date")){
                HStack{
                    Text(toDo.dueDateString())
                    Spacer()
                    //ZCalendar(date: $toDo.due_date)
                    
                    //copy start
                    
                    //date
                    Button(action: {
                        datePopOverPresented = true
                    },
                           label: {
                        Image(systemName: "calendar")
                    })
                    //date selection popover
                    .popover(isPresented: $datePopOverPresented) {
                        DateSelectionView(dateIn: $toDo.due_date,
                                          isShowing: $datePopOverPresented,
                                          localDate: toDo.due_date)
                    }
                    
                    //copy end
                    
                    
                }
            }
        }
    }
}

struct Test3_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    static var previews: some View {
        Test3(toDo: $user.toDoList[0])
    }
}
