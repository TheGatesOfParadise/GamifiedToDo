
import SwiftUI

struct Test1View: View {

    //beging
    @State var date = Date()
    @State var isPickerVisible = false
    var body: some View {
        ZStack {
            Button(action: {
                isPickerVisible = true
            }, label: {
                Image(systemName: "calendar")
            }).zIndex(1)
            if isPickerVisible{
                VStack{
                    Button("Done", action: {
                        isPickerVisible = false
                    })
                    .padding()
                    DatePicker("",
                               selection: $date,
                               displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Spacer()
                }
                .background(Color(UIColor.secondarySystemBackground))
                .zIndex(2)
            }
        }
    }
    
    //end
}



struct Test1View_Previews: PreviewProvider {
    static var previews: some View {
        /*Test1View(title: "give Ashley's book back. brought the wrong book last time \u{1F600}",
                  dueDate: "1/19/23",
                  numberOfCompleteTask:1,
                  numberOfTotoalTask: 4,
                  checkColor: .red) */
        
        Test1View()
    }
}

