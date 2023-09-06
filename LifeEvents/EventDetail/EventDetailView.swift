//
//  EventDetailView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/6.
//

import SwiftUI

extension Event {
    var photo: Photo {
        .photo(Int(photoIndex))
    }
}

struct EventDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let event: Event
    
    enum TabType {
        case events
        case reminder
    }
    
    @State var selectedTab: TabType = .events
    
    @State var presentAlertDelete = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack {
                    VStack {
                        Image(event.photo.imageName).resizable().frame(width: .screenWidth, height: .screenWidth / 375.0 * 281.0 )
                        Spacer()
                    }
                    VStack {
                        Spacer().frame(height: .safeTop)
                        navigationBar
                        Spacer()
                    }
                    
                    VStack {
                        Spacer().frame(height: .safeTop)
                        Spacer().frame(height: 34)
//                        Text(event.name ?? "").foregroundColor(.white).font(.system(size: 18)).padding([.leading, .trailing], 65)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer().frame(height: .safeTop)
                        Spacer().frame(height: 112)
                        HStack {
                            Button {
                                selectedTab = .events
                            } label: {
                                Text("Events").font(.system(size: 18, weight: .medium)).foregroundColor(selectedTab == .events ? .textLevel1 : .textLevel3)
                            }.frame(width: .screenWidth / 2, height: 44)
                            
                            Button {
                                selectedTab = .reminder
                            } label: {
                                Text("Reminder").font(.system(size: 18, weight: .medium)).foregroundColor(selectedTab == .reminder ? .textLevel1 : .textLevel3)
                            }.frame(width: .screenWidth / 2, height: 44)
                        }
                        Group {
                            switch selectedTab {
                            case .events:
                                DetailEventsView(eventId: event.eventId).background {
                                    Color(hex: 0xF7F9FC)
                                }
                            case .reminder:
                                DetailReminderView().background {
                                    Color(hex: 0xF7F9FC)
                                }
                            }
                            
                        }
                    }.background {
                        VStack {
                            Spacer().frame(height: 112 + .safeTop)
                            RoundedCorners(color: Color(hex: 0xF7F9FC), tl: 16, tr: 16, bl: 0, br: 0).frame(height: 60)
                            Color(hex: 0xF7F9FC)
//
//                            Color.whitePatch1
                        }
                    }
                    Spacer()
                }.background {
                    Color(hex: 0xF7F9FC)
                }
            }.background {
                Color(hex: 0xF7F9FC)
            }
        }.navigationBarBackButtonHidden().ignoresSafeArea(.all, edges: .top).background().background {
            Color(hex: 0xF7F9FC)
        }
    }
    
    var navigationBar: some View {
        HStack {
            Spacer().frame(width: 16)
            Button {
                dismiss()
            } label: {
                Image(decorative: (UIImage(named: "icon_right_arrow")?.cgImage)!, scale: UIScreen.main.scale, orientation: .upMirrored).resizable().renderingMode(.template).foregroundColor(.white).frame(width: 24, height: 24).transformEffect(CGAffineTransformMakeTranslation(-1, 1))
            }.frame(width: 24, height: 24)
            Spacer()
            Button {
                isPresetAlert = true
            } label: {
                Image("icon_more").resizable().renderingMode(.template).foregroundColor(.white).frame(width: 24, height: 24).transformEffect(CGAffineTransformMakeTranslation(-1, 1))
            }.frame(width: 24, height: 24)
                .confirmationDialog("retaining the last three deleted records！", isPresented: $isPresetAlert, titleVisibility: .visible) {
                    Button("Editor", role: .none) {
                        
                    }
                    Button("Delete", role: .destructive) {
                        presentAlertDelete = true
                    }
                    Button("Cancel", role: .cancel) { }
            }
            Spacer().frame(width: 16)

        }.alert("Do you really want to delete this event ？", isPresented: $presentAlertDelete) {
            
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                
            }
        }
    }
    
    @State var isPresetAlert = false
    
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView(event: .init)
//    }
//}


struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
 
    var body: some View {
        GeometryReader { geometry in
            Path { path in
 
                let w = geometry.size.width
                let h = geometry.size.height
 
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
 
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }.fill(LinearGradient(colors:  [.whitePatch1.opacity(0.9), .whitePatch1], startPoint: .top, endPoint: .bottom))
            
        }
    }
}
