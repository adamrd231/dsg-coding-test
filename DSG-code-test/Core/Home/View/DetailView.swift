//
//  DetailView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct DetailView: View {
    
    let event: Event
    
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
        VStack(alignment: .leading) {
            Text(event.title?.description ?? ":")
                
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            HStack {
                Spacer()
                ImageView(imageURL: event.performers?.first?.image ?? "", imageName: event.performers?.first?.name ?? "1")
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 200, alignment: .center)
                    .padding()
                    .shadow(radius: 5, x: 5)
                Spacer()
            }
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

