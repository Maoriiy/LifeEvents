//
//  DetailReminderView.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/7/6.
//

import SwiftUI

struct DetailReminderView: View {
    
    enum ReminderStyle {
        case serious
        case gentle
    }
    
    enum FrequencyType: String {
        case Daily
        case Weekly
        case Monthly
    }
    
    @State var reminderStyle: ReminderStyle = .serious
    
    @State var presentTimeSheet = false
    
    @State var date = Date()
    
    @State var dateStr: String = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: Date())
    }()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    @State var presentFrequencySheet = false
    
    @State var frequencyStr = "Daily"
     
    let copywriteTexts = [ "Get up","Speed up" , "Hurry up!", "Get anxious", "Aren't you in a hurry?" ]
    
    var body: some View {
        VStack {
            Group {
                Spacer().frame(height: 20)
                HStack {
                    Spacer().frame(width: 16)
                    Text("Reminder style").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                    Spacer()
                }
                Spacer().frame(height: 20)
                reminderSelectView
                Spacer().frame(height: 12)
                Banner().frame(height: 60).padding([.leading, .trailing], 16)
                Spacer().frame(height: 17)
            }
            
            HStack {
                Spacer().frame(width: 16)
                Text("Copywriting Library").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                Spacer()
                Image("icon_right_arrow").resizable().frame(width: 24, height: 24)
                Spacer().frame(width: 16)
            }.frame(height: 56)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [.init(.fixed(28)), .init(.fixed(28))], spacing: 12) {
                    ForEach(Range(uncheckedBounds: (0, copywriteTexts.count))) { index in
                        CapsuleLabel(text: copywriteTexts[index], fillColor: .green1)
                    }
                }.padding([.leading, .trailing], 16)
            }
            
            Spacer().frame(height: 32)
            HStack {
                Spacer().frame(width: 16)
                Text("Reminder Time").font(.system(size: 16, weight: .medium)).foregroundColor(.textLevel1)
                Spacer()
            }
            Spacer().frame(height: 20)
            HStack {
                Spacer().frame(width: 12)
                Text("Time").font(.system(size: 16)).foregroundColor(.textLevel1)
                Spacer()
                Text(dateStr).font(.system(size: 16)).foregroundColor(.textLevel1)
                Spacer().frame(width: 8)
                Image("icon_right_arrow").resizable().frame(width: 24, height: 24)
                Spacer().frame(width: 12)
            }.frame(height: 56).padding([.leading, .trailing], 16).background {
                RoundedRectangle(cornerRadius: 8).fill(Color.white).padding([.leading, .trailing], 16)
            }.onTapGesture {
                presentTimeSheet = true
            }.sheet(isPresented: $presentTimeSheet, onDismiss: {
                dateStr = dateFormatter.string(from: date)
            }) {
                TimePicker(date: $date, present: $presentTimeSheet).presentationDetents([.height(318)])
                
            }
            Spacer().frame(height: 16)
            HStack {
                Spacer().frame(width: 12)
                Text("Frequency").font(.system(size: 16)).foregroundColor(.textLevel1)
                Spacer()
                Text(frequencyStr).font(.system(size: 16)).foregroundColor(.textLevel1)
                Spacer().frame(width: 8)
                Image("icon_right_arrow").resizable().frame(width: 24, height: 24)
                Spacer().frame(width: 12)
            }.frame(height: 56).padding([.leading, .trailing], 16).background {
                RoundedRectangle(cornerRadius: 8).fill(Color.white).padding([.leading, .trailing], 16)
            }.onTapGesture {
                presentFrequencySheet = true
            }.sheet(isPresented: $presentFrequencySheet, onDismiss: {
                print(frequencyStr)
            }) {
                FrequencyPicker(frequency: $frequencyStr, present: $presentFrequencySheet)
                    .presentationDetents([.height(318)])
            }
            Spacer()
        }
    }
    
    var reminderSelectView: some View {
        HStack {
            Spacer().frame(width: 16)
            Button {
                reminderStyle = .serious
            } label: {
                ZStack {
                    Text("Serious approach").font(.system(size: 14)).foregroundColor(.white)
                    VStack {
                        Spacer().frame(height: 8)
                        HStack {
                            Spacer()
                            Image(reminderStyle == .serious ? "icon_selected_white" :  "icon_unselected").resizable().frame(width: 16, height: 16)
                            Spacer().frame(width: 8)
                        }
                        Spacer()
                    }
                }
            }.frame(width: (.screenWidth - 44) / 2,height: 60)
                .background {
                RoundedRectangle(cornerRadius: 8).fill(Color(hex: 0xFF6341))
            }
            Spacer().frame(width: 12)
            Button {
                reminderStyle = .gentle
            } label: {
                ZStack {
                    VStack {
                        Spacer().frame(height: 8)
                        HStack {
                            Spacer()
                            Image(reminderStyle == .gentle ? "icon_selected_white" :  "icon_unselected").resizable().frame(width: 16, height: 16)
                            Spacer().frame(width: 8)
                        }
                        Spacer()
                    }
                    Text("Gentle approach").font(.system(size: 14)).foregroundColor(.white)
                }
            }.frame(width: (.screenWidth - 44) / 2,height: 60)
                .background {
                RoundedRectangle(cornerRadius: 8).fill(Color(hex: 0x8DD42C))
            }
            Spacer().frame(width: 12)
            
        }.frame(height: 60)
    }
}

