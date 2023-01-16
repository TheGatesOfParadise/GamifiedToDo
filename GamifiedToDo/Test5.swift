//
//  Test5.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/15/23.
//

import SwiftUI

struct Test5: View {
    @Binding var toDo: Todo
    @StateObject var card: Card
    @State var hiddenTrigger = false
    var body: some View {
        
        Form{
            //difficulty
            Section (header: Text("Difficulty Level")){
                HStack {
                    ForEach(DifficultyLevel.allCases) { level in
                       /* DifficultyLevelButton(selectedLevel: $toDo.difficulty,
                                              image: level) */
                        
                        Button(action: {
                           
                        }) {
                            Image(toDo.difficulty == level ? "\(level.rawValue)_filled": level.rawValue)
                                .resizable()
                                .frame(width: 60,
                                       height: 50)
                        }
                        .padding()
                        .onTapGesture {
                            toDo.difficulty = level
                            hiddenTrigger.toggle()
                        }
                    }
                }
            }
   

            Section(header: Text("Social Media")) {
                HStack {
                    ForEach(MediaOption.allCases) { option in
                        MediaButton(selectedSocialMedia: $card.media,
                                    image: option)
                    }
                }
            }
            
            
        }
    }
}
//media button

class Card: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var title = ""
    @Published var company = ""
    @Published var media: MediaOption = MediaOption.facebook
    @Published var mediaID = ""
    @Published var style = "CardViewYellow"
}


enum MediaOption: String, CaseIterable, Identifiable {
    case facebook
    case twitter
    case instagram
    case linkedin
    case youtube
    var id: String { self.rawValue }
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
//end of media button


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

struct Test5_Previews: PreviewProvider {
    @StateObject static var user = User.getASampleUser()
    static var previews: some View {
        //Test5(toDo: $user.toDoList[0])
        Test5(toDo: $user.toDoList[0], card: Card())
    }
}
