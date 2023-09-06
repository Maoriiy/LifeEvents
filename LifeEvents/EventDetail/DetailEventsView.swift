//
//  DetailEventsView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/6.
//

import SwiftUI
import CoreData

struct DetailEventsView: View {
    
    class Model: ObservableObject {
        
        let eventId: Int16
        
        init(eventId: Int16) {
            self.eventId = eventId
        }
        
        @Published var todoPlans = [PlanModel]()
        @Published var donePlans = [PlanModel]()
        
        func setPlans(_ plans: [PlanModel]) {
            todoPlans = plans.filter {
                $0.planState == .todo
            }
            donePlans = plans.filter {
                $0.planState == .done
            }
        }
        
        func addPlan(_ title: String) {
            let plan = PlanModel()
            plan.isEmptyPlan = false
            plan.title = title
            todoPlans.insert(plan, at: 0)
        }
        
        func save() {
            PlanStorage(eventId).savePlans(todoPlans + donePlans)
        }
    }
    
    @ObservedObject var model: Model
    
    @State var isAddingEvent = false
    
    @State var empty = false
        
    let eventId: Int16
    
    init(eventId: Int16) {
        self.eventId = eventId
        model = .init(eventId: eventId)
        let plans = PlanStorage(eventId).getPlans()
        model.setPlans(plans)
        empty = plans.isEmpty
        print("empty \(empty)")
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("OnGoing").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                Spacer()
                
                if isAddingEvent {
                    Button {
                        isAddingEvent = false
                        addCompletion()
                    } label: {
                        HStack {
                            Text("Add completed").font(.system(size: 14, weight: .medium)).foregroundColor(.init(hex: 0xFF6341))
                        }
                    }
                } else {
                    Button {
                        isAddingEvent = true
                        
                    } label: {
                        HStack {
                            Image("icon_add_option").resizable().frame(width: 24, height: 24)
                            Spacer().frame(width: 8)
                            Text("add").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                        }
                    }
                }
            }.padding([.leading, .trailing], 16).frame(height: 56)
            
            if (empty || PlanStorage(eventId).getPlans().isEmpty) && !isAddingEvent {
                Spacer().frame(height: 55)
                Image("icon_empty").resizable().frame(width: 100, height: 100)
                Spacer().frame(height: 14)
                Text("There are no events, please add them").font(.system(size: 14)).foregroundColor(.textLevel3)
                Spacer()
            } else {
                VStack(spacing: 16) {
                    if isAddingEvent {
                        PlanView(plan: .empty, isAdding: $isAddingEvent, model: model) {
                            self.addCompletion()
                        }
                    }
                    ForEach(model.todoPlans) { plan in
                        PlanView(plan: plan, isAdding: $isAddingEvent, model: model)
                    }
                }.padding([.leading, .trailing], 16)
                
                if !model.donePlans.isEmpty {
                    HStack {
                        Text("Completed").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                        Spacer()
                    }.padding([.leading, .trailing], 16).frame(height: 56)
                    VStack(spacing: 16) {
                        ForEach(model.donePlans) { plan in
                            PlanView(plan: plan, isAdding: $isAddingEvent, model: model)
                        }
                    }.padding([.leading, .trailing], 16)
                }
                Spacer()
            }
        }
    }
    
    func addCompletion() {
        empty = PlanStorage(eventId).getPlans().isEmpty
    }
}


class PlanStorage {
    let eventId: Int16
    
    init(_ eventId: Int16) {
        self.eventId = eventId
    }
    
    var key: String { "Plan-\(eventId)" }
    
    func savePlans(_ plans: [PlanModel]) {
        UserDefaults.standard.removeObject(forKey: key)
        let dicts = plans.map({
            $0.toDict()
        })
        UserDefaults.standard.setValue(dicts, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getPlans() -> [PlanModel] {
        if let dicts = UserDefaults.standard.array(forKey: key) as? [[String: Any]] {
            let models = dicts.map({ PlanModel.init($0) })
            return models
        }
        return []
    }
}
