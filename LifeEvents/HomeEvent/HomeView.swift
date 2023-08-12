//
//  HomeView.swift
//  Life Events
//
//  Created by yihong wang on 2023/6/29.
//

import SwiftUI


struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.index, ascending: false)],
        animation: .default)
    private var events: FetchedResults<Event>
    
    @State private var dragging: Event?
    
    @State var isTarget = true
    
    @State var showToast = false
    
    var itemSize: CGSize {
        let width = (UIScreen.main.bounds.width - 17 - 32) * 0.5
        let height = width * 217 / 163
        return .init(width: width, height: height)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer().frame(width: 16)
                Text("Life Events").frame(width: 129, height: 24).font(.custom("Nereus-Bold", size: 36))
                Spacer()
                Button {
                    
                } label: {
                    Image("Premium").resizable().frame(width: 100, height: 29)
                }.frame(width: 100, height: 29)
                Spacer().frame(width: 16)
            }.frame(height: 44)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [.init(.fixed(itemSize.width), spacing: 16), .init(.fixed(itemSize.width))], spacing: 16) {
                    ForEach(events) { event in
                        NavigationLink {
                            EventDetailView(event: event)
                        } label: {
                            StaticEventView(event: event).frame(width: itemSize.width, height: itemSize.height).onDrag {
                                self.dragging = event
                                return NSItemProvider(object: NSString(string: event.name ?? ""))
                            }
                            .onDrop(of: [.text], delegate: EventDropDelegate(dragging: $dragging, item: event, events: events))
                        }
                    }
                }
                Spacer().frame(height: 90)
            }
            Spacer()
        }.background {
            Color.init(hex: 0xF7F9FC)
        }.background( ignoresSafeAreaEdges: [])
            .toastEventSave(isPresenting: $showToast)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct EventDropDelegate: DropDelegate {
    @Binding var dragging: Event?
    let item: Event
    var events: FetchedResults<Event>
    
    func dropEntered(info: DropInfo) {
        if let dragging = dragging, dragging != item {
            let temp = item.index
            item.index = dragging.index
            dragging.index = temp
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            
        }
        self.dragging = nil
        return true
    }
}