struct Banner: View {
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            Image("icon_banner").resizable().frame(width: 40, height: 40)
            Spacer().frame(width: 10)
            VStack(alignment: .leading) {
                Spacer().frame(height: 12)
                Text("Life Events").font(.system(size: 14, weight: .medium)).foregroundColor(.textLevel1)
                Text("Aren't you in a hurry?").font(.system(size: 14)).foregroundColor(.textLevel2)
                Spacer().frame(height: 12)
            }
            Spacer()
            VStack {
                Spacer().frame(height: 12)
                Text("now").font(.system(size: 14)).foregroundColor(.textLevel2)
                Spacer()
            }
            Spacer().frame(width: 10)
        }.background {
            RoundedRectangle(cornerRadius: 8).fill(Color.white)
        }
    }
}

struct CapsuleLabel: View {
    let text: String
    let fillColor: Color
    var body: some View {
        VStack {
            Spacer().frame(height: 8)
            HStack {
                Spacer().frame(width: 16)
                Text(text).font(.system(size: 12)).foregroundColor(.white)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 8)
        }.background {
            RoundedRectangle(cornerRadius: 14).fill(fillColor)
        }
    }
}


struct TimePicker: View {
    
    @Binding var date: Date
    @Binding var present: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer().frame(width: 16)
                Text("Cancel").foregroundColor(.init(hex: 0x969799)).font(.system(size: 14)).onTapGesture {
                    present = false
                }
                Spacer()
                Text("Select a time").foregroundColor(.init(hex: 0x323233)).font(.system(size: 16, weight: .medium))
                Spacer()
                Text("Done").foregroundColor(.init(hex: 0xACDF41)).font(.system(size: 14)).onTapGesture {
                    present = false
                }
                Spacer().frame(width: 16)
            }.frame(height: 48)
            DatePicker("", selection: $date, displayedComponents: [.hourAndMinute]).datePickerStyle(.wheel).frame(height: 270)
        }.edgesIgnoringSafeArea(.all).background {
            Color.clear
        }.frame(height: 318)
    }
}

struct FrequencyPicker: View {
    
    @Binding var frequency: String
    @Binding var present: Bool
    
    let strs = [DetailReminderView.FrequencyType.Daily.rawValue, DetailReminderView.FrequencyType.Weekly.rawValue, DetailReminderView.FrequencyType.Monthly.rawValue]
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer().frame(width: 16)
                Text("Cancel").foregroundColor(.init(hex: 0x969799)).font(.system(size: 14)).onTapGesture {
                    present = false
                }
                Spacer()
                Text("Select a time").foregroundColor(.init(hex: 0x323233)).font(.system(size: 16, weight: .medium))
                Spacer()
                Text("Done").foregroundColor(.init(hex: 0xACDF41)).font(.system(size: 14)).onTapGesture {
                    present = false
                }
                Spacer().frame(width: 16)
            }.frame(height: 48)
            
            Picker("", selection: $frequency) {
                ForEach(strs, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.wheel).frame(height: 270)

        }.edgesIgnoringSafeArea(.all).background {
            Color.clear
        }.frame(height: 318)
    }
}
