//  Motivation
//
//  Created by Sergey Leschev on 15.08.21.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    static let tag: String? = "Settings"
    var items = Items()
    @State private var showBuying = false
    var body: some View {
                    
            VStack {
                
                List {
                    
                    Section(header: Text("Reminders")) {
                        NavigationLink(destination: ReminderView()) {
                            HStack {
                                Image(systemName: "bell.badge.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.8829154968, green: 0.7193002105, blue: 0.248141557, alpha: 1)))
                                Text("Reminders")
                            }
                        }
                    }
                    
                    Section(header: Text("Legal")) {
                        ForEach(items.legal, id: \.self) { item in
                            Link(destination: URL(string: "\(item.url)")!) {
                                SettingsRowView(item: item)
                            }
                            
                        }
                    }
                    
                    /*
                    Section(header: Text("Feedback")) {
                        ForEach(items.feedback, id: \.self) { item in
                            Link(destination: URL(string: "\(item.url)")!) {
                                SettingsRowView(item: item)
                            }
                            
                        }
                    }
                    */
                    
                    /*
                    Section(header: Text("Miscellaneous")) {
                        ForEach(items.miscellaneous, id: \.self) { item in
                            Link(destination: URL(string: "\(item.url)")!) {
                                SettingsRowView(item: item)
                            }
                        }
                    }
                     */
 
                    
                }.listStyle(GroupedListStyle())
//                .navigationBarTitle("Settings")
//                .navigationBarTitleDisplayMode(.inline)
            }
        //}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
