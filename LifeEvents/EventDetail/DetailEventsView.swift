//
//  DetailEventsView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/6.
//

import SwiftUI
import CoreData

//class EventAddContext: ObservableObject {
//    @Published var isAdding = false
//
//    @Published var input
//}


struct DetailEventsView: View {
    
    class Model: ObservableObject {
        @Published var plans: [PlanModel] = {
            let plan =  PlanModel()
            plan.title = "Plan"
            
            return [plan]
        }()
        
        func addPlan(_ title: String) {
            let plan = PlanModel()
            plan.isEmptyPlan = false
            plan.title = title
            plans.insert(plan, at: 0)
        }
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Plan.createTime, ascending: false)],
//        animation: .default)
//    private var events: FetchedResults<Plan>
    
    @ObservedObject var model = Model()
    
    @State var isAddingEvent = false
    
    var empty = false
    
    var body: some View {
        VStack {
            HStack {
                Text("OnGoing").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                Spacer()
                
                if isAddingEvent {
                    Button {
                        isAddingEvent = false
                    } label: {
                        HStack {
                            Text("Add completed").font(.system(size: 14, weight: .medium)).foregroundColor(.init(hex: 0xFF6341))
                        }
                    }
                } else {
                    Button {
                        isAddingEvent = true
                        addCompletion()
                    } label: {
                        HStack {
                            Image("icon_add_option").resizable().frame(width: 24, height: 24)
                            Spacer().frame(width: 8)
                            Text("add").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                        }
                    }
                }
            }.padding([.leading, .trailing], 16).frame(height: 56)
            
            if empty && !isAddingEvent {
                Spacer().frame(height: 55)
                Image("icon_empty").resizable().frame(width: 100, height: 100)
                Spacer().frame(height: 14)
                Text("There are no events, please add them").font(.system(size: 14)).foregroundColor(.textLevel3)
                Spacer()
            } else {
                VStack(spacing: 16) {
                    if isAddingEvent {
                        PlanView(plan: .empty, isAdding: $isAddingEvent, model: model)
                    }
                    ForEach(model.plans) { plan in
                        PlanView(plan: plan, isAdding: $isAddingEvent)
                    }
                }.padding([.leading, .trailing], 16)
                Spacer()
            }
        }
    }
    
    func addCompletion() {
        
        
    }
}

struct DetailEventsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEventsView()
    }
}
