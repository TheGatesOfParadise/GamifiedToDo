//
//  ToDoDetailsView.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/11/23.
//

import SwiftUI

struct ToDoDetailsView: View {
    @Binding var toDo: Todo
    @State private var datePopOverPresented = false
    
    var body: some View {
        
            VStack {
                Form {
                 
                    //notes
                    Section (header: Text("Task Title")){
                        TextField("",
                                  text: $toDo.title)
                    }
                    
                    Section (header: Text("Notes")){
                        TextField("",
                                  text:$toDo.notes)
                    }
                    
                    //checklist

   
                    
                    //difficulty
                    Section (header: Text("Difficulty Level")){
                        //Text(toDo.difficulty.rawValue)
                        HStack {
                            ForEach(DifficultyLevel.allCases) { level in
                                DifficultyLevelButton(selectedLevel: $toDo.difficulty,
                                                      image: level)
                            }
                        }
                    }

                    
                    //scheduling -  due date
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
                                    .foregroundColor(.black)
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
  
                    //reminder???  necessary
                    
                    //Tags
                    Section (header: Text("Tags")){
                        //Text(toDo.tag.rawValue)
                        VStack (spacing: 0){
                            ForEach(Tag.allCases) {tag in
                                TagCheckBox(tags:$toDo.tags, currentTag: tag)
                            }
                        }
                    }
                }//end of form
            }//end of vstack
       
    }//end of view
}//end of struct



//https://stackoverflow.com/questions/65797437/how-to-make-a-button-or-any-other-element-show-swiftuis-datepicker-popup-on-t
struct ZCalendar: View {
    @Binding var date: Date
    @State var isPickerVisible = false
    var body: some View {
        ZStack {
            Button(action: {
                isPickerVisible = true
            }, label: {
                Image(systemName: "calendar")
                    .foregroundColor(.black)
            }).zIndex(1)
            if isPickerVisible{
                VStack (alignment:.center){
                    Button("Done", action: {
                        isPickerVisible = false
                    }).padding()
                    DatePicker("",
                               selection: $date,
                               displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Spacer()
                }
                .offset(y: -50)
                .background(Color(UIColor.secondarySystemBackground))
                .border(.red, width: 5)
                .zIndex(2)
            }
        }
    }
}


struct TagCheckBox: View {
    @Binding var tags: [Tag]?
    var currentTag: Tag
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: (tags != nil) && tags!.contains(currentTag) ? "checkmark.square.fill": "square")
                .frame(maxHeight: .infinity)
                .padding()
                .foregroundColor(.black)
                .onTapGesture {
                    //adjust tags
                    if  (tags != nil) && tags!.contains(currentTag) {
                        let index = tags!.firstIndex { $0 == currentTag }
                        tags!.remove(at:index!)
                    }
                    else {
                        tags?.append(currentTag)
                    }
                }
            Text(currentTag.rawValue)
                .padding(.top, 10)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        //.cornerRadius(cornerRadiusValue)
        //.background(.gray.opacity(0.15))
    }
}


struct DifficultyLevelButton: View {
    @Binding var selectedLevel: DifficultyLevel
    let image: DifficultyLevel
    var body: some View {
        Button(action: {
            
        }) {
            Image(selectedLevel == image ? "\(image.rawValue)_filled": image.rawValue)
                .resizable()
                .frame(width: 60,
                       height: 50)
        }
        .padding()
        .onTapGesture {
            selectedLevel = image
        }
        
    }
}

//////////////////////////////////////////////////////////

            /*beging copy

                    NavigationView {
                        VStack {
                            Form {
                                Section (header: Text("Task Title")){
                                    Text(
                                    
                                }
                                
                                Section (header: Text("Name : \(card.firstName) \(card.lastName)")){
                                    TextField("First Name",
                                              text: $card.firstName)
                                    //disable autocorrection
                                    //Reference: https://stackoverflow.com/questions/25767522/disable-uitextfield-predictive-text
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    
                                    TextField("Last Name",
                                              text: $card.lastName)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                }
                                
                                Section (header: Text("Work")){
                                    TextField("Title",
                                              text: $card.title)
                                    .autocapitalization(.none)
                                    TextField("Company",
                                              text: $card.company)
                                    .autocapitalization(.none)
                                }
                                
                                Section (header: Text("Contact: \(card.formattedPhoneNumber)")){
                                    TextField("Email",
                                              text: $card.email)
                                    TextField("Phone Number",
                                              text: $card.phoneNumber)
                                }
                                
                                Section(header: Text("Social Media")) {
                                    HStack {
                                        ForEach(MediaOption.allCases) { option in
                                            MediaButton(selectedSocialMedia: $card.media,
                                                        image: option)
                                        }
                                    }
                                    TextField("Social Media ID", text: $card.mediaID)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                }
                                
                            }
                            
                            NavigationLink(
                                destination: StyleSelectionView(), //TODO: delete comment line
                                //destination: CardViewYellow(),
                                label: {
                                    if (card.isComplete()) {
                                        BottomButton(text: "Continue", color: Color.blue)
                                    }
                                    else {
                                        BottomButton(text: "Continue", color: Color.gray)
                                    }
                                })
                            .disabled(!card.isComplete())
                        }
                        .navigationTitle("Business Card")
                    }
                    
                    //passing object among multiple views using @EnvironmentObject
                    //reference is https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
                    .environmentObject(card)
                }
            }

            struct MediaButton: View {
                @Binding var selectedSocialMedia: MediaOption
                let image: MediaOption
                var body: some View {
                    Button(action: {
                        
                    }) {
                        Image(image.rawValue)
                            .resizable()
                            .frame(width: selectedSocialMedia == image ? 34 : 24,
                                   height: selectedSocialMedia == image ? 34 : 24)
                    }
                    .border(selectedSocialMedia == image ? Color.green : Color.yellow,
                            width: selectedSocialMedia == image ? 5 : 0)
                    .padding()
                    .onTapGesture {
                        selectedSocialMedia = image
                        print("Tap SelectedMedia's rawValue is \(selectedSocialMedia.rawValue)")
                        print("Tap current image is \(image.rawValue)")
                    }
                    
                }
            }

            struct BottomButton: View {
                let text: String
                let color: Color
                var body: some View {
                    Text(text)
                        .frame(width: 200,
                               height: 50,
                               alignment: .center)
                        .background(color)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
           end copy */




struct ToDoDetailsView_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    static var previews: some View {
        ToDoDetailsView(toDo: $user.toDoList[0])
    }
}
