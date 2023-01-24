//
//  FilterSheet.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/23/23.
//

import SwiftUI

enum ToDoCategory: String, CaseIterable, Identifiable{
    var id: String { self.rawValue }
    case All
    case Active
    case Completed
}

struct FilterSheet: View {
    @Binding var showingSheet: Bool
    @State var selectedCategory = ToDoCategory.All
    @State var selectedTags = [Tag.work, Tag.school, Tag.health, Tag.chores]
    
    var body: some View {
        VStack {
            HStack{
                Text("Filters")
                    .bold()
                    .font(.system(size: 25))
                    .padding()
                
                Spacer()
                
                Button(action:{showingSheet.toggle()
                }, label:{
                    Text("Reset")
                })
                .padding()
            }
            
            HStack (spacing: 25){
                ForEach(ToDoCategory.allCases) {category in
                    Button(action:{},
                           label:{
                        ButtonText(isSelected: selectedCategory == category,
                                   title: category.rawValue)
                    })
                }
            }
            
            Spacer()
            Form{
                Section (header: Text("Tags")){
                    VStack (spacing: 0){
                        ForEach(Tag.allCases) {tag in
                            HStack (alignment: .center){
                                Image(systemName: selectedTags.contains(tag) ? "checkmark.square.fill": "square")
                                    .frame(maxHeight: .infinity)
                                    .padding()
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        /*        //adjust tags
                                         if localToDo.tags.contains(tag) {
                                         let index = localToDo.tags.firstIndex { $0 == tag }
                                         localToDo.tags.remove(at:index!)
                                         }
                                         else {
                                         localToDo.tags.append(tag)
                                         }
                                         
                                         hiddenTrigger.toggle() */
                                    }
                                Text(tag.rawValue)
                                    .padding(.top, 10)
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ButtonText: View {
    var isSelected: Bool = false
    let title: String
    var body: some View {
        Text(title)
            .frame(width: 100,
                   height: 50,
                   alignment: .center)
            .background(isSelected ? .blue : .gray.opacity(0.4))
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(8)
    }
}


struct FilterSheet_Previews: PreviewProvider {
    @State static var isShowing = true
    static var previews: some View {
        FilterSheet(showingSheet: $isShowing)
    }
}
