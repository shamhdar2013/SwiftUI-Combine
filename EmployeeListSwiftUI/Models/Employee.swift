//
//  Employee.swift
//  DummyContacts
//
//  Created by radhika sharma on 2/11/24.
//

import Foundation

struct Employee: Codable, Equatable {
    var id: Int?
    var name: String?
    var salary: Int?
    var age: Int?
    var picture: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        case profileImage = "profile_image"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.salary = try container.decodeIfPresent(Int.self, forKey: .salary)
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.picture = try container.decodeIfPresent(String.self, forKey: .profileImage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(salary, forKey: .salary)
        try container.encode(age, forKey: .age)
        try container.encode(picture, forKey: .profileImage)
    }
}

struct EmployeeGroup: Codable {
    var employees: [Employee]?
    var status: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
        case message = "message"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.employees = try container.decodeIfPresent([Employee].self, forKey: .data)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(employees, forKey: .data)
        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
    }
}
