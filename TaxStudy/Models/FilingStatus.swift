//
//  FilingStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

enum FilingStatus : String, Codable, CaseIterable {
    case single = "Single"
    case marriedFilingJointly = "Married Filing Jointly"
    case marriedFilingSeparately = "Married Filing Separately"
    case qualifiedWidow = "Qualified Widow"
    case headOfHousehold = "Head of Household"
}
