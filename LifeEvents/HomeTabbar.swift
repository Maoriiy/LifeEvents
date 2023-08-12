//
//  HomeTabbar.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/6/30.
//

import SwiftUI


struct HomeTabbar: View {
    
    enum Tab {
        case event
        case setting
    }
    
    @State private var selectedTab: Tab = .event
    
    @State private var isPresentedCreateEventView = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedTab {
                    case .event:
                        HomeView()
                    case .setting:
                        SettingView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                bottomBar.background(Color.clear).padding(.bottom, .zero)
                addButton.padding(.bottom, 26)
            }.background(Color.init(hex: 0xF7F9FC), ignoresSafeAreaEdges: .top)
        }
    }
    
    var bottomBar: some View {
        HStack(alignment: .center) {
            Button {
                selectedTab = .event
            } label: {
                Spacer()
                Image(selectedTab == .event ? "icon_home_select" : "icon_home_unselect").resizable().frame(width: 24, height: 24)
                Spacer()
            }.frame(height: 50)
            Spacer(minLength: 48)
            Button {
                selectedTab = .setting
            } label: {
                Spacer()
                Image(selectedTab == .setting ? "icon_setting_select": "icon_setting_unselect").resizable().frame(width: 24, height: 24)
                Spacer()
            }.frame(height: 50)

        }
        .frame(height: 50)
        .background {
            Image("tabbackground").resizable().frame(height: 50)
        }.shadow(color: .black.opacity(0.04), radius: 0)
    }
    
    var addButton: some View {
        Button {
            
            self.isPresentedCreateEventView = true
        } label: {
            Image("icon_home_add").resizable().frame(width: 48, height: 48)
        }.frame(width: 48, height: 48)
            .sheet(isPresented: $isPresentedCreateEventView) {
                CreateEventView(isPresenting: $isPresentedCreateEventView)
            }
    }
    
}

struct HomeTabbar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabbar()
    }
}
