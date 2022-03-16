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
        VStack(alignment: .leading, spacing: 0) {
            SearchBarView(searchText: $vm.searchText)
            ScrollView {
                ForEach(vm.events, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event).environmentObject(vm)) {

                        HStack(spacing: 0) {
                            
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
                            .padding()
 
                            VStack(alignment: .leading, spacing: 1) {
                                Text(event.title ?? "")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    
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
                            Spacer()
                        }
                        
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .shadow(radius: 3, x: 3, y: 3)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            if !vm.searchText.isEmpty {
                vm.seatGeekDataService.getEvents(text: vm.searchText)
            } else {
                vm.seatGeekDataService.getEvents(text: "")
            }
            
        })
  
       
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
