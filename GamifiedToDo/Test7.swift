import Combine
import SwiftUI

class Tallies: Identifiable, ObservableObject {
  let id = UUID()
  @Published var count = 0

  func increase() {
    count += 1
  }
}

class GroupOfTallies: Identifiable, ObservableObject {
  let id = UUID()
  var sinks: [AnyCancellable] = []
  
  @Published var elements: [Tallies] = [] {
    didSet {
      sinks = elements.map {
        $0.objectWillChange.sink( receiveValue: objectWillChange.send)
      }
    }
  }

  var cumulativeCount: Int {
    return elements.reduce(0) { $0 + $1.count }
  }
}


struct Test7: View {
      @ObservedObject
      var group: GroupOfTallies

      init() {
        let group = GroupOfTallies()
        group.elements.append(contentsOf: [Tallies(), Tallies()])
        self.group = group
          
        let rules = Rules()
          Rules.printRules()
        
      }

      var body: some View {
        VStack(spacing: 50) {
          Text( "\(group.cumulativeCount)")
          Button( action: group.elements.first!.increase) {
            Text( "Increase first")
          }
          Button( action: group.elements.last!.increase) {
            Text( "Increase last")
          }
        }
      }
    
}

struct Test7_Previews: PreviewProvider {

    static var previews: some View {
        Test7()
    }
}
