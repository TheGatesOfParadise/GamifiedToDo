import SwiftUI

//ObservableObject is a reference type
//https://stackoverflow.com/questions/73202041/ios-swiftui-cannot-convert-value-of-type-observedobject
class Model: ObservableObject {
    @Published var aList:[Int]
    
    init(aList: [Int]) {
        self.aList = aList
    }
}

struct Unit6First: View {
    @StateObject var model: Model = Model(aList:[10, 20, 30, 40, 50])
    var body: some View {
        NavigationView{
            VStack {
                //use of id: field
                //The second reason is using a List or ForEach on primitive types that don’t conform to the Identifiable protocol, such as an array of strings or integers. In this situation, you should use id: \.self as the second parameter to your List or ForEach, like this:
                
                //https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-initializer-init-rowcontent-requires-that-sometype-conform-to-identifiable
                ForEach(model.aList, id: \.self) {num in
                    Text(String(num))
                }
                NavigationLink(destination: {NextPage(model: model)},
                               label: {
                    Text("Next page")
                        .bold()
                        .padding()
                })
            }
        }
    }
}

//dismiss a page comes from
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself
struct NextPage: View{
    @Environment(\.dismiss) var dismiss
    var model: Model
    var body: some View{
        Button(action: {
            model.aList.append(3)
        },
               label: {Text("Append 3")})
        .padding()
        
        Button(action: {
            model.aList.append(5)
            //self.mode.wrappedValue.dismiss()
            dismiss()
        },
               label: {Text("Append 5")})
    }
}

struct Unit6First_Previews: PreviewProvider {
    static var previews: some View {
        Unit6First()
    }
}
