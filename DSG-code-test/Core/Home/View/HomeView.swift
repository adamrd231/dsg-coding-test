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
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E, d MMM yyyy h:mm a"
            return Text(dateFormatterPrint.string(from: date))
        }
        
        return Text("")
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)

            
            Form {
                ForEach(vm.events, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event).environmentObject(vm)) {
                        HStack {
                            
                            
                            ZStack {

                                ImageView(imageURL: event.performers?.first?.image ?? "", imageName: "\(event.performers?.first?.name ?? "1")")
                                    .frame(width: 75, height: 75)
                                    .clipped()
                                    .cornerRadius(7)
                                    
                                
                                
                                if vm.favorites.contains(event.title ?? "na") {
                                        
                                        Image(systemName: "suit.heart.fill")
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing)
                                            .foregroundColor(.pink)
                                            .offset(x: -25, y: -33)
                                    
                                    
                                }
                            }
                            
                                
            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(event.title ?? "")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    
                                HStack(spacing: 1) {
                                    Text(event.venue?.city ?? "")
                                    Text(",")
                                    Text(event.venue?.state ?? "")
                                        
                                }.font(.caption)
                                .foregroundColor(.gray)
                                createDateFormat(dateString: event.datetime_local)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            if !vm.searchText.isEmpty {
                vm.seatGeekDataService.getEvents(text: vm.searchText)
            } else {
                vm.seatGeekDataService.getEvents(text: "")
            }
            
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
