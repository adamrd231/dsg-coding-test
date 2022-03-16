//
//  DetailView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct DetailView: View {
    
    @State var event: Event
    @EnvironmentObject var vm: HomeViewModel
    @State var isFavorite: Bool = false
    
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
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(event.title?.description ?? ":")
                    .font(.title3)
                    .fontWeight(.bold)
                    
                Spacer()
                Image(systemName: vm.favorites.contains(event.title ?? "") ?? false ? "suit.heart.fill" : "suit.heart")
                    .padding(.trailing)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        if vm.favorites.contains(event.title ?? "na") {
                            vm.removeEvent(event.title ?? "qa")
                        } else {
                            vm.addEvent(event.title ?? "na")
                        }
                    }
            }
            
            HStack {
                Spacer()
                ImageView(imageURL: event.performers?.first?.image ?? "", imageName: event.performers?.first?.name ?? "1")
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 200, alignment: .center)
                    .shadow(radius: 5, x: 5)
                Spacer()
            }
            .padding(.top)
            createDateFormat(dateString: event.datetime_local)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top)
            HStack(spacing: 0) {
                Text(event.venue?.city ?? "")
                Text(",")
                Text(event.venue?.state ?? "")
        
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Details")

        .navigationBarTitleDisplayMode(.inline)
        
    }
}

