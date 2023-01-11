//
//  Test2.swift
//  GamifiedToDo
//
//  Created by Mom macbook air on 1/8/23.
//

import SwiftUI

struct CalendarDay: Hashable {
    var dateOfMonth: String
    var dayOfWeek: String
}
let calendarDays: [CalendarDay] = [
    CalendarDay(dateOfMonth: "12", dayOfWeek: "Fri"),
    CalendarDay(dateOfMonth: "13", dayOfWeek: "Sat"),
    CalendarDay(dateOfMonth: "14", dayOfWeek: "Sun"),
    CalendarDay(dateOfMonth: "15", dayOfWeek: "Mon")
]

let pinkLightColor = Color(uiColor: UIColor(rgb: 0xFFB3FF))
let pinkDarkColor = Color(uiColor: UIColor(rgb: 0xFFB3B3))
let pinkKKColor = LinearGradient(gradient: Gradient(colors: [pinkLightColor, pinkDarkColor]),                                  startPoint: .leading, endPoint: .trailing)
let calendarButtonWidth = CGFloat(UIScreen.main.bounds.width - (5*12)) / 4
let calendarButtonHeight = CGFloat(UIScreen.main.bounds.width - (5*12)) / 4
let darkBackgroundColor = Color(uiColor: UIColor(rgb: 0xF0F0F))

let darkColor = LinearGradient(gradient: Gradient(colors: [darkBackgroundColor]),
                               startPoint: .leading, endPoint: .trailing)
let lightColor = LinearGradient(gradient: Gradient(colors: [Color.white]),
                                startPoint: .leading, endPoint: .trailing)


struct Test2: View {
    
    @State var currentDay = CalendarDay(dateOfMonth: "12", dayOfWeek: "Fri")
    @State var didTap: Bool = false
    
    var body: some View {
        HStack (spacing: 15) {
            ///calender view
            ForEach(calendarDays, id: \.self) { day in
                Button(action: {
                    self.didTap.toggle()
                    currentDay = day
                }, label: {
                    VStack{
                        Text(day.dateOfMonth)
                            .font(.system(size: 22))
                        Text(day.dayOfWeek)
                            .font(.system(size: 18))
                    }
                    .frame(
                        width: calendarButtonWidth,
                        height: calendarButtonHeight
                    )
                 .background(day == currentDay ? pinkKKColor : darkColor)
                 .foregroundColor (day == currentDay ? Color.black : Color.white)
                    .cornerRadius(calendarButtonWidth/2)
                })
            }
        }
        .padding(.top, 20)

    }
    
    func toggle () {didTap = !didTap}
    
}




struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
