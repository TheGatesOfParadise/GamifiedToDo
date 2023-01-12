//
//  CheckView.swift
//  unit 4 proj
//
//  Created by Scarlett Ruan on 11/7/22.
//
///This view display a check next to a text in one line
///
///Parameter name: title is a String type, it's get displayed next to the checkbox
///
///The code is referenced from this article:
///https://makeapppie.com/2019/10/16/checkboxes-in-swiftui/
///
import SwiftUI

struct CheckDailiesView: View {
    @State var isChecked:Bool = false
    var daily: Dailies
    
    let checkColor:Color
    
    init(daily: Dailies) {
        self.daily = daily
        checkColor = daily.difficulty == .hard ? .pink : daily.difficulty == .medium ? .orange : .green
    }
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View {
        HStack (alignment: .center){
            Image(systemName: isChecked ? "checkmark.square.fill": "square")
                .frame(maxHeight: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(isChecked ? .green : checkColor)
                .onTapGesture {
                    toggle()
                }
            
            VStack (alignment: .leading){
                NavigationLink(
                    destination: ContentView(),
                    label: {
                        Text(daily.title)
                            .padding(.top, 10)
                            .font(.system(size: 18))
                            .strikethrough(isChecked)
                            .foregroundColor(isChecked ? .gray : .black)
                            .multilineTextAlignment(.leading)
                    })
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 10)
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(cornerRadiusValue)
        .background(.gray.opacity(0.15))
    }
}

struct CheckDailiesView_Previews: PreviewProvider {
    @State static var user = User.getASampleUser()
    
    static var previews: some View {
        CheckDailiesView(daily: user.DailiesList[0])
    }
}
