
//
//  ToDoDetailsView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/11/23.
//

import SwiftUI

struct DailiesDetailsView: View {
    @EnvironmentObject var userModel : UserModel
    @Environment(\.dismiss) private var dismiss
    @Binding var daily: Dailies
    @State private var datePopOverPresented = false
    @State var localDaily: Dailies = Dailies.getAnEmptyDaily()
    @State var hiddenTrigger = false
    var type: DetailsType
    
    init(daily: Binding<Dailies>, type: DetailsType) {
        self._daily = daily
        self.type = type
        
        if type == .Edit {
            self._localDaily = State(initialValue: daily.wrappedValue)
        }
    }
    
    var body: some View {
       // NavigationView{
            VStack {
                Form {
                    
                    //notes
                    Section (header: Text("Task Title")){
                        TextField("",
                                  text: $localDaily.title)
                    }
                    
                    Section (header: Text("Notes")){
                        TextField("",
                                  text:$localDaily.notes)
                    }
                    
                    //difficulty
                    Section (header: Text("Difficulty Level")){
                        HStack {
                            ForEach(DifficultyLevel.allCases) { level in
                                Button(action: {
                                    
                                }) {
                                    Image(localDaily.difficulty == level ? "\(level.rawValue)_filled": level.rawValue)
                                        .resizable()
                                        .frame(width: 60,
                                               height: 50)
                                }
                                .padding()
                                .onTapGesture {
                                    localDaily.difficulty = level
                                    hiddenTrigger.toggle()
                                }
                            }
                        }
                    }
                    
                    //Tags
                    Section (header: Text("Tags")){
                        VStack (spacing: 0){
                            ForEach(Tag.allCases) {tag in
                               // TagCheckBox(tags:$localToDo.tags, currentTag: tag)
                                HStack (alignment: .center){
                                    Image(systemName: (localDaily.tags != nil) && localDaily.tags!.contains(tag) ? "checkmark.square.fill": "square")
                                        .frame(maxHeight: .infinity)
                                        .padding()
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            //adjust tags
                                            if  (localDaily.tags != nil) && localDaily.tags!.contains(tag) {
                                                let index = localDaily.tags!.firstIndex { $0 == tag }
                                                localDaily.tags!.remove(at:index!)
                                            }
                                            else {
                                                localDaily.tags?.append(tag)
                                            }
                                            
                                            hiddenTrigger.toggle()
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
                }//end of form
            }//end of vstack
            .toolbar{
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing,
                                 content: {
                    HStack{
                        if type == .Edit{
                            Button(action: {
                                //delete this todo
                                //TODO: how to delete this todo without knowing user object
                                
                                userModel.removeDaily(whichIs: localDaily)
                            }, label: {
                                Text("DELETE")
                                    .bold()
                            })
                        }
                        Button(action: {
                            if type == .Edit {
                                daily = localDaily
                            }
                            else {
                                userModel.user.dailiesList.append(localDaily)
                            }
                            
                            //force a view to update comes from this post:
                            //https://stackoverflow.com/questions/56561630/swiftui-forcing-an-update
                            userModel.updateView()
                            
                            //TODO: return to previous screen
                            dismiss()
                            
                        }, label: {
                            Text("SAVE")
                                .bold()
                        })
                    }
                    
                })
            }
       // }  //end of navigationview
    }//end of view
}//end of struct


struct DailiesDetailsView_Previews: PreviewProvider {
    @StateObject static var user = User.getASampleUser()
    static var previews: some View {
        DailiesDetailsView(daily: $user.dailiesList[0],type: .Edit)
        //ToDoDetailsView(toDo: $toDo, type: .New)
    }
}
