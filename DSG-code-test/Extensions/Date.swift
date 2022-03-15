//
//  Date.swift
//  DSG-code-test
//
//  Created by Adam Reed on 3/14/22.
//

import Foundation
 
extension Date {
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }

        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
      
        return formatter
    }

    
    func asDateString(date: Date) -> String {
        let day = date.get(.day)
        return "\(day)"
    }
}
