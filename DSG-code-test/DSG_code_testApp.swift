//
//  DSG_code_testApp.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import SwiftUI

@main
struct DSG_code_testApp: App {
    
    init() {
   
        UINavigationBar.appearance().backgroundColor = UIColor(Color.theme.backgroundColor)
    }
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
       
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(vm)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
}
