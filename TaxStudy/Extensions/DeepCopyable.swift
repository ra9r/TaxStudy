//
//  DeepCopyable.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//

protocol DeepCopyable {
    associatedtype T
    var deepCopy: T { get }
}
