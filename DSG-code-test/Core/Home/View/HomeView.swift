//
//  ContentView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $vm.searchText)

            List {
                ForEach(vm.events, id: \.id) { event in
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
                            Text(event.datetime_local ?? "N/A")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    
                    
                }
                .navigationTitle("")
                .navigationBarHidden(true)
                
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
