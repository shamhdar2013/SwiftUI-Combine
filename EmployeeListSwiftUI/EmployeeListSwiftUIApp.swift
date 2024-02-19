//
//  EmployeeListSwiftUIApp.swift
//  EmployeeListSwiftUI
//
//  Created by radhika sharma on 2/14/24.
//

import SwiftUI

@main
struct EmployeeListSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let employeeVM = EmployeesListViewModel(dataFetcher: DataProvider())
            ContentView(viewModel: employeeVM)
        }
    }
}
