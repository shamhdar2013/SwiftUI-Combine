//
//  EmployeeViewModel.swift
//  DummyContacts
//
//  Created by radhika sharma on 2/11/24.
//

import Foundation
import SwiftUI

struct EmployeeViewModel: Identifiable {
    let employee: Employee
    static let numberFormatter = NumberFormatter()
    init(employee: Employee) {
        self.employee = employee
        EmployeeViewModel.numberFormatter.numberStyle = .decimal
    }
    
    var id: Int {
        employee.id ?? 0
    }
    
    var name: String {
        employee.name ?? ""
    }
    
    var age: Int {
         employee.age ?? 0
    }
    
    var salary: String {
        if let salary = employee.salary {
            let formattedSalary = EmployeeViewModel.numberFormatter.string(from: NSNumber(value: salary))
            return formattedSalary ?? ""
        } else {
            return ""
        }
    }
    
    var picture: Image {
        return Image(systemName: "person.circle.fill")
    }
}


struct EmployeeGroupViewModel {
    let employeeGroup: EmployeeGroup
    
    var employees:[EmployeeViewModel] {
        if let employees = employeeGroup.employees {
            employees.map(EmployeeViewModel.init)
        } else {
            []
        }
    }
    var message: String? {
        employeeGroup.message
    }
    var success: Bool {
        return (employeeGroup.status?.caseInsensitiveCompare("success") == .orderedSame)
    }
}
