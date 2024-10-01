//
//  FilingStatus.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

enum FilingStatus : Codable, CaseIterable {
    case single
    case marriedFilingJointly
    case marriedFilingSeparately
    case qualifiedWidow
    case headOfHousehold
}
