//
//  ContentView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State var showDetailView: Bool = false
    
    func createDateFormat(dateString: String) -> Text {
        
        let string = dateString + "+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: string) {
            print("Date: \(date)")
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E, d MMM yyyy h:mm a"
            return Text(dateFormatterPrint.string(from: date))
        }
    
        
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day, .hour], from: date)
//
//        let finalDate = calendar.date(from:components)
        
        return Text("")
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)

            List {
                ForEach(vm.events, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                        HStack {
                            ImageView(imageURL: event.performers?.first?.image ?? "", imageName: "\(event.performers?.first?.name ?? "1")")
                                .frame(width: 75, height: 75)
                                .clipped()
                                .cornerRadius(7)
                                
            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(event.title ?? "")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    
                                HStack {
                                    Text(event.venue?.city ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(event.venue?.state ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                createDateFormat(dateString: event.datetime_local)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                    
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
