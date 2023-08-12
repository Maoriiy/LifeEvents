//
//  SettingView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/1.
//

import SwiftUI

enum SettingOption: String, CaseIterable, Identifiable {
    var id: String {
        self.rawValue
    }
    
    typealias ID = String
    
    case RecentDelete
    case TermsOfUse
    case PrivacyPolicy
    case share
    case RateUs
    
    var title: String {
        switch self {
        case .RecentDelete:
            return "Recently deleted"
        case .TermsOfUse:
            return "Terms of use"
        case .PrivacyPolicy:
            return "Privacy Policy"
        case .share:
            return "share"
        case .RateUs:
            return "Rate us"
        }
    }
    
    var icon: String {
        "icon_setting_" + self.rawValue
    }
}

struct SettingView: View {
    enum PushSelection: Hashable {
        case none
        case PremiumPurchase
        case setting(SettingOption)
        
        var hashValue: any Hashable {
            switch self {
            case .PremiumPurchase:
                return "PremiumPurchase"
            case .setting(let option):
                return option.rawValue
            case .none:
                return "none"
            }
        }
    }
    @State var pushSelection: Bool = false
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("Setting").font(.system(size: 24)).frame(height: 24)
                    Spacer()
                }
                Spacer().frame(height: 28)
                
                NavigationLink(destination: PremiumPurchaseView()) {
                    HStack {
                        Spacer().frame(width: 20)
                        Image("icon_huangguan").resizable().frame(width: 30, height: 30)
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Try Premium").font(.system(size: 20, weight: .medium)).foregroundColor(.textLevel1).frame(height: 24)
                            Spacer().frame(height: 8)
                            Text("Unlock all, only 0.8$ a month").font(.system(size: 14)).foregroundColor(.textLevel3).frame(height: 14)
                            Spacer()
                        }
                        Spacer()
                    }.frame(height: 72)
                        .background {
                            LinearGradient(colors: [.gradient1, .gradient2], startPoint: .leading, endPoint: .trailing)
                        }
                        .cornerRadius(15)
                }
                
                Spacer().frame(height: 16)
                
                VStack(alignment: .leading) {
                    ForEach(SettingOption.allCases) { option in
                        HStack {
                            Spacer().frame(width: 16)
                            Image(option.icon).resizable().frame(width: 24, height: 24)
                            Spacer().frame(width: 12)
                            Text(option.title).font(.system(size: 14, weight: .medium)).foregroundColor(.textLevel2)
                            Spacer()
                            Image("icon_right_arrow").resizable().frame(width: 24, height: 24)
                            Spacer().frame(width: 16)
                        }.frame(height: 58).onTapGesture {
                            self.jumpOption(option)
                        }
                    }
                }.background {
                    Color.white
                }.cornerRadius(16)
                Spacer()
                
            }.padding(.init(top: 8, leading: 16, bottom: 0, trailing: 16))
    }
    
    func jumpOption(_ option: SettingOption) {
        
    }
    
    func jumpPremium() {
        PremiumService.routeToPremium()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
