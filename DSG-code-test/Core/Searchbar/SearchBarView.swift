//
//  SearchBarView.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ZStack {
                    Rectangle()
                        .frame(height: 40)
                        .background(Color.theme.searchBar)
                        .cornerRadius(25)
                    
                    HStack(alignment: .top) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                        TextField("Search By Name or Symbol...", text: $searchText)
                            .foregroundColor(Color.white)
                            .disableAutocorrection(true)
                            .overlay(
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x: 10)
                                    .foregroundColor(Color.white)
                                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                    .onTapGesture {
                                        searchText = ""
                                    }
                                ,alignment: .trailing
                            )
                            
                        
                    }
                    .padding()
                }
                Button(action: {
                    searchText = ""
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                }
                
            }
            
        }
        .frame(height: 75)
        .padding()
        .background(Color.theme.backgroundColor)
        .edgesIgnoringSafeArea(.top)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("duh"))
    }
}
