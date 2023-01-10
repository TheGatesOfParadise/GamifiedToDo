//
//  Overview.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct Overview: View {
    
    @State var selectedTab = "Dailies"
    @State var isPopup = false
    
    var body: some View {
        ZStack {
            
            //regular page display
            TabView {
                Group {
                    ToDoView()
                        .tabItem {
                            Label("Dailies", systemImage: "calendar")
                        }
                    ToDoView()
                        .tabItem {
                            Label("To Do's", systemImage: "checkmark.square.fill")
                        }
                    Text("Rewards")
                        .tabItem {
                            Label("Rewards", systemImage: "envelope.fill")
                        }
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            }
            
            
            
            ///this portion display a blurred view when PopupView is presented
            ///the idea comes from youttube video:
            ///https://www.youtube.com/watch?v=Ik8WmcERros&list=PL5PR3UyfTWvfgx9W8WJ9orQf6N1tx0oxN&index=63
            GeometryReader { proxy in
               /* BlurView(style: viewMode == .original ? .systemThinMaterialLight : .systemThinMaterialDark )
                    .opacity(isPopup ? 1 : 0) */
                BlurView(style: .systemThinMaterialDark)
                    .opacity(isPopup ? 1 : 0)
            }
            
            ///this portion displays a popup view when user clicks on "+" button
            PopupView(isPopup: $isPopup)
            
            ///display a "+" button if there is no popup, or
            ///dispaly a "x" button when popup is presented
            floatButton(isPopup: $isPopup,
                        textSign: isPopup ? "x" : "+")

            
        }
    }
}

///
///Blurs entries screen
///
///This comes from a yourtube video:
///https://www.youtube.com/watch?v=Ik8WmcERros&list=PL5PR3UyfTWvfgx9W8WJ9orQf6N1tx0oxN&index=63
///
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //do nothing
    }
    
    func makeUIView(context: Context) ->  UIVisualEffectView {
        let view = UIVisualEffectView(effect:  UIBlurEffect(style: style))
        return view
    }
}

///
///It shows a popup view which allow users to enter new to-do item
///
struct PopupView: View {
    @Binding var isPopup: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Text("this is a popup view")
       /*         VStack (alignment: .leading) {
                    Text("How can I help you,")
                        .bold()
                        .font(.system(size: 25))
                    Text("James?")
                        .bold()
                        .font(.system(size: 25))
                        .padding(.bottom, 50)
                    
                    Text("Remind me to choose new apartment. Maybe take one of the alternatives or call Mary")
                }
                .padding(.bottom, 80)
                .padding(.top, 20)
                
                Spacer()
                
                HStack {
                    Image(systemName: "mic.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, 30)
                        .padding(.trailing, 30)
                    
                    if (viewMode == .updated) {
                        Image(systemName: "keyboard")
                            .resizable()
                            .frame(width: 80, height: 40)
                            .padding(.bottom, 30)
                    }
                }  */
            }
        }
        .opacity(isPopup ? 1 : 0)
        .frame(width: 300, height: 400)
        
    }
}

///
///float button at the bottom right corner
///
///it's referenced from this article:
///https://medium.com/programming-with-swift/create-a-floating-action-button-with-swiftui-4d05dcddc365
///
struct floatButton: View {
    @Binding var isPopup: Bool
    var textSign: String
    
    var body: some View {
        VStack{
            //Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isPopup.toggle()
                }, label: {
                    Text(textSign)
                        .font(.system(.largeTitle))
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.white)
                    //.padding(.bottom, 7)
                })
                .background( Color.yellow.opacity(0.6))
                .cornerRadius(40)
                //.padding(.bottom, 10)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
            Spacer()
            Spacer()
        }
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
