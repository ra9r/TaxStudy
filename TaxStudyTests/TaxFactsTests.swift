//
//  TaxFactsTests.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import Testing
import Foundation

@testable import TaxStudy

final class TaxFactsTests {
    
    // Define the path relative to the test file
    var sample2024TaxFactsPath: URL {
        let currentDirectory = URL(fileURLWithPath: #file).deletingLastPathComponent()
        return currentDirectory.appendingPathComponent("Samples/2024TaxFacts.txcfg")
    }
    
    @Test func testSimpleWageSelfEmployed() async throws {
        // Ensure the file exists
        let fileURL = sample2024TaxFactsPath
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            #expect(Bool(false), "File not found: \(fileURL.path)")
            return
        }
        
        // Load the data from the file
        let data = try Data(contentsOf: fileURL)
        
        // Decode the data into your model
        let decoder = JSONDecoder()
        let facts = try decoder.decode([TaxFacts].self, from: data)
        
        #expect(facts.count == 1)
    }
}

