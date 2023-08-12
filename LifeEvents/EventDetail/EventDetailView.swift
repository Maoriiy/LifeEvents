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
                                DetailEventsView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext).background {
                                    Color(hex: 0xF7F9FC)
                                }
                            case .reminder:
                                DetailReminderView().background {
                                    Color(hex: 0xF7F9FC)
                                }
                            }
                            Color(hex: 0xF7F9FC)
                        }
                    }.background {
                        VStack {
                            Spacer().frame(height: 112 + .safeTop)
//                            RoundedRectangle(cornerRadius: 16, style: .circular).frame(width: .screenWidth , height: 136).foregroundColor(.white) // 部分圆角
                            Color(hex: 0xF7F9FC)
//                            LinearGradient(colors:  [.whitePatch1.opacity(0.93), .whitePatch1], startPoint: .top, endPoint: .bottom).frame(height: 136)
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
                        
                    }
                    Button("Cancel", role: .cancel) { }
            }
            Spacer().frame(width: 16)

        }
    }
    
    @State var isPresetAlert = false
    
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView(event: .init)
//    }
//}
