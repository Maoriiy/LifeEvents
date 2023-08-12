//
//  PlanView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/7.
//

import SwiftUI

enum PlanState: Int {
    case todo
    case doing
    case done
}

class PlanModel: ObservableObject, Identifiable {
    typealias ID = UUID
    
    var id: UUID { UUID() }
    
    @Published var title = ""
    @Published var planState = PlanState.todo
    @Published var isEmptyPlan = false
    
    static var empty: PlanModel {
        let plan =  PlanModel()
        plan.isEmptyPlan = true
        return plan
    }
    
    static var test:  PlanModel = {
        let plan =  PlanModel()
        plan.title = "Plan"
        
        return plan
    }()
    
}

extension Plan {
    var planState: PlanState {
        get {
            PlanState(rawValue: Int(state)) ?? .todo
        }
        set {
            state = Int16(newValue.rawValue)
        }
    }
}

struct PlanView: View {
    @ObservedObject var plan: PlanModel
    
    @Binding var isAdding: Bool
    
    var model: DetailEventsView.Model?
    
    @State var input = ""
    
    var body: some View {
        HStack {
            Spacer().frame(width: 8)
            Image("icon_todo").resizable().frame(width: 24, height: 24)
            Spacer().frame(width: 8)
            if plan.isEmptyPlan {
                PlanInputRow(input: $input).onChange(of: isAdding) { newValue in
                    if !newValue && !input.isEmpty {
                        if plan.isEmptyPlan {
                            model?.addPlan(input)
                        } else {
                            let subplan = PlanModel()
                            subplan.title = input
                            subplan.isEmptyPlan = false
                        }
                    }
                    input = ""
                }
            } else {
                PlanRow(plan: plan)
            }
            Spacer().frame(width: 12)
        }.frame(minHeight: 40, maxHeight: 60)
            .background {
            RoundedRectangle(cornerRadius: 8).fill(.white)
        }
    }
}

struct PlanRow: View {
    @ObservedObject var plan:  PlanModel
    
    var body: some View {
        HStack {
            Text(plan.title)
                .font(.system(size: 14))
                .foregroundColor(.textLevel1)
                .lineLimit(2)
            Spacer()
        }.frame(minHeight: 24, maxHeight: 42)
    }
}


struct PlanInputRow: View {
    @Binding var input: String
    
    var body: some View {
        HStack {
            TextField(
                text: $input,
                prompt: Text("I'm going to do it")
                    .font(.system(size: 14))
                    .foregroundColor(.textLevel3),
                label: {
                    Label("", image: "")
                }
            ).font(.system(size: 14)).lineLimit(2)
        }.frame(height: 24)
    }
}
